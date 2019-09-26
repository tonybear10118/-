<!--此JSP用來修改產品資料-->
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

       String fix_productName = request.getParameter("fix_product");      //修改產品
       String fixtofix_product = request.getParameter("fix_fixnum_product");   //修改值
       String fix_chosen_prodcut = request.getParameter("fix_choise_product");    //修改選項
       






	   if(con.isClosed())
		out.print("connection failure");
	   else
	   {
			con.createStatement().execute("USE project2");
			
			if(fix_chosen_prodcut.equals("productName"))
			{
			sql = "UPDATE product_1 SET "+fix_chosen_prodcut+" = '"+fixtofix_product+"' WHERE productName = '"+fix_productName+"' ";
  
            int no1 = con.createStatement().executeUpdate(sql);
         
            if(no1>0)
                 out.print("產品"+fix_productName+"的"+fix_chosen_prodcut+"正規表1修改成功！！<br>");
			}
			 
			 
			 
			 
			sql = "UPDATE product_2 SET "+fix_chosen_prodcut+" = '"+fixtofix_product+"' WHERE productName = '"+fix_productName+"' ";
  
            int no2 = con.createStatement().executeUpdate(sql);
         
            if(no2>0)
                 out.print("產品"+fix_productName+"的"+fix_chosen_prodcut+"正規表2修改成功！！<br>"); 
			 
			 
			 
			 
			 

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