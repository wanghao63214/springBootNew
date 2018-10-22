<%@ page  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<div class="pageheader" > <h2 style="color: white;"> 订单日志 </h2></div>
<div class="contentpanel containermain">
    <div class="tab-content">
        <form class="form-inline"  onsubmit="javascript:$queryTable.bootstrapTable('refresh', {url: 'role/query.do'});return false;"
              action="#" onkeydown="if(event.keyCode==13){return false;}" role="form">

            <label for="type" class="control-label">类型：</label>
            <select id="type" class="select2"  style="width:140px" class="form-control">
                <option value="">全部</option>
                <option value="0">其他</option>
                <option value="101" >补单失败日志</option>
            </select>

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
    <table id="queryTable"></table>
</div>
<script type="text/javascript">
    var queryUrl = 'logManage/listQuery.do';
    var $queryTable = $('#queryTable'), selections = [];
    var pageNum = 1;
    var pageSize = 10;
    var msg = '';
    var telephoneQueryPageUrl = 'view/logManage/orderLogMsgDetail.jsp';
    window.operateEvents = {
        'click .msgDetails': function (e, value, row, index) {
            msg = row.msg;
             _window._showPopup('信息详情', telephoneQueryPageUrl, function () {
             });
        }
    };
    $(function () {
        $('#type').select2();
        $("#dateTime").val(_dateFormat(new Date().getTime(), "yyyy-MM-dd"));
        $queryTable.bootstrapTable({
            columns: [
                {
                    field: '_id_', title: '序号', sortable: false, visible: true, align: 'center',
                    formatter: function (value, row, index) {
                        return ((pageNum - 1) * pageSize + index + 1);
                    }
                }, {
                    field: 'id', title: 'id', visible: false,
                }, {
                    field: 'jjy_bill_id', title: '家家悦订单', sortable: false, align: 'center'
                }, {
                    field: 'order_id', title: '订单ID', sortable: false, align: 'center'
                }, {
                    field: 'type', title: '类型', sortable: false, align: 'center'
                }, {
                    field: 'msg', title: '信息', sortable: false, align: 'center', events: operateEvents,
                    formatter: function (value) {
                        return popoverFormat(value);
                    }
                }, {
                    field: 'create_time', title: '创建日期', sortable: false, align: 'center',
                    formatter: function (value) {
                        return changeDateFormat(value)
                    }
                }
            ],
            search: false,
            showToggle: false,
            minimumCountColumns: 2,
            queryParams: function (params) {
                params.createTime = $('#dateTime').val();
                params.type = $('#type').val();
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

    function reFresh(){
        pageNum=1;
        $queryTable.bootstrapTable('refresh', {url: queryUrl});
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
     /*   return [
            '<span style="display:block; overflow: hidden; width:100px " role="button" data-toggle="popover" onmousemove="initPopover(this)" data-text="',
            value,
            '" > ',
            value,
            '</span>'
        ].join('');*/
    }

    function ContentMethod(txt) {
        return '<div style="overflow: hidden;">' + txt + '</div>';
    }

    function initPopover() {
        $('[data-toggle="popover"]').each(function () {
            var element = $(this);
            var id = element.attr('id');
            //var txt = element.data("text");
            var txt = element.html();
            element.popover({
                trigger: 'manual',
                placement: 'bottom', //top, bottom, left or right
                title: '详情',
                html: 'true',
                content: ContentMethod(txt),
            }).on("mouseenter", function () {
                var _this = this;
                $(this).popover("show");
                $(this).siblings(".popover").on("mouseleave", function () {
                    $(_this).popover('hide');
                });
            }).on("mouseleave", function () {
                var _this = this;
                setTimeout(function () {
                    if (!$(".popover:hover").length) {
                        $(_this).popover("hide")
                    }
                }, 100);
            });
        });
    }
</script>
