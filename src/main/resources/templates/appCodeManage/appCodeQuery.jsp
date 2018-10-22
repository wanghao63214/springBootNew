<%@ page  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<div class="pageheader" > <h2 style="color: white;"> 门店查询 </h2></div>
<div class="contentpanel containermain">
    <div class="tab-content">
    </div>
    <table id="queryTable"></table>
</div>
<script type="text/javascript">
    var queryUrl = 'appCode/query.do';
    var $queryTable = $('#queryTable'), selections = [];
    var pageNum = 1;
    var pageSize = 10;
    $(function () {
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
                    field: 'port', title: '端口', sortable: false, align: 'center',
                }, {
                    field: 'db_id', title: '数据源序号', sortable: false, align: 'center',
                }, {
                    field: 'db_name', title: '数据源名称', sortable: false, align: 'center',
                }, {
                    field: 'shop_id', title: '门店代码', sortable: false, align: 'center',
                }, {
                    field: 'app_poi_code', title: 'APP方门店id', sortable: false, align: 'center',
                }, {
                    field: 'shop_name', title: '门店名称', sortable: false, align: 'center',
                }, {
                    field: 'app_id', title: '美团分配给APP方的id', sortable: false, align: 'center',
                }, {
                    field: 'app_secret', title: '美团门店密码', sortable: false, align: 'center',
                }
            ],
            search: false,
            showToggle: false,
            minimumCountColumns: 2,
            queryParams: function (params) {
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

    });

    function reFresh(){
        pageNum=1;
        $queryTable.bootstrapTable('refresh', {url: queryUrl});
    }
</script>
