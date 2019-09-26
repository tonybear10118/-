

<!--此jsp用來顯是全部會員-->

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
			
			
			sql = "SELECT * FROM member_1";
			ResultSet tmp1 = con.createStatement().executeQuery(sql);
			
			
			
			while(tmp1.next())
			{
				for(int i=1; i<=3; i++)
				{
                    if(i==1)
						out.print("會員編號："+tmp1.getString(i)+"<br>");
					else if (i==2)
						out.print("會員帳號："+tmp1.getString(i)+"<br>");  
					else if (i==3)
						out.print("身分證字號："+tmp1.getString(i)+"<br>");
					else
					{};
 				}
				
				
				String forbug = tmp1.getString("id");
				
				sql = "SELECT * FROM member_2 WHERE id = '"+forbug+"' ";
			    ResultSet tmp2 = con.createStatement().executeQuery(sql);
			    tmp2.next();
				
				out.print("會員密碼："+tmp2.getString("pwd")+"<br>");
					
				out.print("會員手機號碼："+tmp2.getString("phonenum")+"<br>");
					
				out.print("性別："+tmp2.getString("sex")+"<br>");
					
				out.print("住址："+tmp2.getString("address")+"<br>");
					
				out.print("會員信箱："+tmp2.getString("email")+"<br>");
					
					
				
				out.print("-----------------------------------------------------------------------<br><br>");
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

<form name="goback" method="GET" action="show_mem.html">
<input type="submit" value="按我返回">
</form>
</body>
</html>