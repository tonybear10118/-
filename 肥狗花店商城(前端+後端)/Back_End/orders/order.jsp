<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
<%@page language="java" import= "Shop_imp.*,java.util.*"%> 
<% request.setCharacterEncoding("UTF-8");%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>
訂單
</title>
</head>


<body>
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
			
			
			sql = "SELECT * FROM product_order_1";
			ResultSet bug = con.createStatement().executeQuery(sql);
			
			if(!bug.next()){
				out.print("還沒有訂單喔！<br><br>");
			}
			
			
            
			sql = "SELECT * FROM product_order_1";
			ResultSet tmp1 = con.createStatement().executeQuery(sql);
			
			while(tmp1.next())
			{
				
                for(int i=1; i<=3; i++)
				{
                    if(i==1)
						out.print("訂單編號："+tmp1.getInt("order_Num")+"<br>");
					else if (i==2)
						out.print("訂購會員："+tmp1.getString("order_member")+"<br>");
				
					else if (i==3)
						out.print("會員手機："+tmp1.getString("recieve_tel")+"<br>");					
					else{}
					
 				}
				
                String forbug = tmp1.getString("order_member");
                    
				sql = "SELECT * FROM product_order_2 WHERE order_member = '"+forbug+"' ";
			    ResultSet tmp2 = con.createStatement().executeQuery(sql);
		     	tmp2.next();	
					
					
					
				out.print("訂購商品："+tmp2.getString("order_product")+"<br>");
					
				out.print("訂購金額："+tmp2.getInt("price")+"<br>");
					
				out.print("運送方式："+tmp2.getString("pay_way")+"<br>");
					
				out.print("運送住址："+tmp2.getString("recieve_address")+"<br>");					
				
					
 				
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


</body>
</html>