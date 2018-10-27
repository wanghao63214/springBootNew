$(document).ready(function(){
	//旋转角度
	var angles;
	//可抽奖次数
	var clickNum = 5;
	//旋转次数
	var rotNum = 1;
	//中奖公告
	var notice = null;
	//转盘初始化
	var color = ["#626262","#787878","rgba(0,0,0,0.5)","#DCC722","white","#FF4350"];
    var info = ["谢谢参与", "  1000", "   10", "  500", "  100", " 4999", "    1", "   20","12323", "ewrwer","dfgh"];
	canvasRun();
	$('#tupBtn').bind('click',function(){
		if (clickNum >= 1) {
			//可抽奖次数减一
			clickNum = clickNum-1;
			//转盘旋转
			runCup();
			//转盘旋转过程“开始抽奖”按钮无法点击
			$('#tupBtn').attr("disabled", true);
			//旋转次数加一
			rotNum = rotNum + 1;
			//“开始抽奖”按钮无法点击恢复点击
			setTimeout(function(){
				_window._alert("被选中的人", notice);
				$('#tupBtn').removeAttr("disabled", true);
			},6000);
		}
		else{
			alert("亲，抽奖次数已用光！");
		}
	});

	//转盘旋转
	function runCup(){
		probability();
		var degValue = 'rotate('+angles+'deg'+')';
		$('#myCanvas').css('-o-transform',degValue);           //Opera
		$('#myCanvas').css('-ms-transform',degValue);          //IE浏览器
		$('#myCanvas').css('-moz-transform',degValue);         //Firefox
		$('#myCanvas').css('-webkit-transform',degValue);      //Chrome和Safari
		$('#myCanvas').css('transform',degValue);
	}

	//各奖项对应的旋转角度及中奖公告内容
	function probability(){
		//获取随机数
        var num = parseInt(Math.random() * (info.length - 1 - 0 + 0) + 0);
        for (var i = 0; i < info.length; i++) {
            if (num == i) {
                angles = 2160 * rotNum + 1800 + (360 / info.length) * i;
                notice = info[info.length-i];
            }
        }
	}

	//绘制转盘
	function canvasRun(){
		var canvas=document.getElementById('myCanvas');
		var canvas01=document.getElementById('myCanvas01');
		var canvas03=document.getElementById('myCanvas03');
		var canvas02=document.getElementById('myCanvas02');
		var ctx=canvas.getContext('2d');
		var ctx1=canvas01.getContext('2d');
		var ctx3=canvas03.getContext('2d');
		var ctx2=canvas02.getContext('2d');
		createCircle();
		createCirText();
		initPoint();

		//外圆
		function createCircle(){
	        var startAngle = 0;//扇形的开始弧度
	        var endAngle = 0;//扇形的终止弧度
	        //画一个info.length等份扇形组成的圆形
	        for (var i = 0; i< info.length; i++){
	            startAngle = Math.PI*(i*2/info.length-1/info.length);//---------------------------------------------------------
	            endAngle = startAngle+Math.PI*(2/info.length);
	            ctx.save();
	            ctx.beginPath();
	            ctx.arc(150,150,100, startAngle, endAngle, false);
	            ctx.lineWidth = 120;
	            if (i%2 == 0) {
	            	ctx.strokeStyle =  color[0];
	            }else{
	            	ctx.strokeStyle =  color[1];
	            }
	            ctx.stroke();
	            ctx.restore();
	        }
	    }

	    //各奖项
	    function createCirText(){
		    ctx.textAlign='start';
		    ctx.textBaseline='middle';
		    ctx.fillStyle = color[3];
		    var step = 2*Math.PI/info.length;
		    for ( var i = 0; i < info.length; i++) {
		    	ctx.save();
                ctx.beginPath();
                ctx.translate(150,150);
                ctx.rotate(i*step);
                ctx.font = " 20px Microsoft YaHei";
                ctx.fillStyle = color[3];
                ctx.fillText(info[i], -ctx.measureText(info[i]).width / 2, 0);
                ctx.font = " 14px Microsoft YaHei";
		        ctx.closePath();
		        ctx.restore();
		    }
		}

		function initPoint(){
	        //箭头指针
	        ctx1.beginPath();
	        ctx1.moveTo(100,24);
	        ctx1.lineTo(90,62);
	        ctx1.lineTo(110,62);
	        ctx1.lineTo(100,24);
	        ctx1.fillStyle = color[5];
	        ctx1.fill();
	        ctx1.closePath();
	        //中间小圆
	        ctx3.beginPath();
	        ctx3.arc(100,100,40,0,Math.PI*2,false);
	        ctx3.fillStyle = color[5];
	        ctx3.fill();
	        ctx3.closePath();
	        //小圆文字
	        ctx3.font = "Bold 20px Microsoft YaHei";
		    ctx3.textAlign='start';
		    ctx3.textBaseline='middle';
		    ctx3.fillStyle = color[4];
	        ctx3.beginPath();
	        ctx3.fillText('开始',80,90,40);
	        ctx3.fillText('抽签',80,110,40);
	        ctx3.fill();
	        ctx3.closePath();
	        //中间圆圈
	        ctx2.beginPath();
	        ctx2.arc(75,75,75,0,Math.PI*2,false);
	        ctx2.fillStyle = color[2];
	        ctx2.fill();
	        ctx2.closePath();
		}
	}
});