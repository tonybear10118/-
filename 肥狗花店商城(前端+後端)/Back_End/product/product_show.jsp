

<!--此jsp用來顯是全部產品資料-->

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
			
			
			sql = "SELECT * FROM product_1";
			ResultSet tmp1 = con.createStatement().executeQuery(sql);
			
			
			
			while(tmp1.next())
			{
				for(int i=1; i<=3; i++)
				{
					if(i==1)
					    out.print("產品序號："+tmp1.getString(i)+"<br>");
                    else if(i==2)
						out.print("產品名稱："+tmp1.getString(i)+"<br>");
					
					else if (i==3)
						out.print("產品圖片名稱："+tmp1.getString(i)+"<br>");
					else
					{};
 				}
				
				String forbug = tmp1.getString("productName");
				
				
				sql = "SELECT * FROM product_2 WHERE productName = '"+forbug+"' ";
			    ResultSet tmp2 = con.createStatement().executeQuery(sql);
			    tmp2.next();
				

	            out.print("產品價格："+tmp2.getString("price")+"元(台幣)"+"<br>");
			    out.print("產品庫存："+tmp2.getString("inventory")+"個<br>");

 				
				
				
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

<form name="goback" method="GET" action="product_show.html">
<input type="submit" value="按我返回">
</form>
</body>
</html>