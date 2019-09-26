<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
</head>
<body>
<% request.setCharacterEncoding("UTF-8");%>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");   		
	try
	{
	   String url="jdbc:mysql://127.0.0.1/";
	   String sql;
	   Connection con = DriverManager.getConnection(url, "root", "1234");
	   String input_name = request.getParameter("product_add");
	   int input_product_num = Integer.parseInt(request.getParameter("product_num"));
	   int input_price =  Integer.parseInt(request.getParameter("product_price"));
	   String input_img = request.getParameter("pic");
 	   
	   if(con.isClosed())
	      out.print("connection failure"); 
	   else
	   {
		  con.createStatement().execute("USE project2");
		  Statement s = con.createStatement();
          ResultSet r = s.executeQuery("SELECT COUNT(*) AS rowcount FROM product_1");
          r.next();
          int count = (r.getInt("rowcount")+1) ;
		  
		  
		  
		  sql= "INSERT product_1(productNum, productName,img) " +
		       "VALUES ('"+count+"', '"+input_name+"','"+input_img+"')";
		  int no1 = con.createStatement().executeUpdate(sql);
            
		  if(no1!=0)
		   out.print("產品<"+input_name+">表正規1新增成功!<br>"); 
		  else
		   out.print("產品<"+input_name+">表正規1新增失敗!<br>");
	   
	   
	   
	   

          sql= "INSERT product_2(productName, price, inventory) " +
		       "VALUES ('"+input_name+"', '"+input_price+"','"+input_product_num+"')";
		  int no2 = con.createStatement().executeUpdate(sql);
            
		  if(no2!=0)
		   out.print("產品<"+input_name+">表正規2新增成功!<br>"); 
		  else
		   out.print("產品<"+input_name+">表正規2新增失敗!<br>");	   
		    
	   }
       con.close(); 
		   	   
	}    
	
	catch(SQLException sExec)
	{
		out.print("SQL錯誤"+sExec.toString());
	}
	
}

catch(ClassNotFoundException err)
{
	out.print("Class錯誤"+err.toString());
}
%>
</body>
</html>