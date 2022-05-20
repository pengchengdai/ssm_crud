<%--
  Created by IntelliJ IDEA.
  User: dpc
  Date: 2022/5/11
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("contextPath",request.getContextPath());
%>
<html>
<head>
    <title>分页查询</title>
    <%--引入jQuery--%>
    <script type="text/javascript" src="${contextPath}/static/js/jquery-1.11.0.js"></script>
    <%--引入BootStrap--%>
    <link rel="stylesheet" href="${contextPath}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="${contextPath}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h3>SSM_CRUD</h3>
            </div>
        </div>
            <%--2个按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button type="button" class="btn btn-primary">新增</button>
                <button type="button" class="btn btn-danger">删除</button>
            </div>
        </div>
            <%--查询列表--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>
                            <input type="checkbox" id="checkOne">
                        </th>
                        <th>#</th>
                        <th>name</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>

                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>
                                <input type="checkbox" class="checkAll">
                            </td>
                            <td>${emp.empId}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.gender}</td>
                            <td>${emp.email}</td>
                            <td>${emp.dept.deptName}</td>
                            <td>
                                <button type="button" class="btn btn-info">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button type="button" class="btn btn-danger">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
            <%--分页--%>
        <div class="row">
            <div class="col-lg-6">
                当前第${pageInfo.pageNum}页，共有${pageInfo.pages}页，总计${pageInfo.total}记录
            </div>
            <div class="col-lg-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>

                            <a href="${contextPath}/emps?pn=1" aria-label="Previous">
                                <span aria-hidden="true">首页</span>
                            </a>
                        </li>
                        <%--如果当前为第1页，不显示上一页图标--%>
                        <c:if test="${pageInfo.pageNum!=1}">
                            <li>
                                <a href="${contextPath}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="pageNo">
                            <%--如果是当前页码，高亮--%>
                            <c:if test="${pageInfo.pageNum==pageNo}">
                                <li class="active"><a href="#">${pageNo}</a></li>
                            </c:if>
                            <%--如果不是当前页码，正常显示--%>
                            <c:if test="${pageInfo.pageNum!=pageNo}">
                                <li class="pnli"><a href="${contextPath}/emps?pn=${pageNo}">${pageNo}</a></li>
                            </c:if>

                        </c:forEach>
                        <%--如果当前为最后1页，不显示下一页图标--%>
                        <c:if test="${pageInfo.pageNum!=pageInfo.pages}">
                            <li>
                                <a href="${contextPath}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <li>
                            <a href="${contextPath}/emps?pn=${pageInfo.pages}" aria-label="Next">
                                <span aria-hidden="true">末页</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
