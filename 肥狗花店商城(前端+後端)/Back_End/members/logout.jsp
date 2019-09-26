<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
</head>
<body>

<%
   session.removeAttribute("id");
   session.removeAttribute("password");
   
   response.sendRedirect("../../html/login.html");
%>
</body>
</html>