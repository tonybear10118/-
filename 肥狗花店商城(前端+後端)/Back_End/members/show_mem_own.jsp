<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
</head>
<body>
<% request.setCharacterEncoding("UTF-8");%>
<marquee><font size="100"><strong>歡迎來到會員中心！</strong></font></marquee>
以下是你的會員資料：<br><br>
<%try{
	Class.forName("com.mysql.jdbc.Driver");   //使用JDBC連結		
	try
	{
	   String url="jdbc:mysql://127.0.0.1/";
	   String sql;
	   Connection con = DriverManager.getConnection(url, "root", "1234");
       Object getuser = session.getAttribute("id");
	   String user = String.valueOf(getuser);
	   String debug = String.valueOf(getuser);
	   
	   if(con.isClosed())
		out.print("connection failure");
	   else
	   {
		   
		    if(session.getAttribute("id")!=null)
		    {
		   
			con.createStatement().execute("USE project2");
			
			sql = "SELECT * FROM member_1 WHERE id = '"+user+"' ";
			ResultSet tmp = con.createStatement().executeQuery(sql);
			tmp.next();
			sql = "SELECT * FROM member_2 WHERE id = '"+user+"' ";
			ResultSet tmp2 = con.createStatement().executeQuery(sql);
			tmp2.next();
			
			
		    out.print("會員編號："+tmp.getString(1)+"<br>");
			out.print("會員帳號："+tmp.getString(2)+"<br>");
			out.print("會員密碼："+tmp2.getString(2)+"<br>");
			out.print("會員手機號碼："+tmp2.getString(3)+"<br>");
			out.print("性別："+tmp2.getString(4)+"<br>");
			out.print("住址："+tmp2.getString(5)+"<br>");
		    out.print("會員信箱："+tmp2.getString(6)+"<br>");
			out.print("身分證字號："+tmp.getString(3)+"<br><br>");
			
			out.print("----------------------------------------------<br><br>");
			out.print("你的訂單：<br>");
			
						
			sql = "SELECT * FROM product_order_1 WHERE order_member = '"+user+"' ";
			ResultSet tmp3 = con.createStatement().executeQuery(sql);
			if(tmp3.next())
			{
			out.print("訂單編號："+tmp3.getString(1)+"<br>");
			out.print("訂單帳號："+tmp3.getString(2)+"<br>");
			out.print("手機號碼："+tmp3.getString(3)+"<br>");
			}
			
			else 
				out.print("您尚未下訂商品喔！<br><br>");
			
			sql = "SELECT * FROM product_order_2 WHERE order_member = '"+user+"' ";
			ResultSet tmp4 = con.createStatement().executeQuery(sql);
			if(tmp4.next())
			{
			out.print("訂購產品："+tmp4.getString(2)+"<br>");
			out.print("總金額"+tmp4.getString(3)+"<br>");
			out.print("運送方式"+tmp4.getString(4)+"<br>");
		    out.print("運送地址："+tmp4.getString(5)+"<br><br>");
			}
			
			}
			
	   
%>			
            --------------------------------------------------------<br>
            修改資料請看這兒：<br><br>
            帳號名稱：<%=user%><br>
			<form name="mem_fix" method="POST" action="fix_mem.jsp">
			<input type="hidden" name="fix_mem" value="<%=user%>">
            要修改：
<select name="fix_choise">
  <option value="pwd">會員密碼
  <option value="phonenum">手機號碼
  <option value="sex">會員性別
  <option value="address">會員住址
  <option value="email">會員信箱
  <option value="identify">身分證字號
</select>

修改的值：<input type="text" name="fix_fixnum">
<br><br>
<input type="submit" value="按我修改會員資料">
</form>



			<%
			/*if(debug==null) {
				out.print("<font><strong>您尚未登入喔！請先登入！</strong></font>"); 
			} */
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
<br>
<br>
<form action="../../html/realP.html">
<input type="submit" value="回首頁" method="POST">
</form>

<form action='logout.jsp' method="POST">
<input type='submit' value='登出'>
</form>
</body>
</html>