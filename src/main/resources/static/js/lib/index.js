var options;
var serverIp = "";
var passoptions = '', passoptionsstate = '';
var callbackobj;
var applicationId="";
var fileUploadFormat="doc,docx,xls,xlsx,rar,zip";
var fileSizeFormat=10;
var pageNum_pass = false;
var _screenHeight=screen.height/768;//全局分辨率大小
var locationHref = window.location.href + '#';
//页面table高度计算
function getToauditHeight() {
	//return $('.mainpanel').height() -$('.headerbar').height()-$('.pageheader').height()-85;
}
function confirmalert(modalTitel, modalContent) {
	$('#modalContent').empty();
	$('#confirmalertModalLabel').html(modalTitel);
	$('#modalContent').html(modalContent);
}

/**
 * 根据id添加计费类型
 * 
 * @param selectId
 */
function selectBillingType(selectId) {
	var json = "[{'id':-1,'text':'全部'},{'id':1,'text':'点播'},{'id':2,'text':'包月'}]";
	_select2(selectId, json);
}
/**
 * 日期默认参数
 */
var _date = {
	minView : "month", // 选择日期后，不会再跳转去选择时分秒
	format : "yyyy-mm-dd", // 选择日期后，文本框显示的日期格式
	language : 'zh-CN', // 汉化
	// startDate: new Date(), // 开始时间
	endDate : new Date(), // 结束时间
	todayHighlight : true,
	todayBtn : true, // 日期时间选择器组件的底部显示一个 "Today"
	autoclose : true
// 选择日期后自动关闭
}

/**
 * 日期区间控制
 * 
 * @param datetimeStart
 *            开始日期元素id
 * @param datetimeEnd
 *            结束日期元素id
 * @param days
 *            开始日期和结束日期的间隔，可不传，默认40天           
 */
function _datetimepicker(datetimeStart, datetimeEnd, days) {
	// 初始化日期的值
	$("#" + datetimeStart + " input,#" + datetimeEnd + " input").val(
			_dateFormat(new Date().getTime(), "yyyy-MM-dd"));
	// 最大日期跨度，包含当日40天
	// var days = 40;
	if(null == days || undefined == days){
		days = 40;
	}
	// 开始日期改变日期时间
	$("#" + datetimeStart).datetimepicker(_date).on(
			'changeDate',
			function(ev) {
				// 设置结束日期的开始日期只能是开始日期
				$("#" + datetimeEnd).datetimepicker("setStartDate", ev.date);
				// 设定最后结束日期
				var endDate = new Date(ev.date);
				// 包含当日 days需-1
				endDate.setDate(endDate.getDate() + (days - 1));
				if (endDate.getTime() < new Date().getTime()) {
					// 设定结束日期选择器的最小日期
					$("#" + datetimeEnd).datetimepicker("setEndDate", endDate);
				}
				// 当前结束日期
				var valDate = strToDate($("#" + datetimeEnd + " input").val());
				// 如果当前结束日期大于选择的最大结束日期，将值设置为最大结束日期
				if (valDate.getTime() > endDate.getTime()) {
					// 设定结束日期默认值
					$("#" + datetimeEnd + " input").val(
							dateFormat(endDate.getTime(), "yyyy-MM-dd"));
				} else if (valDate.getTime() < ev.date.getTime()) {// 如果当前结束日期小于选择的日期，将值设置为选择的日期
					// 设定结束日期默认值
					$("#" + datetimeEnd + " input").val(
							dateFormat(ev.date.getTime(), "yyyy-MM-dd"));
				}
			});
	// 结束日期改变日期时间
	$("#" + datetimeEnd).datetimepicker(_date)
			.on(
					"changeDate",
					function(ev) {
						$("#" + datetimeStart).datetimepicker("setEndDate",
								ev.date);
						// 设定最后结束日期
						var startDate = new Date(ev.date);
						// 包含当日 days需+1
						startDate.setDate(startDate.getDate() - (days + 1));
						$("#" + datetimeStart).datetimepicker("setStartDate",
								startDate);
						// 当前默认值
						var valDate = strToDate($(
								"#" + datetimeStart + " input").val());
						// 如果当前开始日期的值大于选择的结束日期将开始日期设置为选择的结束日期
						if (ev.date.getTime() < valDate.getTime()) {
							// 设定开始日期默认值
							$("#" + datetimeStart + " input")
									.val(
											dateFormat(ev.date.getTime(),
													"yyyy-MM-dd"));
						} else if (startDate.getTime() > valDate.getTime()) { // 如果当前开始日期的值小于选择的开始日期的最小日期，设置为最小日期
							// 设定开始日期默认值
							$("#" + datetimeStart + " input").val(
									dateFormat(startDate.getTime(),
											"yyyy-MM-dd"));
						}

					});
}

/**
 * 查询商品名称下拉选
 */
function selectAjax(url, selectId) {
    _post(url, {}, function (data) {
        _select2(selectId, JSON.stringify(data));
    });
}

function _select2(selectId, json) {
	$("#" + selectId).select2({
		data : eval(json)
	});
}

//绑定字典内容到指定的Select控件
function select2Ajax(option, callBack) {
	var defaultOption = {
		"selectId" : '',
		"defaultText" : '--请选择--',
		"url" : '',
		"params" : '{}',
		"value" : ''
	}
	var selectId = option.selectId || defaultOption.selectId  ;
	var defaultText = option.defaultText || defaultOption.defaultText  ;
	var url =  option.url || defaultOption.url ;
	var params = option.params || defaultOption.params  ;
	var value = option.value || defaultOption.value ;
  var control = $('#' + selectId);
  if(!url){
	  control.empty();//清空下拉框
	  control.append("<option value=''>"+ defaultText +"</option>");
	  control.select2({
	});
	  return;
  }
  //设置Select2的处理
  //绑定Ajax的内容
  $.post(url, params, function(data) {
    control.empty();//清空下拉框
    control.append("<option value=''>"+ defaultText +"</option>");
    $.each(data, function (i, item) {
      control.append("<option value='" + item.id + "'> " + item.text + "</option>");
    });
    control.select2({
	}).select2("val", value);
    if(callBack){
    	callBack();
    }
  });
  	
}
/**
 * 下拉框动态传入数据
 * @param selectId
 * @param url
 * @param params
 */
function selectAjaxT(selectId, url, params){
	$.post(url, params, function(data) {
		var temp = {"id":"","text":"--请选择--"};
		data.splice(0,0,temp);
		_select2(selectId, JSON.stringify(data));
	});
}

$.ajaxSetup({
    contentType : "application/x-www-form-urlencoded;charset=utf-8",
    complete:function(XMLHttpRequest, textStatus){
            var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus"); //通过XMLHttpRequest取得响应头，sessionstatus，
            if(sessionstatus == "timeout"){
                        //如果超时就处理 ，指定要跳转的页面
            			_window._confirm("登录超时!", function callBack(){
            				window.location.href = 'logout.do';
            			},"yes");
            			
            }
    }
});

//页面resize事件
$(window).resize(function(event) {
	//$('.mainpanel').width($('#content-box').width());
	$('.mainpanel').css("min-width",$('#content-box').width());
});
/*setInterval(function(){
	$('.mainpanel').css("min-width",$('#content-box').width());
},1000);*/

$(window).scroll(function(event) {
	$(window).resize();
});
