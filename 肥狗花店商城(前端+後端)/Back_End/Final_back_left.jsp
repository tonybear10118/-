<html>
<head>
<%@page pageEncoding = "UTF-8"%>
<%@page import = "java.sql.*"%>
<style type='text/css'>
.menu
     {height:30px; overflow:hidden;
      width:200px; border:solid 2px black;
     }
.menu:hover {height:auto}

.menu {
    text-align: center;
}

.menu ul {
    display: inline-block;
}
</style>
</head>
<body>
<div class="menu">會員管理<br>
   <ul>
   <li><a href="members\mem.html" target="right">會員註冊</a>
   <li><a href="members\login.html" target="right">會員登入</a>
   <li><a href="members\show_mem.html" target="right">會員一覽</a>
    <li><a href="members\show_mem_own.jsp" target="right">會員中心</a>
   <li><a href="members\fix_mem.html" target="right">會員修改</a>
   <li><a href="members\del_mem.html" target="right">會員刪除</a>
   </ul>
</div>
<div class="menu">產品管理<br>
   <ul>
   <li><a href="product\product_show.html" target="right">產品列表</a>
   <li><a href="product\product_add.html" target="right">產品新增</a>
   <li><a href="product\product_fix.html" target="right">產品修改、刪除</a>
   </ul>
</div>
<div class="menu">訂單管理<br>
   <ul>
   <li><a href="orders\order.jsp" target="right">訂單列表</a>
   <li><a href="orders\order_add.jsp" target="right">訂單新增</a>
   <li><a href="orders\order_del.html" target="right">訂單刪除</a>
   </ul>
</div>
<div class="menu">購物車<br>
   <ul>
   <li><a href="../html/shopcart.jsp" target="_parent">我的購物車</a>
   </ul>
</div>
<div class="menu">留言版管理<br>
   <ul>
   <li><a href="messenger\view.jsp" target="right">留言版列表</a>
   <li><a href="messenger\board.jsp" target="right">填寫留言版</a>
   <li><a href="messenger\del_msg.html" target="right">留言版刪除</a>
   </ul>
</div>

<div class="menu">返回前端<br>
   <ul>
   <li><a href="../html/realP.html" target="_top">返回前端</a>
   </ul>
</div>
</body>
</html>