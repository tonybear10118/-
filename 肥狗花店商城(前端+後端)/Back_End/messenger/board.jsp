<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<html>
<head>
<title>�d����</title>
</head>
<body>
<a href="view.jsp?page=1">�[�ݯd��</a><p>


<%
    if(session.getAttribute("id")!=null) {
%>
<form name="form1" method="post" action="add.jsp">
�m�W�G<input type="text" name="name"><br>
�D�D�G<input type="text" name="subject"><br>
���e�G<textarea rows=5 name="content" wrap="on"></textarea><br>
<input type="submit" name="Submit" value="�e�X">
<input type="Reset" name="Reset" value="���s��g">
<%
	}
	
	else
	{
		out.print("<font color='red'><strong>�z�|���n�J��I�Х��n�J�I<strong></font>");	
	}
%>


</form>
</body>
</html>
