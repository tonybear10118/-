<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
<%@page language="java" import= "Shop_imp.*,java.util.*"%> 
<% request.setCharacterEncoding("UTF-8");%>
<%
   String user = request.getParameter("orderuser");
   int price = Integer.parseInt(request.getParameter("totalPrice"));
   String transport = request.getParameter("give_method");
   String address = request.getParameter("Address");
   String phone_num = request.getParameter("Phone_num");
   String totalName = request.getParameter("totalName");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");   //使用JDBC連結		
	try
	{
		 String url="jdbc:mysql://127.0.0.1/";
		Connection con = DriverManager.getConnection(url, "root", "1234");
		Connection con2 = DriverManager.getConnection(url, "root", "1234");  //刪除用
		con2.createStatement().execute("USE carts");
        con.createStatement().execute("USE project2");
		if(con.isClosed())
		      out.print("connection failure");
	    else
	    {
				
	   
	    String sql;
	    
        sql = "SELECT MAX(order_Num) FROM product_order_1 ";
		Statement s1 = con.createStatement();
		ResultSet r1 = s1.executeQuery(sql);
		int count = 0;
         if(r1.next())
		 {
          	count = r1.getInt(1);
			count++;
		 }
		 else
		 {
            count = 1;  //count是為了用來加入訂單(最後一筆資料)
		 }
		 
		 sql = "INSERT product_order_1(order_Num, order_member,recieve_tel)" +
		       "VALUES ('"+count+"', '"+user+"','"+phone_num+"')";
		 
		 boolean no1 = con.createStatement().execute(sql); //成功的話會船回false
		
            if(!no1)
			{
			  out.print("新的訂單1新增成功！<br>"); 
			  
			}
		    else
			  out.print("新增失敗，請重新來過！");
		  
		 sql = "INSERT product_order_2(order_member, order_product, price, pay_way, recieve_address)" +
		       "VALUES ('"+user+"', '"+totalName+"', '"+price+"', '"+transport+"', '"+address+"')";
		 
		 boolean no2 = con.createStatement().execute(sql); //成功的話會船回false
		
            if(!no2)
			{
			  out.print("新的訂單2新增成功！<br>"); 
			  out.print("<a href='../../html/realP.html'>回首頁</a>");
			}
		    else
			  out.print("新增失敗，請重新來過！"); 
		  
		  
		  
		 /////////////////////////刪減庫存/////////////////////
		 //因採兩個資料庫的方式程式碼效率較差，下次改進
	
		 sql = "SELECT product, productNum, price FROM "+user+" ";
       	 Statement s2 = con2.createStatement(); //Statement由createStatement所產生
		 ResultSet r2 = s2.executeQuery(sql);
		 
		 
		 
		 while(r2.next())
		 {   
	         String temp1 = r2.getString("product");
			 sql = "SELECT inventory FROM product_2 WHERE productName = '"+temp1+"' ";
		     Statement s3 = con.createStatement(); //Statement由createStatement所產生
		     ResultSet r3 = s3.executeQuery(sql);
			 r3.next();
			 int temp2 = r3.getInt("inventory");
			 temp2 -= r2.getInt("productNum");
			 
             
			 sql = "UPDATE product_2 SET inventory = '"+temp2+"' WHERE productName = '"+temp1+"' ";
		     con.createStatement().executeUpdate(sql);
		 }
		 
		 //////////////////刪除購物車////////////////////
		 sql = "TRUNCATE TABLE "+user+" ";
		 con2.createStatement().execute(sql);
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
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
			

</body>
</html>