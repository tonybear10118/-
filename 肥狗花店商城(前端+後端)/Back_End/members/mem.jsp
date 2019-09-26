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
	   Connection con2 = DriverManager.getConnection(url, "root", "1234");
	   
	   String input_ID = request.getParameter("ID");
	   String input_pwd  = request.getParameter("pwd");
	   String input_sex  = request.getParameter("sex");
	   String input_add = request.getParameter("address");
	   String input_num  = request.getParameter("phone_num");
	   String input_mail  = request.getParameter("mail");
	   String input_iden  = request.getParameter("identify");

	   
   
	   
	   
	   
	   if(con.isClosed())
		out.print("connection failure");
	   else
	   {
			con.createStatement().execute("USE project2");
			
			
			///////用來計算有幾個會員然後編號，其實原本有auto_increment可以用但此時的我並不知道..
	/*		Statement s = con.createStatement();
            ResultSet r = s.executeQuery("SELECT COUNT(*) AS rowcount FROM member_1");
            r.next();
            int count = (r.getInt("rowcount")+1) ;  */
			
			sql = "SELECT MAX(member_num) FROM member_1 ";
			Statement s3 = con.createStatement();
			ResultSet r3 = s3.executeQuery(sql);
			int count = 0;
            if(r3.next())
			{

				count = r3.getInt(1);
				count++;
			}
			else
			{
            count = 1;  //count是為了用來加入購物車總金額(最後一筆資料)
			}
			
			
			///////////////開始輸入資料/////////////////////
			
			
			
			sql = "INSERT member_1(member_num, id, identify)" +			     
			      "VALUES ('"+count+"', '"+input_ID+"', '"+input_iden+"')";
		    boolean no1 = con.createStatement().execute(sql); //成功的話會船回false
		
            if(!no1)
			  out.print("新的會員資料member_1新增成功！"); 
		    else
			  out.print("新增失敗，請重新來過！");
		  
		  
		    sql = "INSERT member_2(id, pwd, phonenum, sex, address, email)" +			     
			      "VALUES ('"+input_ID+"', '"+input_pwd+"', '"+input_num+"', '"+input_sex+"', '"+input_add+"', '"+input_mail+"')";
		    boolean no = con.createStatement().execute(sql); //成功的話會船回false
			
			 if(!no)
			  out.print("新的會員資料member_2新增成功！<br>"); 
		    else
			  out.print("新增失敗，請重新來過！");  
		  
		  

			///////////購物車專用，一註冊便有個人的資料表//////////////////
			con2.createStatement().execute("USE carts");
            sql = "CREATE TABLE "+input_ID+" ";             //利用登入後的SESSION名來命名資料表來新增一個資料表來達到購物車的效果
		    sql += "(no int(10),";     //這裡的編號是各個會員訂購商品的編號，並非會員編號或商品編號
		    sql += "userName char(50),";
		    sql += "product char(50),";
		    sql += "productNum int(20),";
		    sql += "price int(10),";
			sql += "PRIMARY KEY(no))";
			con2.createStatement().execute(sql);
			
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