<!-- Step 0: import library -->
<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<html>
<head>
<title>add</title>
</head>
<body>
<%!
		      String newline(String str)
			  {
				  int index=0;
				  while((index=str.indexOf("\n"))!=-1)
				  str=str.substring(0,index)+"<br>"+str.substring(index+1);
			    return(str);
			  }
		   
		   
		   %>
<%
try {
//Step 1: 載入資料庫驅動程式 
    Class.forName("com.mysql.jdbc.Driver");
    try {
//Step 2: 建立連線 	
        String url="jdbc:mysql://127.0.0.1/?useUnicode=true&characterEncoding=big5";
        String sql="";
        Connection con=DriverManager.getConnection(url,"root","1234");
        if(con.isClosed())
           out.println("連線建立失敗");
        else {
//Step 3: 選擇資料庫   
           sql="USE project2";
           con.createStatement().execute(sql);
           //從表格傳遞中文到資料庫, 必須使用getBytes("ISO-8859-1")編碼
           String new_name=new String(request.getParameter("name").getBytes("ISO-8859-1"));
//           String new_name=request.getParameter("name");
           
//		   String new_no=request.getParameter("no");
           String new_subject=new String(request.getParameter("subject").getBytes("ISO-8859-1"));
		   
           String new_content=new String(request.getParameter("content").getBytes("ISO-8859-1"));
            new_content=newline(new_content);
		   java.sql.Date new_date=new java.sql.Date(System.currentTimeMillis());
		   
//Step 4: 執行 SQL 指令	
            sql="insert guestbook (name, subject, content, putdate) ";
           sql+="value ('" + new_name + "', ";
           sql+="'"+new_subject+"\', ";
           sql+="'"+new_content+"', ";   
           sql+="'"+new_date+"')"; 
           
           		   
//out.println(sql);
           con.createStatement().execute(sql);
//Step 6: 關閉連線
           con.close();
//Step 5: 顯示結果 
          //直接顯示最新的資料
           response.sendRedirect("view.jsp?page=1");
       }
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
