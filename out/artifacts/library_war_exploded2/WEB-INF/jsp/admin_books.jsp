<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>全部图书信息</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <script>
        $(function () {
            $('#header').load('admin_header.html');
        })
    </script>
</head>
<body background="img/book1.jpg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">

<%--导航栏--%>
<div id="header"></div>

<%--搜索框--%>
<div style="padding: 70px 150px 10px">
    <form   method="post" action="querybook.html" class="form-inline"  id="searchform">
        <div class="form-group ">
            <label for="author">作者</label>
            <input type="text" class="form-control" id="author" placeholder="请输入作者" name="author">
        </div>
        <div class="form-group">
            <label for="publish">出版社</label>
            <input type="text" class="form-control" id="publish" placeholder="请输入出版社" name="publish">
        </div>
        <div class="form-group">
            <label for="name">图书名</label>
           <input type="text" placeholder="输入图书名" class="form-control" id="name"  class="form-control" name="name">
        </div>
        <input type="submit" value="搜索" class="btn btn-default">
    </form>
    <script>
        $("#searchform").submit(function () {
            var author=$("#author").val();
            var publish=$("#publish").val();
            var name=$("#name").val();
            // console.log(val);
            if(author=='' && publish == '' && name == ''){
                alert("请输入关键字");
                return false;
            }
        })
    </script>
</div>
<%--两个c：if 存储一个操作成功与否--%>
<%--使用了 Bootstrap 的样式，其中 alert alert-success 表示提示框的样式为绿色的成功提示框，
alert-dismissable 表示该提示框可以被关闭。关闭按钮的 <button> 标签中，data-dismiss="alert" 属性表示点击按钮时关闭提示框。--%>
<div style="position: relative;top: 10%">
<c:if test="${!empty succ}">
    <div class="alert alert-success alert-dismissable">
        <button type="button" class="close" data-dismiss="alert"
                aria-hidden="true">
            &times;
        </button>
        ${succ}
    </div>
</c:if>
<c:if test="${!empty error}">
    <div class="alert alert-danger alert-dismissable">
        <button type="button" class="close" data-dismiss="alert"
                aria-hidden="true">
            &times;
        </button>
        ${error}
    </div>
</c:if>
</div>
<%--展示图书，一开始是展示所有图书，查询之后是所查图书--%>
<div class="panel panel-default" style="width: 90%;margin-left: 5%">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">
            全部图书
        </h3>
    </div>
    <div class="panel-body">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>书名</th>
                <th>作者</th>
                <th>出版社</th>
                <th>ISBN</th>
                <th>价格</th>
                <th>剩余数量</th>
                <th>详情</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${books}" var="book">
            <tr>
                <td><c:out value="${book.name}"></c:out></td>
                <td><c:out value="${book.author}"></c:out></td>
                <td><c:out value="${book.publish}"></c:out></td>
                <td><c:out value="${book.isbn}"></c:out></td>
                <td><c:out value="${book.price}"></c:out></td>
                <td><c:out value="${book.number}"></c:out></td>
                <td><a href="admin_book_detail.html?bookId=<c:out value="${book.bookId}"></c:out>">
                    <button type="button" class="btn btn-success btn-xs">详情</button>
                </a></td>
                <td><a href="updatebook.html?bookId=<c:out value="${book.bookId}"></c:out>"><button type="button" class="btn btn-info btn-xs">编辑</button></a></td>
                <td><a href="deletebook.html?bookId=<c:out value="${book.bookId}"></c:out>"><button type="button" class="btn btn-danger btn-xs">删除</button></a></td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
