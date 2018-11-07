
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- IE8兼容向下版本 -->
    <meta name="viewport" content="width=device-width, initial-scale=2.0, maximum-scale=1.0"><!-- 用于开发移动端设置满屏 -->
    <meta http-equiv="pragma" content="no-cache"><!-- 不能缓存页面，不能脱机访问 -->
    <meta http-equiv="cache-control" content="no-cache"><!-- 请求和响应不能缓存 -->
    <meta http-equiv="expires" content="0">   <!-- 请求立即过期 -->
    <title>山东威海</title>
</head>
<body>
<#include "common/common.ftl"/>
<#include "common/popWindow.ftl"/>
<!-- Preloader 页面加载前的小遮挡-->
<div id="preloader"><!-- brakcet自带common.jsp style.default.css，350毫秒之后消失 -->
    <div id="status">
        <!-- 旋转小icon -->
        <i class="fa fa-spinner fa-spin"></i>
    </div>
</div>
<section>
    <!---------------------------------------------- leftpanel ------------------------------------------>
    <div class="leftpanel">
        <!---------------------------------------------- leftpanel -----top ------------------------------------->
        <div class="logopanel text-c">
            <img src="${base}images/logo/logo.gif" >
        </div>
        <!---------------------------------------------- leftpanel -----menu ------------------------------------->
        <div class="leftpanelinner" >
            <ul class="nav nav-pills nav-stacked nav-bracket" id="nav-ul">
            </ul>
        </div>
    </div>
    <!---------------------------------------------- rightPanel ------------------------------------------>
    <div class="mainpanel">
        <!------------------------------------------- rightpanel---- headerBar ------------------------------------------>
        <div class="headerbar cl">
            <!-- <a class="menutoggle"><i class="fa fa-bars"></i></a>菜单摇摆 -->
            <!--------------------------------------- rightpanel---- headerBar ----left-------------------------------------->
            <div class="fl"><span class="main-title" id="topClock"  style="color:white;font-size:16px" ></span></div>
            <!--------------------------------------- rightpanel---- headerBar ----right-------------------------------------->
            <div class="header-right" >
                <ul class="headermenu">
                    <li>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle"
                                    data-toggle="dropdown" style="width:200px;background:#2F496C">
                                <!-- <span class="glyphicon glyphicon-user"></span> -->
                                <span  style="color:white" >你好 </span><span
                                    class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-usermenu pull-right">
                                <li>
                                    <a href="javascript:void(0)" onclick="updatePassword()" ><i class="glyphicon glyphicon-user"></i>修改密码</a>
                                    <a href="logout.do"><i class="glyphicon glyphicon-log-out"></i>退&nbsp;&nbsp;&nbsp;&nbsp;出</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <!-- <a id="go" name="go" href="javascript:void(0)" onclick="go()"><span style="color:white">点击</span></a> -->
            </div><!-- header-right -->
        </div>
        <!---------------------------------------------- rightpanel----middle ------------------------------------------>
        <div id="content-box" style="margin:20px"></div>
    </div>
</section>
<!-- staying -->
<div class="modal fade" id="confirmalert" tabindex="-1" role="dialog" aria-labelledby="confirmalertModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h5 class="modal-title" id="confirmalertModalLabel"></h5>
            </div>
            <div class="modal-body" id='modalContent' style="font-size: 30px;height: 70px;">
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript">
    $(function () {
        setInterval(function () {
            var date = new Date();  //创建对象
            var y = date.getFullYear();     //获取年份
            var m =date.getMonth()+1;   //获取月份  返回0-11
            var d = date.getDate(); // 获取日
            var w = date.getDay();   //获取星期几  返回0-6   (0=星期天)
            var ww = ' 星期'+'日一二三四五六'.charAt(new Date().getDay()) ;//星期几
            var h = date.getHours();  //时
            var minute = date.getMinutes()  //分
            var s = date.getSeconds(); //秒
            var sss = date.getMilliseconds() ; //毫秒
            if(m<10){
                m = "0"+m;
            }
            if(d<10){
                d = "0"+d;
            }
            if(h<10){
                h = "0"+h;
            }
            if(minute<10){
                minute = "0"+minute;
            }
            if(s<10){
                s = "0"+s;
            }
            if(sss<10){
                sss = "00"+sss;
            }else if(sss<100){
                sss = "0"+sss;
            }
            $('#topClock').text(  y+"-"+m+"-"+d+"   "+h+":"+minute+":"+s+"   "+" "+ww );
        }, 1000);

    });
</script>