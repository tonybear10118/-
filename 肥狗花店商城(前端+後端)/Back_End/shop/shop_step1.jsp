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
			con.createStatement().execute("USE project");
			Statement s = con.createStatement(); //Statement由createStatement所產生
            ResultSet r = s.executeQuery("SELECT COUNT(*) AS rowcount FROM product");
            r.next();
            int count = (r.getInt("rowcount"));
			String[] product_name = new String[count];
			int[] prodcut_price = new int[count];
	        int[] inventory = new int[count];
			int i =0;

			r = s.executeQuery("SELECT productName, price, inventory FROM product");
			while(r.next())
			{
				product_name[i] = r.getString("productName");
				prodcut_price[i] = Integer.parseInt(r.getString("price"));
				inventory[i] = Integer.parseInt(r.getString("inventory"));
				i++;				
			}
			//產品
			out.print("<form name='' action='shop_step2.jsp' method='POST'>");
			out.print("選擇想訂購的產品：");
			out.print("<select name='product_choose'>");
			for(int p =1; p<=count; p++)
			{
			     out.print("<option>"+product_name[p-1]);
			}
			out.print("</select>&nbsp;&nbsp;");
			
			
			//用JavaScript確認選擇的產品
			/////////////////////////////////////////
			out.print("<script>");
			out.print("");
            out.print("</script>");			
			/////////////////////////////////////////
			
			
			out.print("<input type='submit' value='下一步'><br><br>");	out.print("<strong>注意！下一步將無法更改選擇產品！</strong>");			
			
			
			out.print("</form>");
			
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