<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String userAdd = "view/index.jsp?#platform/sysManage/userManage/userAdd";
%>
<div class="pageheader">
    <h2>
        用户管理
    </h2>
</div>
<div class="tab-content">
    <div id="userDiv">
        <form class="form-horizontal" onkeydown="if(event.keyCode==13){return false;}">

            <div style="float:left;width:100%;padding:10px 15px 0px 15px;">
                <shiro:hasPermission name="user:add">
                    <div class="form-group" style="float:left;">
                        <a id="userAddItem" class="btn btn-primary btn-sm"   href=<%= userAdd %>  onclick="javascript:passoptions='';">新增用户</a>
                    </div>
                </shiro:hasPermission>
                <div class="form-group" style="float:right;margin-right:6px;">
                    <button type="button" class="btn btn-primary btn-sm" onclick="queryTable()" style="margin-left: 1px;">刷新  </button>
                </div>
            </div>
        </form>
    </div>
    <table id="tableId"></table>
</div>
<script type="text/javascript">
    var userResetPwdUrlDo = locationHref + 'platform/sysManage/userManage/userResetPassword';
    var userAddDo = locationHref + 'platform/sysManage/userManage/userAdd';
    var $table = $('#tableId');
    var pageObject = {
        _pageNum: 1,
        _pageSize: 10
    };
    $(function () {

        window.operateEvents = {
            'click .pencil': function (e, value, row, index) {
                passoptions = row;
                window.location.href = userAddDo;
            },
            'click .resetPwd': function (e, value, row, index) {
                passoptions = row;
                window.location.href = userResetPwdUrlDo;
            }
        };
        $table.bootstrapTable({
            columns: [
                {
                    field: 'id',
                    title: '序号',
                    sortable: false,
                    visible: true,
                    align: 'center',
                    formatter: function (value, row, index) {
                        return ((pageObject._pageNum - 1) * pageObject._pageSize + index + 1);
                    }
                },
                {
                    field: 'userName',
                    title: '用户名',
                    sortable: false,
                    align: 'center',
                },
                {
                    field: 'anotherName',
                    title: '用户昵称',
                    sortable: false,
                    align: 'center',
                    formatter: function (value) {
                        if (!value) return;
                        var temp = value;
                        if (value.length > 10) {
                            temp = value.substring(0, 10) + '...';
                        }
                        return '<span title="' + value + '" href="javascript:void(0)">' + temp + '<span/>';
                    }
                }, {
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    events: operateEvents,
                    formatter: operateFormatter
                }],
            responseHandler: function responseHandler(data) { //处理server端返回的数据，格式化需要的格式
                if (1 == data.code) {
                    return {
                        rows: data.rows,
                        total: data.total
                    }
                } else {
                    return {
                        rows: [],
                        total: 0
                    }
                }
            },
            search: false,//是否显示表格搜索，此搜索是客户端搜索，不会进服务端
            showToggle: false,//是否显示详细视图和列表视图的切换按钮
            detailFormatter: 'detailFormatter',
            minimumCountColumns: 2,//最少允许的列数
            height: getToauditHeight(),//行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            queryParams: function (params) {
                params.userName = $("#name").val();
                //console.info(11111111111);
                return params;
            },
            showPaginationSwitch: false,//显示分页按钮选择
            pagination: true,//是否显示分页
            idField: 'id',
            pageList: '[10]',//可供选择的每页的行数（*）
            rowStyle: function (value, row, index) {
                return {
                    classes: "divnowrap"
                };
            },
            showFooter: false,//底部
            contentType: "application/x-www-form-urlencoded",//数据类型
            sidePagination: 'server',//分页方式：client客户端分页，server服务端分页（*）
            url: 'user/query.do',//请求的url
            showExport: false,//是否显示导出
            onClickRow: linesSelected
        });
        $('#userStatus').select2();//select2控件,改变select的样式
        //查询所有的角色
        select2Ajax({"selectId": 'roleName', "defaultText": '全部', "url": 'role/queryAllRoles.do'});
        /**
         *表格分页设置
         **/
        $table.on('page-change.bs.table', function (number, size) {
            pageObject._pageNum = size; //获取当前页面
        });
    });
    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }
    function operateFormatter(value, row, index) {
        return [
            '<shiro:hasPermission name="user:update">',
            '<a class=" pencil" href="javascript:void(0)" title="pencil">',
            '修改', '</a>',
            '</shiro:hasPermission>'].join('');
    }
    function queryTable() {
        pageObject._pageNum = 1;
        $table.bootstrapTable('refresh', {url: 'user/query.do'});
    }
</script>