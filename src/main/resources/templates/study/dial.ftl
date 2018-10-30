<#assign base=request.contextPath />
<!DOCTYPE html>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<div class="TurntablePage" style="height:800px;">
     <div style="height:600px;width:500px;float:left;">
        <!--选择框 -->
        <div class="editContent" style="width:100%;font-size:18px;margin-top:150px;margin-left:60px">
            <select id='callbacks' multiple='multiple' style="height:300px;">
                <option value='姜松' selected>姜松</option>
                <option value='李杰' selected>李杰</option>
                <option value='尹军辉' selected>尹军辉</option>
                <option value='郑锟鹏' selected>郑锟鹏</option>
                <option value='宋霄霄' selected>宋霄霄</option>
                <option value='范湘誉' selected>范湘誉</option>
                <option value='姜贵祥' selected>姜贵祥</option>
                <option value='夏伟佳' selected>夏伟佳</option>
                <option value='谭晓杰' selected>谭晓杰</option>
                <option value='张泽亮' selected>张泽亮</option>
                <option value='丰顺' selected>丰顺</option>
                <option value='王浩' selected>王浩</option>
                <option value='刘帅' selected>刘帅</option>
                <option value='姜伯远' selected>姜伯远</option>
                <option value='朴哲峰' selected>朴哲峰</option>
            </select>
        </div>
    </div>
    <div style="height:600px;width:500px;float:left;">
        <!--大转盘-->
        <div class="TurntableBox" style="height:500px;width:100%">
            <div class="turnplate" style="height:500px;width:500px;">
                <canvas class="item" id="wheelcanvas" width="422px" height="422px"></canvas>
                <img class="pointer" src="${base}images/img/start.png">
            </div>
        </div>
    </div>
    <div style="height:600px;width:230px;margin-top:30px;margin-left:40px;float:left;background:white;padding:4px;">
        <div style="padding-left:60px;padding-top:20px;">
            <h5>被选中的讲师</h5>
        </div>
        <div class="container" id="textContainer" style="">
        </div>
    </div>
</div>
<!-- dial -->
<script src="${base}js/dial/flexible_css.debug.js"></script>
<script src="${base}js/dial/makegrid.debug.js"></script>
<link href="${base}css/dial/style.css" rel="stylesheet" />
<script src="${base}js/dial/awardRotate.js"></script>
<!-- select-->
<link rel="stylesheet" type="text/css" href="${base}css/select/multi-select.css">
<script src="${base}js/select/jquery.multi-select.js"></script>
<script type="text/javascript">
    $(function () {
        // run callbacks
        $('#callbacks').multiSelect({
            afterSelect: function(values){
                turnplate.restaraunts = $('#callbacks').val();
                drawRouletteWheel();
            },
            afterDeselect: function(values){
                turnplate.restaraunts = $('#callbacks').val();
                drawRouletteWheel();
            },
            selectableHeader: "<div class='custom-header' >可选</div>",
            selectionHeader: "<div class='custom-header'>已选</div>"
        });
        //页面所有元素加载完毕后执行drawRouletteWheel()方法对转盘进行渲染
        var turnplate = {
            restaraunts: [],				//大转盘奖品名称
            colors: [],					//大转盘奖品区块对应背景颜色
            outsideRadius: 192,			//大转盘外圆的半径
            textRadius: 150,				//大转盘奖品位置距离圆心的距离
            insideRadius: 20,			//大转盘内圆的半径
            startAngle: 0,				//开始角度
            bRotate: false				//false:停止;ture:旋转
        };
        //动态添加大转盘的奖品与奖品区域背景颜色
        turnplate.restaraunts = $('#callbacks').val();
        colorsArr = ["#FFF8DC", "#F0F8FF", '#F5DEB3'];
        returnColor();

        function returnColor() {
            var a = turnplate.restaraunts.length;
            var color = turnplate.restaraunts.map(function (item, index, array) {
                if (a % 2) {
                    return (index + 1) == a ? colorsArr[2] : colorsArr[index % 2]
                } else {
                    return colorsArr[index % 2];
                }
            })
            turnplate.colors = color;
        }

        $('.title').on('input', 'input', function () {
            $(this).val() == '' ? $(this).siblings('a').hide() : $(this).siblings('a').show();
        })
        $('.optionBox').on('input', '.options input', function (e) {
            $(this).val() == '' ? $(this).siblings('a').hide() : $(this).siblings('a').show();
            if ($('.optionBox .options input').length > 2) {
                if ($(this).val() == '') {
                    $(this).parent('.options').remove();
                }
            }
        });
        $('body').on('click', '.delete', function () {
            $(this).siblings('input').val('');
            $(this).hide();
        });

        $('.addInput').click(function () {
            $('.optionBox').append('<div class="options"><input type="text" placeholder="输入新选项(最多五个字符)"  /><a href="javascript:;" class="delete"></a> </div>');
        });

        function buildDom() {
            var html = '';
            turnplate.restaraunts.forEach(function (item, index, array) {
                html += '<div class="options"><input type="text" value=""  /><a href="javascript:;" class="delete"></a> </div>';
            });
            $('.optionBox').html(html)
        }

        window.onload = function () {
            drawRouletteWheel();
        };
        $('.done').click(function () {
            returnColor();
            drawRouletteWheel();
            $(this).hide().siblings('.editBtn').show();
            $('.editBtn').show();
            $('.TurntableBox').show();
        });
        $('.pointer').click(function () {
            if (turnplate.bRotate) return;
            turnplate.bRotate = !turnplate.bRotate;
            //获取随机数(奖品个数范围内)
            var item = rnd(1, turnplate.restaraunts.length);
            //奖品数量等于10,指针落在对应奖品区域的中心角度[252, 216, 180, 144, 108, 72, 36, 360, 324, 288]
            rotateFn(item, turnplate.restaraunts[item - 1]);

        });

        function rnd(n, m) {
            var random = Math.floor(Math.random() * (m - n + 1) + n);
            return random;
        }

        var rotateTimeOut = function () {
            $('#wheelcanvas').rotate({
                angle: 0,
                animateTo: 2160,
                duration: 8000,
                callback: function () {
                    alert('网络超时，请检查您的网络设置！');
                }
            });
        };
        //旋转转盘 item:奖品位置; txt：提示语;
        var rotateFn = function (item, txt) {
            var angles = item * (360 / turnplate.restaraunts.length) - (360 / (turnplate.restaraunts.length * 2));
            if (angles < 270) {
                angles = 270 - angles;
            } else {
                angles = 360 - angles + 270;
            }
            $('#wheelcanvas').stopRotate();
            $('#wheelcanvas').rotate({
                angle: 0,
                animateTo: angles + 1800,
                duration: 8000,
                callback: function () {
                    console.log(txt);
                    setTimeout(function () {
                            dialResultRedisSave(txt);
                    }, 2);
                    turnplate.bRotate = !turnplate.bRotate;
                }
            });
        };
        function dialResultRedisSave(txt){
            $.ajax({
                type : "POST",
                url : 'study/dialResultRedisSave',
                data: {choosenName: txt},
                success : function(msg) {
                    $("#textContainer").html('');
                    $("#textContainer").append(msg.msg);
                }
            });
        }
        function dialResultRedisQuery(){
            $.ajax({
                type : "POST",
                url : 'study/dialResultRedisQuery',
                data: {},
                success : function(msg) {
                    $("#textContainer").html('');
                    $("#textContainer").append(msg.msg);
                }
            });
        }
        function drawRouletteWheel() {
            turnplate.restaraunts = turnplate.restaraunts == null ? ["没有值了！"] : turnplate.restaraunts;
            var canvas = document.getElementById("wheelcanvas");
            if (canvas.getContext) {
                //根据奖品个数计算圆周角度
                var arc = Math.PI / (turnplate.restaraunts.length / 2);
                var ctx = canvas.getContext("2d");
                //在给定矩形内清空一个矩形
                ctx.clearRect(0, 0, 422, 422);
                //strokeStyle 属性设置或返回用于笔触的颜色、渐变或模式
                ctx.strokeStyle = "#FFBE04";
                //font 属性设置或返回画布上文本内容的当前字体属性
                ctx.font = '16px Microsoft YaHei';
                for (var i = 0; i < turnplate.restaraunts.length; i++) {
                    var angle = turnplate.startAngle + i * arc;
                    ctx.fillStyle = turnplate.colors[i];
                    ctx.beginPath();
                    //arc(x,y,r,起始角,结束角,绘制方向) 方法创建弧/曲线（用于创建圆或部分圆）
                    ctx.arc(211, 211, turnplate.outsideRadius, angle, angle + arc, false);
                    ctx.arc(211, 211, turnplate.insideRadius, angle + arc, angle, true);
                    ctx.stroke();
                    ctx.fill();
                    //锁画布(为了保存之前的画布状态)
                    ctx.save();
                    //----绘制奖品开始----
                    ctx.fillStyle = "#E5302F";
                    var text = turnplate.restaraunts[i];
                    var line_height = 17;
                    //translate方法重新映射画布上的 (0,0) 位置
                    ctx.translate(211 + Math.cos(angle + arc / 2) * turnplate.textRadius, 211 + Math.sin(angle + arc / 2) * turnplate.textRadius);
                    //rotate方法旋转当前的绘图
                    ctx.rotate(angle + arc / 2 + Math.PI / 2);
                    /** 下面代码根据奖品类型、奖品名称长度渲染不同效果，如字体、颜色、图片效果。(具体根据实际情况改变) **/
                    if (text.length > 6) {//奖品名称长度超过一定范围
                        text = text.substring(0, 5) + "||" + text.substring(5);
                        var texts = text.split("||");
                        for (var j = 0; j < texts.length; j++) {
                            ctx.fillText(texts[j], -ctx.measureText(texts[j]).width / 3, j * line_height);
                        }
                    } else {
                        //在画布上绘制填色的文本。文本的默认颜色是黑色
                        //measureText()方法返回包含一个对象，该对象包含以像素计的指定字体宽度
                        ctx.fillText(text, -ctx.measureText(text).width / 2, 0);
                    }
                    ctx.restore();
                    //----绘制奖品结束----
                }
            }
        }
        returnColor();
        drawRouletteWheel();
        dialResultRedisQuery();
    });
</script>
</body>
</html>
