<!--單純顯適用
後台顯示專用
-->
<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
<%@page language="java" import= "Shop_imp.*,java.util.*"%>     
</head>
<body>
<% request.setCharacterEncoding("UTF-8");%>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");   //使用JDBC連結		
	try
	{
	   String url="jdbc:mysql://127.0.0.1/";
	   String sql;
	   Connection con = DriverManager.getConnection(url, "root", "1234");
	   int totalprice =0;
	   String totalName = "";
	   int totalNum = 0;
	    
	   
	   	   
	   if(con.isClosed())
		out.print("connection failure");
	   else   
	   {
		   
		    
            if(session.getAttribute("id")!=null)      //要登入才能購物
			{	
			con.createStatement().execute("USE carts");
			Object getuser = session.getAttribute("id");
		    String user = String.valueOf(getuser);
			
			
			//////////開始計算總價格/////////////
			sql = "SELECT product, productNum, price FROM "+user+" ";
       		Statement s2 = con.createStatement(); //Statement由createStatement所產生
			ResultSet r2 = s2.executeQuery(sql);
			while(r2.next())     //用來計算總數量跟總價錢的迴圈
			{
				totalprice += (r2.getInt("price")*r2.getInt("productNum"));
				totalName += r2.getString("product"); 
				totalName += "<br><br>";
				totalNum  += r2.getInt("productNum");
			}
			
			
			////////////開始顯視購物車內容////////////
	        out.print("會員"+user+"您好！<br><br>");
			
			sql = "SELECT * FROM "+user+" ";
			Statement s3 = con.createStatement(); //Statement由createStatement所產生
			ResultSet r3 = s3.executeQuery(sql);
			while(r3.next())
			{      
		        int for_del = r3.getInt("no");
				out.print("<form name='delproduct' action='shop_del.jsp'>");
				out.print(r3.getString("product")+"共"+Integer.toString(r3.getInt("productNum"))+"個，"+Integer.toString(r3.getInt("productNum")*r3.getInt("price"))+"元");
                out.print("<input type='submit' value='刪除'><br>");
				out.print("<input type='hidden' name='del_choose' value='"+for_del+"'>");
				out.print("</form>");			
 			}
			
		    out.print("<br><br>您訂購得總數量："+totalNum+"<br><br>");
			out.print("總金額："+Integer.toString(totalprice)+"元");
			

			
			}
			else
			{
			     out.print("您尚未登入喔！請先登入！");	
			}

			con.close();
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