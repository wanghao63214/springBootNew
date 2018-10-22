<!DOCTYPE html>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>弹窗</title>
</head>

<body>
<h2>33</h2>
<input id="start">
<input id="message">
<iframe id="my_iframe" style="display:none;"></iframe>
<script type="application/javascript">
    var socket;
    if (typeof(WebSocket) == "undefined") {
        console.log("您的浏览器不支持WebSocket");
    } else {
        console.log("您的浏览器支持WebSocket");
//实现化WebSocket对象，指定要连接的服务器地址与端口 建立连接
//等同于socket = new WebSocket("ws://localhost:8083/checkcentersys/websocket/20");
//socket = new WebSocket("http://localhost:8080/websocket/".replace("http","ws"));
        socket = new WebSocket("ws://localhost:8066/websocket/33");
//打开事件
        socket.onopen = function () {
            console.log("Socket 已打开");
            $("#start").val("Socket 已打开")
//socket.send("这是来自客户端的消息" + location.href + new Date());
        };
//获得消息事件
        socket.onmessage = function (msg) {
            console.log(msg.data);
            $("#message").val(msg.data);
            _window._alert("信息", msg.data);
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
</script>

</body>
</html>
