<%@ page contentType="text/html;charset=UTF-8"  language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书馆首页</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <script src="js/js.cookie.js"></script>
    <style>
        #login{
           height: 50%;
            width: 28%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 5%;
            display: block;
            position: center;
        }

        .form-group {
            margin-bottom: 0;
        }
        * {
            padding:0;
            margin:0;
        }
    </style>
</head>
<body background="img/1.png" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<c:if test="${!empty error}">
    <script>
            alert("${error}");
            window.location.href="login.html";
</script>
</c:if>
<h2 style="text-align: center; color: white; font-family: '华文行楷'; font-size: 500%">图 书 馆</h2>

<div class="panel panel-default" id="login">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">请登录</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="email">邮箱</label>
            <input type="text" class="form-control" id="email" placeholder="请输入邮箱">
        </div>
        <div class="form-group">
            <label for="passwd">密码</label>
            <input type="password" class="form-control" id="passwd" placeholder="请输入密码">
        </div>
        <div class="form-group">
            <label for="yanzhenma">验证码</label>
            <input type="text" class="form-control" id="yanzhenma" placeholder="请输入验证码">
            <div>
                <a href="javascript:void(0)" onclick="getCode()"><img id="code" ></a>
            </div>
        </div>
        <div class="checkbox text-left">
            <label>
                <input type="checkbox" id="remember">记住密码
            </label>

            <a href="register.html">没有账号，注册一个？</a>
        </div>


        <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
        <button id="loginButton"  class="btn btn-primary  btn-block">登陆
        </button>
    </div>
</div>
    <script>
        getCode();
        /**
         * 获取验证码
         */
        function getCode(){
            document.getElementById("code").src=timestamp("verifyCode");
        }

        /**
         * 实现刷新更滑验证码
         */
        function timestamp(url){
            var gettime=new Date().getTime();
            if(url.indexOf("?")>-1){
                url=url+"&timestamp="+gettime;
            }else{
                url=url+"?timestamp="+gettime;
            }
            return url;
        }

        // $("#id").keyup(
        //     function () {
        //         var v=$("#id").val();
        //         if(isNaN($("#id").val())){
        //             console.log($("#id").val());
        //             $("#info").text("提示:账号只能为数字");
        //         }
        //         else {
        //             $("#info").text("");
        //         }
        //     }
        // )
        // 记住登录信息
        function rememberLogin(username, password, checked) {
            Cookies.set('loginStatus', {
                username: username,
                password: password,
                remember: checked
            }, {expires: 30, path: ''})//过期时间为30天，作用路径为空
        }
        // 若选择记住登录信息，则进入页面时设置登录信息
        function setLoginStatus() {
            var loginStatusText = Cookies.get('loginStatus')
            if (loginStatusText) {
                var loginStatus
                try {
                    loginStatus = JSON.parse(loginStatusText);
                    $('#email').val(loginStatus.username);
                    $('#passwd').val(loginStatus.password);
                    $("#remember").prop('checked',true);
                } catch (__) {}
            }
        }

        // 设置登录信息
        setLoginStatus();
        $("#loginButton").click(function () {
            var email =$("#email").val();
            var passwd=$("#passwd").val();
            var yanzhenma=$("#yanzhenma").val();
            var remember=$("#remember").prop('checked');
            if (email == '') {
                $("#info").text("提示:邮箱不能为空");
            }
            else if( passwd ==''){
                $("#info").text("提示:密码不能为空");
            }
            else if(yanzhenma ==''){
                $("info").text("提示:验证码不能为空");
            }
            // else if(isNaN( id )){
            //     $("#info").text("提示:账号必须为数字");
            // }
            else {
                $.ajax({
                    type: "POST",
                    url: "api/loginCheck",
                    data: {
                        email:email ,
                        passwd: passwd,
                        yanzhenma:yanzhenma
                    },
                    dataType: "json",
                    // success函数，请求成功后执行
                    success: function(data) {
                        if (data.stateCode.trim() === "0") {
                            $("#info").text("提示:邮箱或密码错误！");
                        } else if (data.stateCode.trim() === "1") {
                            $("#info").text("提示:登陆成功，跳转中...");
                            window.location.href="admin_main.html";//LoginController里面
                        } else if (data.stateCode.trim() === "2") {
                            if(remember){
                                rememberLogin(email,passwd,remember);
                            }else {
                                Cookies.remove('loginStatus');
                            }
                            $("#info").text("提示:登陆成功，跳转中...");
                            window.location.href="reader_main.html";

                        }else if(data.stateCode.trim() === "3") {
                            $("#info").text("提示:验证码错误！");
                        }
                    }
                });
            }
        })

    </script>
</div>

</body>
</html>
