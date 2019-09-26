<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<html>
<head>
<title>留言版</title>
</head>
<body>
<a href="view.jsp?page=1">觀看留言</a><p>


<%
    if(session.getAttribute("id")!=null) {
%>
<form name="form1" method="post" action="add.jsp">
姓名：<input type="text" name="name"><br>
主題：<input type="text" name="subject"><br>
內容：<textarea rows=5 name="content" wrap="on"></textarea><br>
<input type="submit" name="Submit" value="送出">
<input type="Reset" name="Reset" value="重新填寫">
<%
	}
	
	else
	{
		out.print("<font color='red'><strong>您尚未登入喔！請先登入！<strong></font>");	
	}
%>


</form>
</body>
</html>
