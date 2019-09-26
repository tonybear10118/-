
<!DOCTYPE html>
<html>
    <head>
	    <%@page pageEncoding = "UTF-8"%>
        <%@page import = "java.sql.*"%>
        <%@page language="java" import= "Shop_imp.*,java.util.*"%>
        <meta charset="UTF-8">
        <title>shopcart</title>
		<link rel="shortcut icon" href="../images/LOGO.ico">
		<link rel="stylesheet" href="../css/realC.css">
        <script src=""></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.slidertron-1.3.js"></script>
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet" />
<link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/sep.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/shopcart.css" rel="stylesheet" type="text/css" media="all" />
    <% request.setCharacterEncoding("UTF-8");%>
    <%
    try{
	    Class.forName("com.mysql.jdbc.Driver");   //使用JDBC連結		
	try
	{
	   String url="jdbc:mysql://127.0.0.1/";
	   String sql;
	   Connection con = DriverManager.getConnection(url, "root", "1234");
	   Connection con2 = DriverManager.getConnection(url, "root", "1234");  //抓取圖片用
	   int product_price = 0;
	   int totalprice =0;
	   String totalName = "";
	   int totalNum = 0;
	   
	   
	   	   
	   if(con.isClosed())
		out.print("connection failure");
	   else   
	   {
       
	   if(session.getAttribute("id")!=null)      //要登入才能購物
			{	
			con.createStatement().execute("USE carts");
			con2.createStatement().execute("USE project2");
			Object getuser = session.getAttribute("id");
		    String user = String.valueOf(getuser); 

			//////////開始計算總價格/////////////
			sql = "SELECT product, productNum, price FROM "+user+" ";
       		Statement s2 = con.createStatement(); //Statement由createStatement所產生
			ResultSet r2 = s2.executeQuery(sql);
			while(r2.next())     //用來計算總數量跟總價錢的迴圈
			{
				totalprice += (r2.getInt("price")*r2.getInt("productNum"));
				totalName += r2.getString("product"); 
				totalName += "<br><br>";
				totalNum  += r2.getInt("productNum");
			}
            sql = "SELECT * FROM "+user+" ";
			Statement s3 = con.createStatement(); //Statement由createStatement所產生
			ResultSet r3 = s3.executeQuery(sql);
			

    %>


    </head>

    <body>

	<div id="wrapper">
	    <div id="header" class="container">
			<div id="topf">
				<ul>
					<li><a href="shopcart.jsp">結帳</a></li>
					<li><a href="login.html">Login</a></li>
					<li><a href="mem.html">會員中心</a></li>
					<li><form>
					<input type="text" id="s" name="search" placeholder="Search..">
					</form>	</li>
				</ul>
			</div>
		    <div id="top">
				<ul>
					<li><a href="shopcart.jsp">結帳</a></li>
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
					<li><a class="rubberBand"href="realP.html">Homepage</a></li>
					<li><a href="about.html">about us</a></li>
					<li class="dis"><a href="plant.html">盆栽/植物</a>
					    <ul>
							<li><a href="flower.html">Flower</a></li>
							<li><a href="plant.html">Plant</a></li>
							
						</ul>
					</li>				
					<li class="dis"><a href="flowert.html">花器/工具</a>					  
						<ul>
							<li><a href="flowert.html">花器</a></li>
							<li><a href="tool.html">Tool</a></li>
							
						</ul>
					</li>
					
					<li><a href="customer.html">客服專區</a></li>
				</ul>

				
			</div>
			<div>
				<ul class="sepsrc">
					<li>
					<h3>首頁 >> 購物車<hr></h3>
					
					</li>
				</ul>
			</div>
			<div id="lefts">
				<div>
					<ul >

						<li class="gray"><p>Shopping Cart</p></li>
						<li>購物車</li>
					</ul>
				
				</div>
			</div>
			
			<div id="shopcar1">
				<ul>
					<li>
					
					<a id="shopcar2" href="shopcart.jsp"><img src="../images/shopcar.jpg" alt="" /></a>
					</li>
				</ul>
			</div>
			
			<div id="midshop">
				<ul class="shopcartop">
					<li >我的購物車</li>
				</ul>
				<ul id="clobox">
					<li>
						<ul class="cartdata">
							<li>商品圖片</li>
							<li>商品明細</li>
							<li>價格</li>
							<li>數量</li>
							<li>庫存</li>
							<li>動作</li>
						</ul>
						<%
						while(r3.next())
			            {
						String show_name = r3.getString("product");
						String show_price = Integer.toString(r3.getInt("price"));
						String show_num = Integer.toString(r3.getInt("productNum"));
						String show_Tprice = Integer.toString(r3.getInt("productNum")*r3.getInt("price"));
					    Statement s4 = con2.createStatement(); //Statement由createStatement所產生
			            ResultSet r4 = s4.executeQuery("SELECT img FROM product_1 WHERE productName='"+show_name+"' ");
						r4.next();	
						String for_pic = r4.getString("img");
						int for_del = r3.getInt("no");
						%>
						<form name"delproduct" action="../Back_End/shop/shop_del.jsp" method="POST">
						<ul class="cartdata">
							
                        <li ><img id="imtest" src="../pla/<%=for_pic%>"></li>
						<li><%=show_name%></li>
						<li><%=show_price%>元</li>
						<li><%=show_num%>個</li>
						<li><%=show_Tprice%>元</li>
						<li><input type="submit" value="刪除"></li>
                        </ul>
						<input type="hidden" name="del_choose" value="<%=for_del%>">
                        </form>
								
						<%
						} //while
						%>
						</ul>
						<ul id="cartdata1">
						<li class="cartdatar"><a href="../Back_End/orders/order_add.jsp"><input id="done" type="submit" name="結帳" value="結帳" ></a></li>
						<li class="cartdatar">$</li>
						<li class="cartdatar">總計:<%=totalprice%></li>
						</ul>
					<li>
				</ul>
			</div>

			
			
			
			
			
			
		</div>
		
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
		
		<%		
            }  //上面if的		
		    else
			{
			     out.print("<font size='700' color='red'><strong>您尚未登入喔！請先登入！</strong></font>");	
			}%>	
		</div>
		
	    </div>
     <%
           			con.close();
					con2.close();
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
