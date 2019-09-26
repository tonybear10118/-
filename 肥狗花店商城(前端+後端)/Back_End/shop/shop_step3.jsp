<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
<%@page language="java" import= "Shop_imp.*,java.util.*"%>     

<% request.setCharacterEncoding("UTF-8");%>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");   //使用JDBC連結		
	try
	{
	   String url="jdbc:mysql://127.0.0.1/";
	   String sql;
	   Connection con = DriverManager.getConnection(url, "root", "1234");
	   String product_name = request.getParameter("choose_name");
	   int product_num = Integer.parseInt(request.getParameter("input_num"));
	   
	   

	   int product_price = Integer.parseInt(request.getParameter("input_price"));
	   
	   
	   int totalprice =0;
	   String totalName = "";
	   int totalNum = 0;
	   int checkNum = Integer.parseInt(request.getParameter("check_num"));
	    
	   
	   	   
	   if(con.isClosed())
		out.print("connection failure");
	   else   
	   {
		    if(product_num>checkNum)
			{
				out.print("<font color='red'><strong>您所需的的數量大於庫存！無法添入購物車！</strong></font><br><br>");				
			}
		    
            else if(session.getAttribute("id")!=null)      //要登入才能購物
			{	
			con.createStatement().execute("USE carts");
			Object getuser = session.getAttribute("id");
		    String user = String.valueOf(getuser);
			
            ///////////計算現在是第幾筆資料//////
			sql = "SELECT MAX(no) FROM "+user+" ";
			Statement s3 = con.createStatement();
			ResultSet r3 = s3.executeQuery(sql);
			int count = 0;
            if(r3.next())
			{

				count = r3.getInt(1);
				count++;
			}
			else
			{
            count = 1;  //count是為了用來加入購物車總金額(最後一筆資料)
			}
			
			///////////輸入商品資料//////////////			

            sql = "SELECT * FROM "+user+" WHERE product='"+product_name+"' ";	//假設已有同樣產品，用此來合體
            boolean no = con.createStatement().execute(sql);
            if(no=true)     //當使用者沒有先前此商品時    
			{
			 sql  = "INSERT "+user+"(no, userName, product, productNum, price) ";
			 sql += "VALUES ('"+count+"', '"+user+"', '"+product_name+"', '"+product_num+"', '"+product_price+"')";
		     con.createStatement().execute(sql);	
			}
			else      //當有這項產品時
			{ 
		     Statement s2 = con.createStatement();
			 ResultSet r2 = s2.executeQuery(sql);
			 int temp = 0;
			 int temp2 = product_num; //
			 while(r2.next())
			 {
				product_num = (r2.getInt("productNum")+product_num);
				product_price = (r2.getInt("productNum")+temp2)*r2.getInt("price");
			    temp = r2.getInt("no");
			 }
			 
			 sql = "UPDATE "+user+" SET productNum = "+product_num+" WHERE no="+temp+" ";	
			 con.createStatement().executeUpdate(sql);
			 
			 sql = "UPDATE "+user+" SET price = "+product_price+" WHERE no="+temp+" ";	
			 con.createStatement().executeUpdate(sql);
			}
			out.print("新增購物車成功！<a href='../../html/shopcart.jsp'>按我</a>前網購物車！");
	
            
			
			}
			else
			{
			     out.print("您尚未登入喔！請先登入！");	
			}

			//con.close();
	   }
	} //try   
	
	catch(SQLException sExec)
	{
		out.print("SQL錯誤！"+sExec.toString());
	}
	
}
catch(ClassNotFoundException err){
	out.print("Class錯誤"+err.toString());
}
%>
</body>
</html>