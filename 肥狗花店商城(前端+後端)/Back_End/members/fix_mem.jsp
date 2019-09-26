<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
</head>
<body>
<%request.setCharacterEncoding("UTF-8");%>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");   //使用JDBC連結		
	try
	{
	   String url="jdbc:mysql://127.0.0.1/";
	   String sql;
	   Connection con = DriverManager.getConnection(url, "root", "1234");
       con.createStatement().execute("USE project2");
       String fix_id = request.getParameter("fix_mem");      //修改帳號
       String fixtofix = request.getParameter("fix_fixnum");   //修改值
       String fix_chosen = request.getParameter("fix_choise");    //修改選項
       


	   if(con.isClosed()){
	   out.print("connection failure"); }
	   else if(fix_chosen.equals("identify"))
	   {
			sql = "UPDATE member_1 SET identify = '"+fixtofix+"' WHERE id ='"+fix_id+"' ";
  
            int no = con.createStatement().executeUpdate(sql);
         
            if(no>0)
                 out.print("會員"+fix_id+"的"+fix_chosen+"修改成功！！");

		    con.close();
	   }
	   
	   else
	   {	
			sql = "UPDATE member_2 SET "+fix_chosen+" = '"+fixtofix+"' WHERE id = '"+fix_id+"' ";
  
            int no = con.createStatement().executeUpdate(sql);
         
            if(no>0)
                 out.print("會員"+fix_id+"的"+fix_chosen+"修改成功！！");

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