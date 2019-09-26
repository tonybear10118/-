<!--此JSP用來刪除產品資料-->
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

       String del_productName = request.getParameter("del_product");
	   
	   if(con.isClosed())
		out.print("connection failure");
	   else
	   {
			con.createStatement().execute("USE project2");
			
            sql="DELETE FROM product_1 WHERE productName = '"+del_productName+"' ";
            int no1 = con.createStatement().executeUpdate(sql);
      
            if(no1>0)
                 out.print("刪除產品正規表1"+del_productName+"成功！！<br><br>");
            else
                 out.print("刪除會員正規表2"+del_productName+"失敗！<br><br>");
			
			
			
			
			sql="DELETE FROM product_2 WHERE productName = '"+del_productName+"' ";
            int no2 = con.createStatement().executeUpdate(sql);
      
            if(no2>0)
                 out.print("刪除產品正規表2"+del_productName+"成功！！<br><br>");
            else
                 out.print("刪除會員正規表2"+del_productName+"失敗！<br><br>");
			
			
			
			
			

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
<form method="POST" action="product_fix.html">
<input type="submit" value="按我返回上一頁">
</form>
</body>
</html>