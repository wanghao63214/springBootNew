<!DOCTYPE html>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>work</title>
</head>
<body>

<form class="form-inline" action="#"  role="form">

    <button type="button" class="btn btn-primary btn-md"
            onclick="sendMq()" id="sendMessageId" style="margin-left: 10px;">mq发送
    </button>
    <div class="form-group" style="margin:5px">
        <input name="message" type="text" style="width:300px;" class="form-control" id="message" />
    </div>
</form>
<div>
    <span class="form-control"  style="width:500px;background:silver">
        mq接收
    </span>
</div>
<div class="jumbotron" style="width:500px;height:560px">
    <span class="container" id="textContainer">

    </span>
</div>
<iframe id="my_iframe" style="display:none;"></iframe>
<script type="application/javascript">
    var sendUrl = "mq/send";
    function sendMq() {
        $.ajax({
            type: "POST",
            url: sendUrl,
            data: {
                msg: $('#message').val()
            }
        });
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
