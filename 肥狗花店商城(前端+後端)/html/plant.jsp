
<!DOCTYPE html>
<html>
    <head>
	    <%@page pageEncoding = "UTF-8"%>
        <%@page import = "java.sql.*"%>
        <meta charset="UTF-8">
        <title>FlowerBear-plant</title>
		<link rel="shortcut icon" href="../images/LOGO.ico">
		<link rel="stylesheet" href="../css/realC.css">
        <script src=""></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.slidertron-1.3.js"></script>
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet" />
<link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/sep.css" rel="stylesheet" type="text/css" media="all" />
    <%try{
	Class.forName("com.mysql.jdbc.Driver");   //使用JDBC連結		
	try
	{
	   String url="jdbc:mysql://127.0.0.1/";
	   String sql;
	   Connection con = DriverManager.getConnection(url, "root", "1234");
	   int i = 1;  //while用
	   
	   	   
	   if(con.isClosed())
		out.print("connection failure");
       else
	   {
			con.createStatement().execute("USE project2");
			sql = "SELECT * FROM product_2";
			ResultSet tmp = con.createStatement().executeQuery(sql);
	   	
	%>
       


    </head>

    <body>
	<div id="whi">
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
					<h3>首頁 >> plant<hr></h3>
					
					</li>
				<ul>
			</div>
			<div id="left1">
				<div>
					<ul >
						<li class="greenw"><a  href="#">商品分類</a></li>
						<li><a href="plant.html">>盆栽</a></li>
						<li><a href="flower.html">>植物</a></li>
						<li><a href="flowert.html">>花器</a></li>
						<li><a href="tool.html">>工具</a></li>
						<li><a href="plant.jsp">>總覽</a></li>
					</ul>
				
				</div>
			</div>
			<div id="shopcar1">
				<ul>
					<li>
					
					<a id="shopcar2" href="shopcart.html"><img src="../images/shopcar.jpg" alt="" /></a>
					</li>
				</ul>
			</div>
			<div id="mids">
				<ul>
					<li class="propage">商品頁面</li>
				</ul>
				<!----------->
				<%
					Statement s1 = con.createStatement();
                    ResultSet r1 = s1.executeQuery("SELECT COUNT(*) AS rowcount FROM product_1 ");
                    r1.next();
					int count = (r1.getInt("rowcount"));
					int n = count;
					
       		        Statement s2 = con.createStatement(); //Statement由createStatement所產生
			        ResultSet r2 = s2.executeQuery("SELECT * FROM product_1");
					
					
					
							
					
				
                    while(i<=count)   //每3個產品換一行，是一個巢狀的外圈		
                    {
						if(i==1 || i%3==0)
						{
						out.print("<ul class='promar'>");
						}
						


						
				        while(r2.next())
					    {
							String show_name = r2.getString("productName");
							String pic = r2.getString("img");
							
							
							
				            Statement s9 = con.createStatement(); //Statement由createStatement所產生
			                ResultSet r9 = s9.executeQuery("SELECT * FROM product_2 WHERE productName = '"+show_name+"' ");
					        r9.next();
							
							
							String show_price = Integer.toString(r9.getInt("price"));
							
							
					%>
				<div id="product">
					<ul class="promar">
						<li class="nochan"><img src="../pla/<%=pic%>" alt="1" />
							<ul class="proleft">
							    <form action="..\product\step2.jsp" method="POST">
								<input type="hidden" name="product_choose" value="<%=show_name%>">
								<li class="col"><h3><%=show_name%></h3></li>
								<li class="coll"><h3>NT$<%=show_price%></h3></li>
								<li><input class="txt1" type="submit" name="Submit" value="加入購物車"></li>
							    </form>
							</ul>
							
						</li>
						
					
					
					
					
					
					
					
					
					</ul>
					<%
						n++;
				        }
						if(i==1 || i%3==0)
						{
						     out.print("</ul>");
						}
						n++;
						i++;
					}							 
					%>

					

				
			
				</div>
				
				<!------------->
			</div>
			<%
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
		</div>
    </body>

</html>
