<%@ page contentType="text/html;charset=UTF-8"  language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>注册</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <script src="js/jquery-3.2.1.js"></script>
  <script src="js/bootstrap.min.js" ></script>
  <script src="js/js.cookie.js"></script>
  <style>
    #Register{
      height: 90%;
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

<%--<h2 style="text-align: center; color: white; font-family: '华文行楷'; font-size: 500%">注册</h2>--%>

<div class="panel panel-default" id="Register">
  <div class="panel-heading" style="background-color: #fff">
    <h3 class="panel-title">请注册</h3>
  </div>
  <div class="panel-body">
    <div class="form-group">
      <label for="username">用户名</label>
      <input type="text" class="form-control" id="username" placeholder="请输入用户名">
    </div>
    <div class="form-group">
      <label for="passwd">密码</label>
      <input type="password" class="form-control" id="passwd" placeholder="请输入密码">
    </div>

    <div class="form-group">
      <label for="sex">性别</label>
      <input type="text" class="form-control" id="sex">
    </div>

    <div class="form-group">
      <label for="birth">生日</label>
      <input type="date" class="form-control" id="birth">
    </div>

    <div class="form-group">
      <label for="address">地址</label>
      <input type="text" class="form-control" id="address">
    </div>

    <div class="form-group">
      <label for="phone">电话</label>
      <input type="text" class="form-control" id="phone">
    </div>

    <div class="form-group">
      <label for="email">邮箱</label>
      <input type="text" class="form-control" id="email">
    </div>

    <div class="form-group">
      <label for="yanzhenma">验证码</label>
      <input type="text" class="form-control" id="yanzhenma" placeholder="请输入验证码">
      <div>
        <a href="javascript:void(0)" onclick="getCode()"><img id="code" ></a>
      </div>
    </div>
    <div>
      <a href="login.html">已有账号，立即登录</a>
    </div>


    <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
    <button id="registerButton"  class="btn btn-primary  btn-block">注册
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


  $("#registerButton").click(function () {
    var username =$("#username").val();
    var passwd=$("#passwd").val();
    var yanzhenma=$("#yanzhenma").val();
    var sex=$("#sex").val();
    var birth=$("#birth").val();
    var address=$("#address").val();
    var phone=$("#phone").val();
    var email=$("#email").val();
    if (username == '') {
      $("#info").text("提示:账号不能为空");
    }
    else if( passwd ==''){
      $("#info").text("提示:密码不能为空");
    }
    else if(yanzhenma ==''){
      $("info").text("提示:验证码不能为空");
    }
    else if(sex ==''){
      $("info").text("提示:性别不能为空");
    }
    else if(birth ==''){
      $("info").text("提示:生日不能为空");
    }
    else if(address ==''){
      $("info").text("提示:地址不能为空");
    }
    else if(phone ==''){
      $("info").text("提示:电话不能为空");
    }
    else if(email ==''){
      $("info").text("提示:邮箱不能为空");
    }
    else {
      $.ajax({
        type: "POST",
        url: "api/registerCheck",
        data: {
          username:username ,
          passwd: passwd,
          yanzhenma:yanzhenma,
          sex:sex,
          birth:birth,
          address:address,
          phone:phone,
          email:email
        },
        dataType: "json",
        // success函数，请求成功后执行
        success: function(data) {
          if (data.stateCode.trim() === "0") {
            $("#info").text("提示:注册失败!");
          } else if (data.stateCode.trim() === "1") {
            $("#info").text("提示:注册成功，去登录...");
            window.location.href="login.html";
          }
          else if(data.stateCode.trim() === "2") {
            $("#info").text("提示:验证码错误！");
          }
          else if(data.stateCode.trim() === "3") {
            $("#info").text("提示:此邮箱已经被注册！");
          }
        }
      });
    }
  })

</script>
</div>

</body>
</html>
