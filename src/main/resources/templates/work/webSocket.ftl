<!DOCTYPE html>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>work</title>
</head>
<body>
<div class="jumbotron" style="width:500px;height:560px">
    <div class="container" id="textContainer">

    </div>
</div>
<form class="form-inline" action="#"  role="form">
    <div class="form-group" style="margin:5px">
        <input name="message" type="text" style="width:300px;" class="form-control" id="message" />
    </div>
    <button type="button" class="btn btn-primary btn-md"
            onclick="sendMessage()" id="sendMessageId" style="margin-left: 10px;">发送
    </button>
   <#-- <input id="start">-->
</form>
<iframe id="my_iframe" style="display:none;"></iframe>
<script type="application/javascript">
    var number = 1;
    var isMyself = false;
    var socket;
    var userName = '${userName}';
    if (typeof(WebSocket) == "undefined") {
        console.log("您的浏览器不支持WebSocket");
    } else {
        console.log("您的浏览器支持WebSocket");
//实现化WebSocket对象，指定要连接的服务器地址与端口 建立连接
//等同于socket = new WebSocket("ws://localhost:8083/checkcentersys/websocket/20");
//socket = new WebSocket("http://localhost:8080/websocket/".replace("http","ws"));
       // socket = new WebSocket("ws://localhost:8066/websocket/" + userName);//hx 为sid
        socket = new WebSocket("ws://94.191.100.44:8080/websocket/" + userName);//hx 为sid
        //打开事件
        socket.onopen = function () {
            console.log("Socket 已打开");
            $("#start").val("Socket 已打开")
        //socket.send("这是来自客户端的消息" + location.href + new Date());
        };

        //获得消息事件
        socket.onmessage = function (msg) {
            console.log(msg.data);
            messageEdit(msg.data);
            //_window._alert("信息", msg.data);
//发现消息进入 开始处理前端触发逻辑
        };
//关闭事件
        socket.onclose = function () {
            console.log("Socket已关闭");
            $("#close").val("Socket已关闭")
        };
//发生了错误事件
        socket.onerror = function () {
            alert("Socket发生了错误");
//此时可以尝试刷新页面
        }
//离开页面时，关闭socket
//jquery1.8中已经被废弃，3.0中已经移除
// $(window).unload(function(){
// socket.close();
//});
    }
    //客户端发送信息
    function sendMessage(){
        isMyself = true;
        var message = $('#message').val();
        if (message == '' || message == 'NULL' || message == null) {
            return;
        }
        socket.send(message);
        $('#message').val("");
    }
    function messageEdit(message){
        var arry = message.split("###");
        if (!isMyself) {
            if (message.indexOf('提醒') > -1) {
                _window._alert("提醒", arry[1]);
                return;
            }
        }
        var template = arry[0] + '   ' + _dateFormat(new Date().getTime(), "yyyy-MM-dd HH:mm:ss") + '<br/>';
        var newText = arry[1] + '<br/>';
        if (number >= 10) {
            $("#textContainer").html("");
            number = 0;
        }
        $("#textContainer").append(template + newText);
        number ++;
        isMyself = false;
    }
    $("body").keydown(function(e) {
        e=e||event;
        if(e.keyCode==13){
            $('#sendMessageId').click();
        }
        return;
    });
</script>

</body>
</html>
