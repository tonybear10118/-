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
//Step 1: ���J��Ʈw�X�ʵ{�� 
     Class.forName("com.mysql.jdbc.Driver");
     try {
//Step 2: �إ߳s�u 	   
         String url="jdbc:mysql://localhost/";
         String sql="";
         Connection con=DriverManager.getConnection(url,"root","1234");
         if(con.isClosed())
            out.println("�s�u�إߥ���");
         else
           {
//Step 3: ��ܸ�Ʈw           
            sql="use project2";
            con.createStatement().execute(sql);
//Step 4: ���� SQL ���O	        
            sql="CREATE TABLE guestbook";
            sql+="(no tinyint(4) auto_increment,";
            sql+="name varchar(10),";
			sql+="subject varchar(30),";
			sql+="content text,";
			sql+="putdate date,";
            sql+="PRIMARY KEY(no))";
            con.createStatement().execute(sql);
//Step 5: ��ܵ��G           
            out.println("guestbook�إߦ��\");
        }
//Step 6: �����s�u        
        con.close();
     }
     catch (SQLException sExec) {
            out.println("SQL���~"+sExec.toString());
     }
}
catch (ClassNotFoundException err) {
       out.println("class���~"+err.toString());
}
%>
</body>
</html>
	