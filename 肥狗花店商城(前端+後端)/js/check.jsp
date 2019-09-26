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
	   Connection con = DriverManager.getConnection(url, "root", "yasuogod666");
	   String user = request.getParameter("account");
	   String user_pwd = request.getParameter("pwd_mem");
	   
	   if(con.isClosed())
		out.print("connection failure");
	   else
	   {
		   con.createStatement().execute("USE project");
		   String temp ="";
		   sql = "SELECT * FROM member WHERE id='"+user+"' ";
		   ResultSet user_check = con.createStatement().executeQuery(sql);
		   boolean no = con.createStatement().execute(sql);
			              user_check = con.createStatement().executeQuery(sql);
		                  while(user_check.next()) 
						  {
	               	             temp = user_check.getString("pwd");
		                  }
                          if(temp.equals(user_pwd))
			              {
			                       out.print("登入成功！即將跳往會員中心頁面！");
                                   out.print("<meta http-equiv='refresh' content='3; url=show_mem_own.jsp'>");				 
			              }
		                  else
		                  {
			                       out.print("登入失敗，"+"<a href='login.html'>按我重新登入</a>");
		                  }
		   
	   }

	   con.close();
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