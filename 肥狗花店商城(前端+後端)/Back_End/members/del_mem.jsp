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
       Connection con2 = DriverManager.getConnection(url, "root", "1234");
       String del_id = request.getParameter("del_mem");
	   
	   if(con.isClosed())
		out.print("connection failure");
	   else
	   {
			con.createStatement().execute("USE project2");
			con2.createStatement().execute("USE carts");
			
            sql="DELETE FROM member_1 WHERE id = '"+del_id+"' ";
            int no = con.createStatement().executeUpdate(sql);
			
			sql="DELETE FROM member_2 WHERE id = '"+del_id+"' ";
            int no1 = con.createStatement().executeUpdate(sql);
			
			
			
			sql="DROP TABLE "+del_id+" ";
			con2.createStatement().execute(sql);
			
			
			session.removeAttribute("id");
            session.removeAttribute("password");
      
            if(no>0&&no1>0)
                 out.print("刪除會員"+del_id+"成功！！<br><br>");
            else
                 out.print("刪除會員"+del_id+"失敗！<br><br>");
			

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
<form method="POST" action="del_mem.html">
<input type="submit" value="按我返回上一頁">
</form>
</body>
</html>