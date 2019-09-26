<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%> 
<meta charset="UTF-8">
<title>realP</title>
<link rel="stylesheet" href="../../css/realC.css">
<script src=""></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="../../js/jquery.slidertron-1.3.js"></script>
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet" />
<link href="../../css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="../../css/fonts.css" rel="stylesheet" type="text/css" media="all" />
<link href="../../css/ac.css" rel="stylesheet" type="text/css" media="all" />
<link href="../../css/sep.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<div id="wrapper">
	    <div id="header" class="container">
			<div id="topf">
				<ul>
					<li><a href="shopcart.html">結帳</a></li>
					<li><a href="login.html">Login</a></li>
					<li><a href="mem.html">會員中心</a></li>
					<li>
					<input type="text" id="s" name="search" placeholder="Search..">
						</li>
				</ul>
			</div>
		    <div id="top">
				<ul>
					<li><a href="shopcart.html">結帳</a></li>
					<li><a href="login.html">Login</a></li>
					<li><a href="mem.html">會員中心</a></li>
					<li><form>
					<input type="text" id="s" name="search" placeholder="Search..">
					</form>	</li>
				</ul>
			</div>

			<div id="menu">

				<ul>
					<li><a href="realP.html"><img src="../images/LOGO2.png" id="LOGO" ></a></li>
					<li><a class="rubberBand"href="../../html/realP.html">Homepage</a></li>
					<li><a href="about.html">about us</a></li>
					<li class="dis"><a href="plant.html">盆栽/植物</a>
					    <ul>
							<li><a href="flower.html">Flower</a></li>
							<li><a href="plant.html">Plant</a></li>
							<li><a href="#">Link 3</a></li>
						</ul>
					</li>				
					<li><a href="login.html">花器/工具</a></li>
					
					<li><a href="customer.html">客服專區</a></li>
				</ul>
			</div>
		</div>


			<div id="shopcar1">
				<ul>
					<li>
					
					<a id="shopcar2" href="../../html/shopcart.jsp"><img src="../images/shopcar.jpg" alt="" /></a>
					</li>
				</ul>
			</div>
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
			Statement s = con.createStatement(); //Statement由createStatement所產生
			String product_choose = request.getParameter("product_choose");
			sql = "SELECT price,inventory FROM product_2 WHERE productName='"+product_choose+"'";
			ResultSet r = s.executeQuery(sql);
			r.next();
			int product_choose_left = r.getInt("inventory");  //
			int product_choose_price = r.getInt("price");
			String temp_price = Integer.toString(product_choose_price);
			
									
			//產品
			out.print("<form name='postto3' action='shop_step3.jsp' method='POST' target='_self'>");
			out.print("選擇想訂購的產品：<select name='choose_name'><option>"+product_choose+"</select><br><br>");
			out.print("輸入想訂購的數量：");
			out.print("<input type='number' name='input_num' id='inputNum' required>");
			out.print("<input type='submit' value='下一步' onclick='checkNum()'/><br><br>");
			out.print("<font color='red'><strong>產品"+product_choose+"的庫存還有："+Integer.toString(product_choose_left)+"</strong></font><br><br>");	
            //out.print("<font color='red'><strong>產品的價格為：<select name='input_price'><option>"+product_choose_price+"</select><br><br>元(台幣)</strong></font><br><br>");			
			out.print("<font color='red'><strong>產品的價格為"+temp_price+"元(台幣)</font><br><br>");
			%>
                       <input type='hidden' name='input_price' value='<%=temp_price%>'>
			           <input type="hidden" name="check_num" value="<%=product_choose_left%>">
			<%
			out.print("<strong>注意！下一步將無法更改購買數量！</strong>");
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
	</div>
	
		<div id="footer1">
			<ul>
				<li><hr></li>
			</ul>
			<ul class="footer2">
				<li><a href="../html/about.html">關於我們</a></li>
				<li><a href="../html/customer.html">客服專區</a></li>
			</ul>
		</div>
			
			
</body>
</html>