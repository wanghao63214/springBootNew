<!DOCTYPE html>
<html class="login-bg">
<head>
    <#assign base=request.contextPath />
    <title>管理后台系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <link href="${base}js/lib/Bracket1.5/css/style.default.css" rel="stylesheet">
    <script src="${base}js/lib/Bracket1.5/js/jquery-1.11.1.min.js"></script>
    <script src="${base}js/lib/Bracket1.5/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="${base}js/lib/Bracket1.5/js/bootstrap.min.js"></script>
    <script src="${base}js/lib/Bracket1.5/js/modernizr.min.js"></script>
    <script src="${base}js/lib/Bracket1.5/js/jquery.sparkline.min.js"></script>
    <script src="${base}js/lib/Bracket1.5/js/jquery.cookies.js"></script>
    <script src="${base}js/lib/Bracket1.5/js/toggles.min.js"></script>
    <script src="${base}js/lib/Bracket1.5/js/retina.min.js"></script>
    <script src="${base}js/lib/Bracket1.5/js/custom.js"></script>
</head>
<body class="signin">
<section>
    <div class="signinpanel" style="width:780px;">
        <div class="row">
            <div class="col-xs-7">
                <div class="signin-info">
                    <div class="logopanel">
                        <h1><span>[</span> 管理后台 <span>]</span></h1>
                    </div><!-- logopanel -->
                    <div class="mb20"></div>
                    <h5><strong>欢迎登录管理后台!</strong></h5>
                    <ul>
                        <li><i class="fa fa-arrow-circle-o-right mr5"></i> 1</li>
                        <li><i class="fa fa-arrow-circle-o-right mr5"></i> 2</li>
                        <li><i class="fa fa-arrow-circle-o-right mr5"></i> 3</li>
                        <li><i class="fa fa-arrow-circle-o-right mr5"></i> 4</li>
                    </ul>
                    <div class="mb20"></div>
                    <!-- <strong>Not a member? <a href="signup.html">Sign Up</a></strong> -->
                </div><!-- signin0-info -->
            </div><!-- col-sm-7 -->
            <div class="col-xs-5">
                <form method="post" action="index">
                    <h4 class="nomargin text-center">登录</h4>
                    <p class="mt5 mb20"> 登录访问您的帐户！</p>
                    <input style="display:none">

                    <input type="text" name="userName" class="form-control uname"  autocomplete="off"
                           oninvalid="setCustomValidity('用户名不能为空');" required oninput="setCustomValidity('')"
                           placeholder="用户名" title="用户名不允许为空!" />
                    <input type="password"  name="password"  class="form-control pword"  oninvalid="setCustomValidity('密码不能为空！')" oninput="setCustomValidity('')" required
                           autocomplete="off" placeholder="密码" title="密码不允许为空!" />
                    <!-- <a href=""><small>Forgot Your Password?</small></a> -->
                    <div class="remember" style="color:red;">${(msg)?default("")}</div>
                    <button class="btn btn-success btn-block">登录</button>

                </form>
            </div>
        </div>
    </div>
</section>
</body>
</html>