<%@ page  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<div class="pageheader" > <h2 style="color: white;"> 订单查询 </h2></div>
<div class="contentpanel containermain">
	<div class="tab-content">
		<div>
			<form class="form-inline"  onsubmit="javascript:$queryTable.bootstrapTable('refresh', {url: 'role/query.do'});return false;"
				  action="#" onkeydown="if(event.keyCode==13){return false;}" role="form">
				<div class="form-group" style="margin:5px">
					<label for="app_poi_code" class="control-label">门店：</label>
					<select id="app_poi_code" class="select2" style="width:320px" class="form-control">
					</select>
				</div>
				<div class="form-group" style="margin:5px">
					<label for="jjy_diff_type" class="control-label">正常/补单：</label>
					<select id="jjy_diff_type" class="select2"  style="width:120px" class="form-control">
						<option value="">全部</option>
						<option value="0">正常单</option>
						<option value="1" selected="selected">补单</option>
						<option value="2">订单推送异常单</option>
					</select>
				</div>
				<div class="form-group" style="margin:5px">
					<label for="jjy_order_type" class="control-label">销售/退款：</label>
					<select id="jjy_order_type" class="select2"  style="width:120px" class="form-control">
						<option value="">全部</option>
						<option value="0">销售单</option>
						<option value="1">全额退款单</option>
						<option value="2">部分退款单</option>
					</select>
				</div>
				<div class="form-group" style="margin:5px">
					<label for="jjy_push_type" class="control-label">drp：</label>
					<select id="jjy_push_type" class="select2"  style="width:120px" class="form-control">
						<option value="">全部</option>
						<option value="0">未推送到drp</option>
						<option value="1">已推送到drp</option>
						<option value="2">推送drp失败</option>
					</select>
				</div>
				<div class="form-group" style="margin:5px">
					<label for="dateTime" class="control-label">日期：</label>
					<input name="datepicker" placeholder="请选择日期"  type="text" style="width:150px; background-color:white"
						   class="form-control" readonly="readonly" id="dateTime" >
				</div>

				<div class="form-group" style="margin:5px">
					<div style="float:right;margin-right: 20px;margin-top: 10px;margin-bottom: 10px;">
						<button type="button" class="btn btn-primary btn-sm" onclick="reFresh()">查询</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<table id="queryTable"></table>
</div>
<script type="text/javascript">

    var queryUrl = 'orderManage/completedOrder/query.do';
    var $queryTable = $('#queryTable'), selections = [];
    var pageNum = 1;
    var pageSize = 10;
    $(function () {
        $("#dateTime").val(_dateFormat(new Date().getTime() - 24 * 60 * 60 * 1000, "yyyy-MM-dd"));
        if(app_poi_code=="null"){
            select2Ajax({"selectId": 'app_poi_code', "defaultText": '全部', "url": 'orderManage/completedOrder/getApp.do'});
		}else{
            select2Ajax({"selectId": 'app_poi_code', "value": app_poi_code, "defaultText": '全部', "url": 'orderManage/completedOrder/getApp.do'});
            $("#app_poi_code").attr("disabled", "disabled");
        }
        $('#jjy_diff_type').select2();
        $('#jjy_push_type').select2();
        $('#jjy_order_type').select2();
        $queryTable.bootstrapTable({
            columns: [
                {
                    field: 'id', title: '序号', sortable: false, visible: true, align: 'center',
                    formatter: function (value, row, index) {
                        return ((pageNum - 1) * pageSize + index + 1);
                    }
                }, {
                    field: 'wm_order_id_view', title: '订单号', sortable: false, align: 'center',
                },{
                    field: 'jjy_diff_type', title: '订单类型', sortable: false, align: 'center',
                    formatter: function (value, row, index) {
                        if (value == 0) {
                            value = "正常单";
                        } else if (value == 1) {
                            value = "补单";
                        } else if (value == 2) {
                            value = "订单推送异常单";
                        }
                        return value;
                    }
                }, {
                    field: 'app_poi_code', title: '门店号', sortable: false, align: 'center',
                }, {
                    field: 'total', title: ' 总价（元）', sortable: false, align: 'center',
                }, {
                    field: 'jjy_bill_id', title: ' 账单', sortable: false, align: 'center',
                }, {
                    field: 'jjy_order_type', title: '订单状态', sortable: false, align: 'center',
                    formatter: function (value, row, index) {
                        if (value == 0) {
                            value = "销售单";
                        } else if (value == 1) {
                            value = "全额退款单";
                        } else if (value == 2) {
                            value = "部分退款单";
                        }
                        return value;
                    }
                }, {
                    field: 'jjy_push_type', title: '推送drp状态', sortable: false, align: 'center',
                    formatter: function (value, row, index) {
                        if (value == 0) {
                            value = "未推送到drp";
                        } else if (value == 1) {
                            value = "已推送到drp";
                        } else if (value == 2) {
                            value = "推送drp失败";
                        }
                        return value;
                    }
                }, {
                    field: 'order_completed_time', title: '订单完成时间', sortable: false, visible: true, align: 'center',
                    formatter: function (value) {
                        return changeDateFormat(value)
                    }
                }, {
                    field: 'create_time', title: '创建时间', sortable: false, visible: true, align: 'center',
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
                params.appPoiCode = $("#app_poi_code").val();
                params.jjyDiffType = $("#jjy_diff_type").val();
                params.jjyOrderType = $("#jjy_order_type").val();
                params.jjyPushType = $("#jjy_push_type").val();
                params.orderCompletedTime = $("#dateTime").val();
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
</script>
