<%--
  分页查询数据
    1）服务器启动，进入index页面
    2）通过ajax转发到控制器方法/emps
    3）控制器执行分页操作，将分页数据再次回传给index.jsp页面
    4）在index.jsp页面中通过dom添加内容显示
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("contextPath", request.getContextPath());
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
<!-- 编辑员工的模态框 -->
<div class="modal fade" id="editEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">编辑员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName_edit" name="empName" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="email_edit" name="email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_m" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_f" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="deptId" id="deptSelect">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateEmpBtn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- 添加员工的模态框 -->
<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName" name="empName" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadio1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadio2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="email" name="email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveEmpBtn">保存</button>
            </div>
        </div>
    </div>
</div>


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
            <button type="button" class="btn btn-primary" id="addBtn">新增</button>
            <button type="button" class="btn btn-danger" id="delBtn">删除</button>
        </div>
    </div>
    <%--查询列表--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_tab">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="checkAll">
                    </th>
                    <th>#</th>
                    <th>name</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>

                <tbody>
                <%--通过回传的json数据和dom显示员工信息--%>
                </tbody>
            </table>
        </div>
    </div>
    <%--分页--%>
    <div class="row" id="pageDiv">
        <div class="col-lg-6" id="summaryDiv">
        </div>

        <div class="col-lg-6" id="pageNav">

        </div>
    </div>
</div>


<script type="text/javascript">
    $(function () {
        queryEmpForAjax(1);
    });

    //点击新增按钮,添加新增用户模态框
    $("#addBtn").click(function () {
        //删除模态框中表单数据
        $("#addEmpModal form").get(0).reset();
        //删除静态框中表单中表单项样式
        $("#addEmpModal form div").removeClass("has-error has-success");
        //删除静态框中表单中表单项提示信息
        $(".help-block").text("");

        //发送ajax请求，获取部门信息
        queryDeptForAjax($("#addEmpModal select"));

        //显示模态框
        $('#addEmpModal').modal({
            backdrop: "static"
        });
    });

    //查询部门信息，并显示部门列表
    function queryDeptForAjax(deptSelect) {
        //清空部门列表
        deptSelect.empty();
        $.ajax({
            url: "${contextPath}/depts",
            type: "GET",
            success: function (result) {
                //动态给下拉列表添加下拉选项
                $.each(result.map.list, function (index, dept) {
                    var option = $("<option></option>").append(dept.deptName).attr("value", dept.deptId);
                    option.appendTo(deptSelect);
                });
            }
        })
    };

    function validateInfo(ele, status, info) {
        ele.parent().removeClass("has-error has-success");
        ele.next("span").text();
        if ("error" == status) {
            ele.parent().addClass("has-error");
            ele.next("span").text(info);
        } else if ("success" == status) {
            ele.parent().addClass("has-success");
            ele.next("span").text(info);
        }
    };



    //新增员工模态框中：用户名后端校验
    $("#empName").change(function () {
        $.ajax({
            url: "/findEmpByName",
            type: "GET",
            data: "eName=" + $(this).val(),
            success: function (result) {
                if (result.code == "FAIL") {
                    validateInfo($("#empName"), "error", result.map.error_msg);
                    $("#saveEmpBtn").attr("validate_info", "error");
                } else {
                    validateInfo($("#empName"), "success", "用户名可用！");
                    $("#saveEmpBtn").attr("validate_info", "success");
                }
            }
        });
    });

    //前端表单元素校验
    function formItemCheck(ele,regx,message) {
        var eleVal = ele.val();
        if (!regx.test(eleVal)) {
            validateInfo(ele, "error", message);
            return false;
        } else {
            validateInfo(ele, "success", "");
            return true;
        }
    }

    function validateForm() {
        //校验员工名
        //1)前端校验
        var empNameRegx = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,8})$/;
        var empNameMsg = "用户名为6~16位英文或2~8位汉字！";
        if(!formItemCheck($("#empName"),empNameRegx,empNameMsg)){
            return false;
        }

        //2)后端校验,查询是否存在当前用户
        if ($("#saveEmpBtn").attr("validate_info") == "error") {
            validateInfo($("#empName"), "error", "用户名已存在！");
            return false;
        }

        //验证email
        var empEmailRegx = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        var empEmailMsg = "邮箱不对！"
        if(!formItemCheck($("#email"),empEmailRegx,empEmailMsg)){
            return false;
        }

        return true;
    };

    //点击保存按钮
    $("#saveEmpBtn").click(function () {
        //进行表单数据校验
        if (!validateForm()) {
            return false;
        }

        //发送ajax请求，保存用户，返回最后一页数据
        $.ajax({
            url: "${contextPath}/saveEmp",
            type: "POST",
            data: $("#addEmpModal form").serialize(),
            success: function (result) {
                if (result.code == "FAIL") {
                    var email_err = result.map.errors.email;
                    var empName_err = result.map.errors.empName;
                    if (email_err != undefined) {
                        validateInfo($("#email"), "error", email_err);
                    }
                    if (email_err != undefined) {
                        validateInfo($("#empName"), "error", empName_err);
                    }
                } else if (result.code == "SUCCESS") {
                    //隐藏静态框
                    $("#addEmpModal").modal('hide');
                    //到最后一页(页码选择总页码+1)
                    queryEmpForAjax(totalPages + 1);
                }

            }
        });
    });


    //封装ajax请求
    function queryEmpForAjax(pn) {
        $.ajax({
            url: "${contextPath}/empsAjax",
            data: "pn=" + pn,
            type: "GET",
            success: function (respData) {
                //解析并显示员工数据
                build_emp_tab(respData);
                //解析并显示分页数据
                build_emp_page(respData);
            }
        });
    };

    var totalPages;
    var currentPageNo;

    function build_emp_page(respData) {
        var pageInfo = respData.map.pageInfo;

        totalPages = pageInfo.pages;
        currentPageNo = pageInfo.pageNum;
        //分页统计数据
        var summaryDiv = $("#summaryDiv").text("当前第" + pageInfo.pageNum + "页，共有" + totalPages + "页，总计" + pageInfo.total + "记录");


        //分页条
        var pageNavDiv = $("#pageNav");
        pageNavDiv.empty();
        var nav = $("<nav></nav>").attr("aria-label", "Page navigation");
        pageNavDiv.append(nav);

        var ul = $("<ul></ul>").addClass("pagination");
        var firstPage = $("<li></li>").append($("<a href='#'></a>").append($("<span></span>").attr("aria-hidden", true)).append("首页"));
        var prevPage = $("<li></li>").append($("<a href='#'></a>").append($("<span></span>").attr("aria-hidden", true)).append("&laquo;"));
        //如果没有上一页，不能点击首页和上一页
        if (!pageInfo.hasPreviousPage) {
            firstPage.addClass("disabled");
            prevPage.addClass("disabled");
        } else {
            //点击上一页和首页进行查询
            firstPage.click(function () {
                queryEmpForAjax(1);
            });
            prevPage.click(function () {
                queryEmpForAjax(pageInfo.pageNum - 1);
            });
        }
        ul.append(firstPage).append(prevPage);
        $.each(pageInfo.navigatepageNums, function (index, pageNo) {
            var page = $("<li></li>").append($("<a href='#'></a>").text(pageNo));
            //当前页高亮,其它页正常
            if (pageInfo.pageNum == pageNo) {
                page.addClass("active")
            }
            page.click(function () {
                queryEmpForAjax(pageNo);
            });
            ul.append(page);
        });
        var nextPage = $("<li></li>").append($("<a href='#'></a>").append($("<span></span>").attr("aria-hidden", true)).append("&raquo;"));
        var endPage = $("<li></li>").append($("<a href='#'></a>").append($("<span></span>").attr("aria-hidden", true)).append("末页"));
        //如果没有下一页，不能点击末页和下一页
        if (!pageInfo.hasNextPage) {
            nextPage.addClass("disabled");
            endPage.addClass("disabled");
        } else {
            //点击下一页和末页进行查询
            nextPage.click(function () {
                queryEmpForAjax(pageInfo.pageNum + 1);
            });
            endPage.click(function () {
                queryEmpForAjax(pageInfo.pages);
            });
        }
        ul.append(nextPage).append(endPage);
        ul.appendTo(nav);
    };

    function build_emp_tab(respData) {
        $("#emp_tab tbody").empty();
        var list = respData.map.pageInfo.list;
        $.each(list, function (index, emp) {
            var cb = $("<input type='checkbox' class='check_item'>").attr("text-align", "center");
            var td_cb = $("<td></td>").append(cb);
            var td_id = $("<td></td>").append(emp.empId);
            var td_name = $("<td></td>").append(emp.empName);
            var td_gender = $("<td></td>").append(emp.gender);
            var td_email = $("<td></td>").append(emp.email);
            var td_deptName = $("<td></td>").append(emp.dept.deptName);
            var btn_edit = $("<button></button>").addClass("btn btn-info edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil").text("编辑"));
            btn_edit.css("margin-right", "5px");
            var btn_del = $("<button></button>").addClass("btn btn-danger del_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash").text("删除"));
            var tr = $("<tr></tr>")
                .append(td_cb)
                .append(td_id)
                .append(td_name)
                .append(td_gender)
                .append(td_email)
                .append(td_deptName);
            btn_edit.appendTo(tr);
            btn_del.appendTo(tr);
            $("#emp_tab tbody").append(tr);
        })
    };

    //通过id查询员工
    function queryEmp(id) {
        $.ajax({
            url:"${contextPath}/findEmpById/"+id,
            type:"GET",
            success:function (result) {
                var employee = result.map.employee;
                $("#hidId").val(employee.empId);
                $("#empName_edit").val(employee.empName);
                $("#empName_edit").prop("disabled","disabled");
                $("#email_edit").val(employee.email);
                $("#editEmpModal :radio").val([employee.gender]);
                $("#deptSelect").val([employee.deptId]);
            }
        });
        
    }

    //点击编辑按钮，修改员工信息
    $(document).on("click",".edit_btn",function () {
        //1)查询员工信息
        //获取员工id
        var id = $(this).parent("tr").find("td:first").text();
        queryEmp(id);

        //2)查询部门信息
        //发送ajax请求，获取部门信息
        queryDeptForAjax($("#editEmpModal select"));

        //给模态框更新按钮绑定1个属性值为id
        $("#updateEmpBtn").attr("empId",id);

        //3)显示模态框
        $('#editEmpModal').modal({
            backdrop: "static"
        });
    })



    //点击更新按钮更新员工信息
    $("#updateEmpBtn").click(function () {
        //删除静态框中表单中表单项样式
        $("#editEmpModal form div").removeClass("has-error has-success");
        //删除静态框中表单中表单项提示信息
        $(".help-block").text("");

        var empId = $("#hidId").val();

        //1）email校验
        //前端校验
        var empEmailRegx = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        var empEmailMsg = "邮箱不对！"
        if(!formItemCheck($("#email_edit"),empEmailRegx,empEmailMsg)){
            return false;
        }
        //后端校验

        //2）更新数据
        $.ajax({
            url:"${contextPath}/updateEmp/"+$("#updateEmpBtn").attr("empId"),
            data:$("#editEmpModal form").serialize()+"&_method=PUT",
            type:"post",
            success:function (result) {
                if(result.code=="SUCCESS"){
                    //隐藏静态框
                    $("#editEmpModal").modal('hide');
                    //刷新当前页(页码选择总页码+1)
                    queryEmpForAjax(currentPageNo);
                }
            }
        });
    });

    /*设置全选*/
    $("#checkAll").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
        var checked_count = $(".check_item:checked").length;
        var all_count = $(".check_item").length;
        if(checked_count!=all_count){
            //取消全选按钮的选中状态
            $("#checkAll").prop("checked",false);
        }else{
            $("#checkAll").prop("checked",true);
        }
    });

    //删除单个员工
    $(document).on("click",".del_btn",function () {
        //员工名
        var ename = $(this).parents("tr").find("td:eq(2)").text();
        //员工id
        var eid = $(this).parents("tr").find("td:eq(1)").text();
        if(confirm("你确定要删除【"+ename+"】吗？")){
            $.ajax({
                url:"${contextPath}/delEmp/"+eid,
                method:"DELETE",
                success:function (result) {
                    if(result.code=="SUCCESS"){
                        //跳转到当前页面
                        queryEmpForAjax(currentPageNo);
                    }
                }
            });
        }
    });

    //删除多个员工
    $("#delBtn").click(function () {
        var ids = "";
        var names = "";
        $.each($(".check_item:checked"),function (index, ele) {
            var id = $(ele).parents("tr").find("td:eq(1)").text();
            var name = $(ele).parents("tr").find("td:eq(2)").text();
            ids += (id+"-");
            names += (name+",");
        });
        ids = ids.substring(0,ids.length-1);
        names = names.substring(0,names.length-1);
        if(confirm("你确定需要删除【"+ names +"】吗？")){
            $.ajax({
                url:"${contextPath}/delEmp/"+ids,
                method:"DELETE",
                success:function (result) {
                    if(result.code=="SUCCESS"){
                        //跳转到当前页面
                        queryEmpForAjax(currentPageNo);
                    }
                }
            });
        }
    });

</script>
</body>

</html>
