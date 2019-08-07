<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/3
  Time: 8:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：webapp
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
<!--显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
            <button>给我偏移</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <table class="table table-hover">
            <tr>
                <th>#</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${pageInfo.list }" var="emp">

            <tr>
                <th>${emp.empId}</th>
                <th>${emp.empName}</th>
                <th>${emp.empGender=="M"?"男":"女"}</th>
                <th>${emp.empEmail}</th>
                <th>${emp.department.deptName}</th>
                <th>
                    <button class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-bell" aria-hidden="true"></span> 编辑</button>
                    <button class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-bell" aria-hidden="true"></span> 删除</button>
                </th>
            </tr>

            </c:forEach>

        </table>
    </div>
    <!--分页信息-->
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前第${pageInfo.pageNum }页,总${pageInfo.pages},总条${pageInfo.total}记录
        </div>

            <%--分页条信息--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>
                            <a href="${APP_PATH}/emps?pn=1" >首页</a>
                        </li>
                        <li>
                            <c:if test="${pageInfo.hasPreviousPage}">
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1 }" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                </a>
                            </c:if>
                        </li>
                        <!--遍历pageInfo的navigateNums-->
                        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_Num }</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${page_Num }">${page_Num }</a></li>
                            </c:if>

                        </c:forEach>
                        <li>
                            <c:if test="${pageInfo.hasNextPage}">
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1 }" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </c:if>
                        </li>
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pages }" >末页</a>
                        </li>
                    </ul>
                </nav>
            </div>
    </div>
    <div class="row"></div>
</div>




</body>
</html>
