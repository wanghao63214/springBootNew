<%@ page  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<div class="pageheader" > <h2 style="color: white;"> 订单查询 </h2></div>
<div class="contentpanel containermain">
	<div class="tab-content">
		<div>
			<form class="form-inline"  onsubmit="javascript:$queryTable.bootstrapTable('refresh', {url: 'role/query.do'});return false;"
				  action="#" onkeydown="if(event.keyCode==13){return false;}" role="form">


				<div class="form-group" style="margin:5px">
					<label for="dateTimeFrom" class="control-label">开始：</label>
					<input name="dateTimeFrom" placeholder="请选择日期"  type="text" style="width:150px; background-color:white"
						   class="form-control" readonly="readonly" id="dateTimeFrom" >
				</div>
                <div class="form-group" style="margin:5px">
                    <label for="dateTimeEnd" class="control-label">结束：</label>
                    <input name="dateTimeEnd" placeholder="请选择日期"  type="text" style="width:150px; background-color:white"
                           class="form-control" readonly="readonly" id="dateTimeEnd" >
                </div>
                <div class="form-group" style="margin:5px">
                    <label for="foodNameOne" class="control-label">商品1：</label>
                    <input name="foodNameOne" placeholder="请输入商品名"  type="text" style="width:150px;"
                           class="form-control"  id="foodNameOne" >
                </div>
                <div class="form-group" style="margin:5px">
                    <label for="foodNameTwo" class="control-label">商品2：</label>
                    <input name="foodNameTwo" placeholder="请输入商品名"  type="text" style="width:150px;"
                           class="form-control"  id="foodNameTwo" >
                </div>
                <div class="form-group" style="margin:5px">
                    <label for="foodNameThree" class="control-label">商品3：</label>
                    <input name="foodNameThree" placeholder="请输入商品名"  type="text" style="width:150px;"
                           class="form-control"  id="foodNameThree" >
                </div>
				<div class="form-group" style="margin:5px">
					<div style="float:right;margin-right: 20px;margin-top: 10px;margin-bottom: 10px;">
						<button type="button" class="btn btn-primary btn-sm" onclick="reFresh()">查询</button>
                        <button type="button" class="btn btn-primary btn-sm" onclick="clearFormData()">清空</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<table id="queryTable"></table>
</div>
<script type="text/javascript">

    var queryUrl = 'orderManage/order/telephoneQuery.do';
    var $queryTable = $('#queryTable'), selections = [];
    var pageNum = 1;
    var pageSize = 10;
    var food_name_check = '';
    var orderLogMsgDetailPageUrl = 'view/EBusinessManage/foodDetails.jsp';
    window.operateEvents = {
        'click .msgDetails': function (e, value, row, index) {
            food_name_check = row.food_name_check;
            _window._showPopup('商品详情', orderLogMsgDetailPageUrl, function () {
            });
        }
    };
    $(function () {
        //$("#dateTime").val(_dateFormat(new Date().getTime() - 24 * 60 * 60 * 1000, "yyyy-MM-dd"));
        _datetimepicker('dateTimeFrom', 'dateTimeEnd');
        $("#dateTimeFrom").val(_dateFormat(new Date().getTime() - 10 * 24 * 60 * 60 * 1000, "yyyy-MM-dd"));
        $("#dateTimeEnd").val(_dateFormat(new Date().getTime() + 1 * 24 * 60 * 60 * 1000, "yyyy-MM-dd"));
        $queryTable.bootstrapTable({
            columns: [
                {
                    field: 'id', title: '序号', sortable: false, visible: true, align: 'center',
                    formatter: function (value, row, index) {
                        return ((pageNum - 1) * pageSize + index + 1);
                    }
                }, {
                    field: 'order_id', title: '订单号', sortable: false, align: 'center',
                }, {
                    field: 'recipient_phone', title: '收件人电话', sortable: false, align: 'center',
                }, {
                    field: 'recipient_name', title: '收件人姓名', sortable: false, align: 'center',
                }, {
                    field: 'day_seq', title: '日序列号', sortable: false, align: 'center',
                }, {
                    field: 'food_name_check', title: '商品详情', sortable: false, align: 'center',events: operateEvents,
                    formatter: function (value) {
                        return popoverFormat(value);
                    }
                }, {
                    field: 'order_completed_time', title: '创建时间', sortable: false, visible: true, align: 'center',
                    formatter: function (value) {
                        return changeDateFormat(value)
                    }
                }
            ],
            //toolbar:'#formDiv',
            search: false,
            showToggle: false,
            minimumCountColumns: 2,
            queryParams: function (params) {
                params.foodNameOne = $('#foodNameOne').val();
                params.foodNameTwo = $('#foodNameTwo').val();
                params.foodNameThree = $('#foodNameThree').val();
                params.dateFrom = $('#dateTimeFrom').val();
                params.dateEnd = $('#dateTimeEnd').val();
                return params;
            },
            showPaginationSwitch: false,
            pagination: true,
            idField: 'id',
            pageList: '[10]',
            showFooter: false,
            height: getToauditHeight(),
            onClickRow: linesSelected,
            detailFormatter: 'detailFormatter',
            rowStyle: function (value, row, index) {
                return {classes: "divnowrap"};
            },
            contentType: "application/x-www-form-urlencoded",
            sidePagination: 'server',
            url: queryUrl,
            showExport: false
        });
        /**
         *表格分页设置
         **/
        $queryTable.on('page-change.bs.table', function (number, size) {
            pageNum = size; //获取当前页面
        });

        $("#dateTime").datetimepicker({//选择年月日
            format: 'yyyy-mm-dd',
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,//显示‘今日’按钮
            autoclose: true,
            initialDate: new Date(),//初始化当前日期
            todayHighlight: 1,
            startView: 2,
            minView: 2,  //Number, String. 默认值：0, 'hour'，日期时间选择器所能够提供的最精确的时间选择视图。
            clearBtn: true,//清除按钮
            forceParse: 0,
        });

    });
    function popoverFormat(value){
        if (value.length > 30) {
            return [
                '<span">',
                value.substring(0,30) + '...',
                '</span> ',
                '<a class="msgDetails" href="javascript:void(0)" title="查看详情">查看详情',
                '</a>'
            ].join('');
        } else{
            return [
                '<span">',
                value,
                '</span> '
            ].join('');
        }
    }
    //修改——转换日期格式(时间戳转换为datetime格式)
    function changeDateFormat(cellval) {
        if (cellval != null) {
            var date = new Date(cellval);
            var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
            var currentDay = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
            var currentHour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
            var currentMinute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
            var currentSecond = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
            return date.getFullYear() + "-" + month + "-" + currentDay + " " + currentHour + ":" + currentMinute + ":" + currentSecond;
        }
    }
    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }

    function operateFormatter(value, row, index) {
        return [
            '<shiro:hasPermission name="role:update">',
            '<a class="accredit" href="javascript:void(0)" title="赋权">赋权',
            '</a>&nbsp;&nbsp;|&nbsp;&nbsp;',
            '<a class="modify" href="javascript:void(0)" title="修改">修改',
            '</a>',
            '</shiro:hasPermission>'
        ].join('');
    }

    function reFresh(){
        pageNum=1;
        $queryTable.bootstrapTable('refresh', {url: queryUrl});
    }
    function clearFormData(){
        $('#foodNameOne').val("");
        $('#foodNameTwo').val("");
        $('#foodNameThree').val("");
    }
</script>
