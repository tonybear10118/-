<!--此JSP用來刪除會員資料-->

<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
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
       String del_num = request.getParameter("del_mem");
	   
	   if(con.isClosed())
		out.print("connection failure");
	   else
	   {
			con.createStatement().execute("USE project2");
			
			
            sql="DELETE FROM product_order_1 WHERE order_member = '"+del_num+"' ";
            int no = con.createStatement().executeUpdate(sql);
			
			
      
            if(no>0)
                 out.print("刪除訂單(1)"+del_num+"成功！！<br><br>");
            else
                 out.print("刪除訂單(1)"+del_num+"失敗！<br><br>");
			 
			 
			 
			 
			 
			 
			sql="DELETE FROM product_order_2 WHERE order_member = '"+del_num+"' ";
            int no2 = con.createStatement().executeUpdate(sql);
			
			
      
            if(no2>0)
                 out.print("刪除訂單(2)"+del_num+"成功！！<br><br>");
            else
                 out.print("刪除訂單(2)"+del_num+"失敗！<br><br>");
			

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
<form method="POST" action="order_del.html">
<input type="submit" value="按我返回上一頁">
</form>
</body>
</html>