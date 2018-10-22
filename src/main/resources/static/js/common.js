/**
 * 将毫秒转为日期格式
 * @param time 时间毫秒
 * @param format 日期格式 'yyyy-MM-dd HH:mm:ss'
 * @returns string
 */
function _dateFormat(time, format) {
	var t = new Date(time);
	var tf = function(i) {
		return (i < 10 ? '0' : '') + i
	};
	return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a) {
		switch (a) {
			case 'yyyy':
				return tf(t.getFullYear());
				break;
			case 'MM':
				return tf(t.getMonth() + 1);
				break;
			case 'mm':
				return tf(t.getMinutes());
				break;
			case 'dd':
				return tf(t.getDate());
				break;
			case 'HH':
				return tf(t.getHours());
				break;
			case 'ss':
				return tf(t.getSeconds());
				break;
		}
	});
}

/**
 * 将毫秒转为日期格式
 * @param time 时间毫秒
 * @returns string  yyyy-MM-dd HH:mm:ss
 */
function formatDate(time) {
	var t = new Date(time);
	var tf = function(i) {
		return (i < 10 ? '0' : '') + i
	};
	return "yyyy-MM-dd HH:mm:ss".replace(/yyyy|MM|dd|HH|mm|ss/g, function(a) {
		switch (a) {
			case 'yyyy':
				return tf(t.getFullYear());
				break;
			case 'MM':
				return tf(t.getMonth() + 1);
				break;
			case 'mm':
				return tf(t.getMinutes());
				break;
			case 'dd':
				return tf(t.getDate());
				break;
			case 'HH':
				return tf(t.getHours());
				break;
			case 'ss':
				return tf(t.getSeconds());
				break;
		}
	});
}

/**
 * 将字符串转为日期
 * @param dateStr  字符串日期格式:2016-03-16
 * @returns {Date}
 */
function strToDate(dateStr) {
	//转换成Date();
	var date = new Date(dateStr.replace(/-/g,"/"));
	return date;
}

/**
 * ajax请求封装
 * @param url 请求地址
 * @param params 参数必传，如没有参可直接传空对象:{}
 * @param callback 回调处理方法
 */
function _post(url, params, callback){
	// 参数追加时间戳
	eval("params._time=" + new Date().getTime());
	$.post(url, params, function(data) {
		callback(data);
	});
}


/**
 * 公共文件处理
 */
_FilePreview = {
		/**
		 * cp相关的证件
		 * @param fileNmae
		 */
		_cpCertificate: function(value){//CP资质
			if (value == '' || value == null 	|| value == undefined) {
				return "缺少文件";
			}else{
				// 
				return '<a  href="'	+ _publicCpApt + value+ '" class="btn btn-link btn-xs" target="_blank">查看</a>';
			}
		},
		_publicApkUrl: function(value) {//apk
			if (value == '' || value == null 	|| value == undefined) {
				return "缺少文件";
			}else{
				return '<a href="'+ _publicApkUrl +value+'"  role="button"  target="_blank" class="btn btn-link btn-xs"  >下载</a>';
			}
		},
		_publicAptUrl: function(value) {//应用资质
			if (value == '' || value == null 	|| value == undefined) {
				return "缺少文件";
			}else{
				return '<a  href="'+ _publicAptUrl +value+'" class="btn btn-link btn-xs" target="_blank">查看</a>';
			}
		},
		_publicAuditFile: function(value){//审核文档
			if (value == '' || value == null 	|| value == undefined) {
				return "缺少文件";
			}else{
				return '<a  href="'+ _publicAuditFile +value+'" class="btn btn-link btn-xs" target="_blank">下载</a>';
			}
		},
		_publicAppApy: function(value){//支付流程文档
			if (value == '' || value == null 	|| value == undefined) {
				return "缺少文件";
			}else{
				return '<a  href="'+ _publicAppApy +value+'" class="btn btn-link btn-xs" target="_blank">下载</a>';
			}
		},
		_publicHFSdk: function(value){//话费SDK
			if (value == '' || value == null 	|| value == undefined) {
				return "缺少文件";
			}else{
				return '<a  href="'+ _publicHFSdk +value+'" class="btn btn-link btn-xs" target="_blank">下载</a>';
			}
		},
		_publicOtherSdk: function(value){//第三方SDK
			if (value == '' || value == null 	|| value == undefined) {
				return "缺少文件";
			}else{
				return '<a  href="'+ _publicOtherSdk +value+'" class="btn btn-link btn-xs" target="_blank">下载</a>';
			}
		}
		
}
//在bootstrapTable 中使用改变被选中状态onClickRow:linesSelected
function linesSelected(row, $element){
	$element.parent().find("tr[class*='bg-info']").removeClass('bg-info');
	$element.addClass('bg-info');
}
//回话过期标识符
_whetherpromptreplyexpired=0;
//回话过期弹出层使用公共方法 {"code":2,"msg":"登录超时"}
function promptInformation(data){
/*	$.messager.model = { 
			ok:{ text: "关闭", classed: 'btn-success' },
			cancel: { text: "取消", classed: 'btn-error hidden' }
	};*/
	if(data.code==2){
		if(_whetherpromptreplyexpired==0){
			_whetherpromptreplyexpired=1
			$.messager.confirm("提示", "会话过期，请重新登录!", function() {
				_whetherpromptreplyexpired=0;
				window.location.href=_basePath+'view/login.jsp'
			});
		}
	}
}
common = (function(window, $) {
    return {
        getProvince: function() {
            return [{
                "id": "10",
                "name": "全国"
            }, {
                "id": "1021",
                "name": "上海"
            }, {
                "id": "10871",
                "name": "云南"
            }, {
                "id": "10471",
                "name": "内蒙古"
            }, {
                "id": "1010",
                "name": "北京"
            }, {
                "id": "10431",
                "name": "吉林"
            }, {
                "id": "1028",
                "name": "四川"
            }, {
                "id": "1022",
                "name": "天津"
            }, {
                "id": "10951",
                "name": "宁夏"
            }, {
                "id": "10551",
                "name": "安徽"
            }, {
                "id": "10531",
                "name": "山东"
            }, {
                "id": "10351",
                "name": "山西"
            }, {
                "id": "1020",
                "name": "广东"
            }, {
                "id": "10771",
                "name": "广西"
            }, {
                "id": "10991",
                "name": "新疆"
            }, {
                "id": "1025",
                "name": "江苏"
            }, {
                "id": "10791",
                "name": "江西"
            }, {
                "id": "10312",
                "name": "河北"
            }, {
                "id": "10371",
                "name": "河南"
            }, {
                "id": "10571",
                "name": "浙江"
            }, {
                "id": "10898",
                "name": "海南"
            }, {
                "id": "1027",
                "name": "湖北"
            }, {
                "id": "10731",
                "name": "湖南"
            }, {
                "id": "10931",
                "name": "甘肃"
            }, {
                "id": "10591",
                "name": "福建"
            }, {
                "id": "10891",
                "name": "西藏"
            }, {
                "id": "10851",
                "name": "贵州"
            }, {
                "id": "1024",
                "name": "辽宁"
            }, {
                "id": "1023",
                "name": "重庆"
            }, {
                "id": "1029",
                "name": "陕西"
            }, {
                "id": "10971",
                "name": "青海"
            }, {
                "id": "10451",
                "name": "黑龙江"
            }, ]
        }
    }
})(window, $);
