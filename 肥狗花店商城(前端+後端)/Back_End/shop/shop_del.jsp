<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%> 
</head>
<body>
<% request.setCharacterEncoding("UTF-8");%>
<%try{
	Class.forName("com.mysql.jdbc.Driver");   //使用JDBC連結		
	try
	{
	   String url="jdbc:mysql://127.0.0.1/";
	   String sql;
	   Connection con = DriverManager.getConnection(url, "root", "1234");
	   int del_num = Integer.parseInt(request.getParameter("del_choose"));
	   Object getuser = session.getAttribute("id");
	   String user = String.valueOf(getuser);
	   	   
	   if(con.isClosed())
		out.print("connection failure");
	   else
	   {
		   con.createStatement().execute("USE carts");
		   sql = "DELETE FROM "+user+" WHERE no="+del_num+" ";
		   con.createStatement().executeUpdate(sql);
	    
		   out.print("<meta http-equiv='refresh' content='0;../../html/shopcart.jsp' />");
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