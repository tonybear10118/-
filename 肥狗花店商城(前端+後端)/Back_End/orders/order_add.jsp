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
<% request.setCharacterEncoding("UTF-8");%>
<%
    try{
	Class.forName("com.mysql.jdbc.Driver");   //使用JDBC連結		
	try
	{
	   String url="jdbc:mysql://127.0.0.1/";
	   String sql;
	   Connection con = DriverManager.getConnection(url, "root", "1234");
	   Connection con2 = DriverManager.getConnection(url, "root", "1234");
	   int totalprice =0;
	   String totalName = "";
	   int totalNum = 0;
	   Object getuser = session.getAttribute("id");
	   String user = String.valueOf(getuser);
	    
	   
	   	   
	   if(con.isClosed())
		out.print("connection failure");
	   else   
	   {
	   
		   
              if(session.getAttribute("id")!=null)
	          {
		        con.createStatement().execute("USE carts");
				con2.createStatement().execute("USE project2");
			    
			
			
			//////////開始計算總價格/////////////
			sql = "SELECT product, productNum, price FROM "+user+" ";
       		Statement s2 = con.createStatement(); //Statement由createStatement所產生
			ResultSet r2 = s2.executeQuery(sql);
			while(r2.next())     //用來計算總數量跟總價錢的迴圈
			{
				totalprice += (r2.getInt("price")*r2.getInt("productNum"));
				//totalName += r2.getString("product"); 
				//totalName += "<br><br>";
				totalNum  += r2.getInt("productNum");
			}
			
			
			////////////開始顯視購物車內容////////////
	        //out.print("會員"+user+"您好！<br><br>");
			
			sql = "SELECT * FROM "+user+" ";
			Statement s3 = con.createStatement(); //Statement由createStatement所產生
			ResultSet r3 = s3.executeQuery(sql);
			    
	        Statement s4 = con2.createStatement();
            ResultSet r4 = s4.executeQuery("SELECT * FROM member_2 WHERE id='"+user+"' ");	
            r4.next(); 			
			  
			  %>
			  <!--------------------------新增付款資訊------------------------->
			  <form method="POST" action="order_add_action.jsp">
			  <table border="3">
			  <tr><td colspan="2" align="center">訂購會員：<%=user%>
			  <input type="hidden" value="<%=user%>" name="orderuser">
			  </td></tr>
			  
			  
			  <tr>
			  <td align="center" colspan="2">以下為你的訂購內容：</td>
			  </tr>
			  <tr>
			  <td colspan="2">
			  <%			  
              while(r3.next())
			  {      
		      
                totalName += r3.getString("product")+", ";
				out.print(r3.getString("product")+"共"+Integer.toString(r3.getInt("productNum"))+"個，"+Integer.toString(r3.getInt("productNum")*r3.getInt("price"))+"元<br>");
			  }  
			  %>
              			  
			  </td>
			  </tr>
			  
			  <tr>
			  <td colspan="2">
			  總訂購數量：<%=totalNum%>個
			  <input type="hidden" value="<%=totalNum%>" name="ordernum">
			  </td></tr>
			  <tr>
			  <td colspan="2">
			  總訂購金額：<%=totalprice%>元
			  <input type="hidden" value="<%=totalprice%>" name="totalPrice">
			  <input type="hidden" value="<%=totalName%>" name="totalName">
			  </td>
			  </tr>
			  
			  <tr><td>	          
              請選擇想付款的方式：</td>
			  <td>
			  
			  <select name="give_method">
			  
			  <option value="貨到付款">貨到付款
			  <option value="宅配">宅配
			  <option value="來店自取">來店自取  
			  <select> 
			  </td>
			  </tr>
			  
			  <tr>
			  <td>請填寫收件地址(預設)：</td>
			  <td><textarea name="Address"><%=r4.getString("address")%></textarea></td>
			  </tr>
			  
			  <tr>
			  <td>請填寫手機號碼(選填)</td>
			  <td>
			  <input type="number" name="Phone_num" value="09" required>
			  </td>
			  </tr>
			  
			  <tr>
			  <td align="center" colspan="2">
			  <b><input type="submit" value="送出訂單"></b>
			  </td>
			  </tr>
			  
              </form>
              </table>
			  
              <!-----------------------------新增付款資訊--------------->
              <%			   
	          
	          }  //登入if判斷
			 if(session.getAttribute("id")==null)
			      out.print("<font color='red'><strong>您尚未登入喔！請先登入！</strong></font>");
			 
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