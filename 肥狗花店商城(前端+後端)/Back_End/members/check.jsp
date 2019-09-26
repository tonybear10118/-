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
	   
	   if(con.isClosed())
		out.print("connection failure");
	   else
	   {
		   con.createStatement().execute("USE project2");

		   if(request.getParameter("account").equals("root")&&request.getParameter("pwd_mem").equals("yasuogod666"))
           {           
	            session.setAttribute("id",request.getParameter("account"));
				session.setAttribute("password",request.getParameter("pwd_mem"));
	            response.sendRedirect("../Final_back.jsp");
		   }	  
           else if(request.getParameter("account") != null && request.getParameter("pwd_mem") != null)
		   {
			   sql = "SELECT * FROM member_2 WHERE id=? AND pwd=?";
			   
			   PreparedStatement pstmt = null;
			   pstmt = con.prepareStatement(sql);
			   pstmt.setString(1,request.getParameter("account"	));
			   pstmt.setString(2,request.getParameter("pwd_mem"));
			   
			   ResultSet paperrs = pstmt.executeQuery();
			   
			   if(paperrs.next())
			   {
				   session.setAttribute("id",request.getParameter("account"));
				   session.setAttribute("password",request.getParameter("pwd_mem"));
				   
				   		   
                   
				   response.sendRedirect("show_mem_own.jsp");
				   
			   }
			   
			   else
				   out.print("帳號密碼錯誤！<a href='../../html/login.html'>按此</a>重新登入");
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