<!-- Step 0: import library -->
<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<html>
<head>
<title>create table</title>
</head>
<body>
<%
try {
//Step 1: 載入資料庫驅動程式 
     Class.forName("com.mysql.jdbc.Driver");
     try {
//Step 2: 建立連線 	   
         String url="jdbc:mysql://localhost/";
         String sql="";
         Connection con=DriverManager.getConnection(url,"root","1234");
         if(con.isClosed())
            out.println("連線建立失敗");
         else
           {
//Step 3: 選擇資料庫           
            sql="use project2";
            con.createStatement().execute(sql);
//Step 4: 執行 SQL 指令	        
            sql="CREATE TABLE guestbook";
            sql+="(no tinyint(4) auto_increment,";
            sql+="name varchar(10),";
			sql+="subject varchar(30),";
			sql+="content text,";
			sql+="putdate date,";
            sql+="PRIMARY KEY(no))";
            con.createStatement().execute(sql);
//Step 5: 顯示結果           
            out.println("guestbook建立成功");
        }
//Step 6: 關閉連線        
        con.close();
     }
     catch (SQLException sExec) {
            out.println("SQL錯誤"+sExec.toString());
     }
}
catch (ClassNotFoundException err) {
       out.println("class錯誤"+err.toString());
}
%>
</body>
</html>
	