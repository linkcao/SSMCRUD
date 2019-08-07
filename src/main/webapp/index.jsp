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

<!-- 修改Modal -->
<div class="modal fade" id="empUpdataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="updataName"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updataInputEmail" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="empEmail" class="form-control" id="updatdaInputEmail" placeholder="Email">
                            <span id="updataInputEmailhelp" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio1" value="M" checked="checked"> 男
                        </label>

                        <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio2" value="F"> 女
                        </label>

                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">departmentName</label>
                        <div class="col-xs-5">
                            <!--提交部门Id -->
                            <select class="form-control" name="dId" id="dept_updata_select">
                                <!--从数据库查-->
                            </select>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_updata_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 新增Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="inputName" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="inputName" placeholder="empName">
                            <span id="inputNamehelp" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="empEmail" class="form-control" id="inputEmail" placeholder="Email">
                            <span id="inputEmailhelp" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                         <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio1" value="M" checked="checked"> 男
                         </label>

                        <label class="radio-inline">
                            <input type="radio" name="empGender" id="inlineRadio2" value="F"> 女
                        </label>

                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">departmentName</label>
                        <div class="col-xs-5">
                            <!--提交部门Id -->
                            <select class="form-control" name="dId" id="dept_add_select">
<!--从数据库查-->
                            </select>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary" id="emp_add_model_btn" >新增</button>
            <button class="btn btn-danger" id="emp_delete_model_btn">删除</button>
            <button>给我偏移</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <table class="table table-hover" id="emps_table">
            <thead>
            <tr>
                <th>
                    <input type="checkbox" id="check_all"/>
                </th>
                <th>#</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
    <!--分页信息-->
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_Info_area">
        </div>

        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">


        </div>
    </div>
    <div class="row"></div>
</div>

<script type="text/javascript">
    //通过ajax请求页面数据
    //页面数据是JSON数据通过 ...获取数据
    //通过$("<li></li>").append("").appendTo 添加数据

    var totalRecord,currentPage;
    $(function(){
        to_page(1);
    });

    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=" + pn,
            type:"GET",
            success:function(result){  //请求成功回调函数
               // console.log(result);
                //解析显示员工数据
                build_emp_table(result);
                //解析显示分页信息
                build_page_info(result);
                //解析显示分页条数据
                build_page_nav(result);
            }
        });
    };

    function build_emp_table(result){
        //清空表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list; //获得employee 的list对象

        $.each(emps,function(index,item){  //对list对象进行遍历
           // alert(item.empName);
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empGenderTd = $("<td></td>").append(item.empGender=='M'?"男":"女");
            var empEmailTd = $("<td></td>").append(item.empEmail);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            //绑定id
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-bell")
                .append("编辑")
            editBtn.attr("edit-id",item.empId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn" )
                .append("<span></span>").addClass("glyphicon glyphicon-bell")
                .append("删除")
            delBtn.attr("del-id",item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    function build_page_info(result){
        $("#page_Info_area").empty();
        $("#page_Info_area").append( "当前第"+result.extend.pageInfo.pageNum +"页" +
            ",总"+result.extend.pageInfo.pages +"页,总条"+result.extend.pageInfo.total +"记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }



    function build_page_nav(result){
        //清空导航栏信息
        $("#page_nav_area").empty();
       //添加首页
        var firstPageLi = $("<li ></li>").append($("<a></a>").append("首页").attr("href","#")); //添加点击事件属性
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
        }
        if(result.extend.pageInfo.hasPreviousPage == true) {
            firstPageLi.click(function () {
                to_page(1);
            });
        }

        //添加上一页
        var prePageLi =  $("<li ></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            prePageLi.addClass("disabled");
        }
        if(result.extend.pageInfo.hasPreviousPage == true) {
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        //下一页
        var nexPageLi =  $("<li ></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nexPageLi.addClass("disabled");
        }
        if(result.extend.pageInfo.hasNextPage == true) {
            nexPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        //末页
        var lastPageLi = $("<li ></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            lastPageLi.addClass("disabled");
        }
        if(result.extend.pageInfo.hasNextPage == true) {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        var ul = $("<ul></ul>").addClass("pagination");
        //添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
        //添加每一页
           var numLi =  $("<li ></li>").append($("<a></a>").append(item).attr("href","#"));
          //判断如果当前页码
            if(result.extend.pageInfo.pageNum == item)
                numLi.addClass("active");
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });


        //添加下一页和末页
        ul.append(nexPageLi).append(lastPageLi);
        //把ul添加到nav中
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //页面加载完毕 发送请求
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    //新增员工绑定事件
    $("#emp_add_model_btn").click(function(){
        //表单清空
        reset_form("#empAddModal form");
        // $("#empAddModal form")[0].reset();
        getDepts("#dept_add_select");
        //发送Ajax请求 返回部门信息 显示在下拉列表中
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    function getDepts(ele){
        // 部门数据显示在下拉列表中
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {

                // $("dept_add_select").append()
                //$("empAddModel select").append()
                $.each(result.extend.depts,function (index,item) {
                  var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                  optionEle.appendTo(ele);
                });
            }
        });
    }

    function validate_add_form(){
        //拿到校验的数据 利用正则表达式
        var empName = $("#inputName").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            show_validate_msg("#inputName","error","字母或数字3-16位 或 2-5位汉字的组合");
            // $("#inputName").parent().addClass("has-error");
            // $("#inputName").next("span").text("字母或数字3-16位 或 2-5位汉字的组合");
          return false;
      };
        show_validate_msg("#inputName","success");
        // $("#inputName").parent().addClass("has-success");

        var empEmail = $("#inputEmail").val();
        var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!regEmail.test(empEmail)){
            // alert("邮箱格式不正确");
            show_validate_msg("#inputEmail","error","邮箱格式不正确");
            // $("#inputEmail").parent().addClass("has-error");
            // $("#inputEmailhelp").append("邮箱格式不正确");
            return false;
        }
        // $("#inputEmail").parent().addClass("has-success");
        show_validate_msg("#inputEmail","success");
        return true;
    }

    //验证是否信息正确 显示在文本框上
    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }


    $("#inputName").change(function () {
      //发送ajax 检查用户名是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+this.value,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#inputName","success","用户名可用")
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{

                    show_validate_msg("#inputName","error",result.extend.va_msg)
                    $("#emp_save_btn").attr("ajax-va","error");
                }

            }
        })
    });
    //判断之前校验的信息
    //保存输入的信息
    $("#emp_save_btn").click(function () {
        //保存员工信息
        //校验发送的数据
     if($(this).attr("ajax-va")=="error"){
         return false;
     }
        // alert($("#empAddModal form").serialize());//序列化
         if(!validate_add_form()){
             return false;
         }
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //判断返回结果是否正确
                if(result.code == 100){
                    //员工保存成功
                    //1关闭模态框
                    $("#empAddModal").modal("hide");
                    //2来到最后一页 显示刚才的数据
                    //发送Ajax请求显示最后一页数据
                    to_page(totalRecord);
                }else{
                 //显示失败信息 邮箱错误信息
                    if(undefined != result.extend.errorFields.empEmail)
                        show_validate_msg("#inputEmail","error",result.extend.errorFields.empEmail);
                    if(undefined != result.extend.errorFields.empName)
                        show_validate_msg("#inputName","error",result.extend.errorFields.empName);

                  //  cons ole.log(result);
                }
            }
        })
    });

    //绑定编辑事件

    //不能实现 因为在页面加载后才 加载组件
    //$(".edit").click()
    // 2绑定点击 live() 对以后邦迪的也有效
    // JQuery没有Live用on()进行替代
    // on给后代元素绑定事件 on(事件,后代元素,方法);
    $(document).on("click",".edit_btn",function () {
        //1\弹出模态框
        //查出部门和员工信息
        //表单清空
        reset_form("#empUpdataModal form");
        // $("#empAddModal form")[0].reset();
        getDepts("#dept_updata_select");
        //发送Ajax请求 返回部门信息 显示在下拉列表中
        //查询员工
        getEmp($(this).attr("edit-id"));
        $("#emp_updata_btn").attr("btn-id",$(this).attr("edit-id"));
        $("#empUpdataModal").modal({
            backdrop:"static"
        });
    });

    function getEmp(id){
        $.ajax({
            //思路 在创建编辑按钮的时候为编辑按钮添加自定义属性
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function(result) {
                // console.log(result);
                var empData = result.extend.emp;
                $("#updataName").text(empData.empName);
                $("#updatdaInputEmail").val (empData.empEmail);
                $("#empUpdataModal input[name=empUpdataGender]").val([empData.empGender]);
                $("#empUpdataModal select").val([empData.dId]);

            }
        });
    }

    //点击更新
    $("#emp_updata_btn").click(function () {
       //验证合法
        //校验发送的数据
        var empEmail = $("#updatdaInputEmail").val();
        var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!regEmail.test(empEmail)){
            show_validate_msg("#inputEmail","error","邮箱格式不正确");
            return false;
        }
        //发送Ajax请求 更新保存员工信息
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("btn-id"),
            // type:"POST",
            // data:$("#empUpdataModal form").serialize()+"&_method=PUT",
            type:"PUT",
            data:$("#empUpdataModal form").serialize(),
            success:function (result) {
                //1\关闭对话框
                $("#empUpdataModal").modal("hide");
                //回到本页面
                to_page(currentPage);
            }
        })

    });
    $(document).on("click",".delete_btn",function () {
        //弹出是否确认删除的确认框
        //找出btn标签的tr的祖先元素，并找出他的第2个td的子元素
       var empName = $(this).parents("tr").find("td:eq(2)").text();
       //确认框是confirm 确认是true
        var empId = $(this).attr("del-id");
        if(confirm("确认删除["+empName+"]吗?")){
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function(result){
                    to_page(currentPage);
                }
            })
        }
    });
    //完成全选 全部选功能
    $("#check_all").click(function () {
        //attr获取checked是undefined 获取自定义属性
        //dom原生的属性 用prop属性 修改读取DOM原生属性的值
        //将多选框 checked属性赋值为check——all的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function(){
        //判断当前选中的元素是否5个
        //checked选择器匹配所有选中的check_item
        //alert($(".check_item:checked").length);
        var flag = ($(".check_item:checked").length == $(".check_item").length);
        $("#check_all").prop("checked",flag);
    });

    $("#emp_delete_model_btn").click(function () {
      //  $(".check_item:checked")
        var empNames = "";
        var empIds = "";
        $.each($(".check_item:checked"),function(){
            //把empName获取 字符串的拼接
            // $(this).parent("tr").find("td:eq(2)").text(); 注意要用parents parent只找到前一个父节点
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            empIds += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //取出多余,
        console.log(empNames + empIds);
        empNames = empNames.substring(0,empNames.length-1);
        //取出多余的ID横线 substring 前闭后开
        empIds =  empIds.substring(0,empIds.length-1);
        if(confirm("确认删除["+empNames+"]吗？")){
            //发送Ajax请求删除
            $.ajax({url:"${APP_PATH}/emp/"+empIds,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
     });
</script>

</body>
</html>
