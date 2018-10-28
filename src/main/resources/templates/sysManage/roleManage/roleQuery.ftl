<div class="pageheader">
    <h2 style="color: white;"> 角色管理 </h2>
</div>
<div class="contentpanel containermain">
    <div class="tab-content">
        <div>
            <form class="form-inline"  action="#" onkeydown="if(event.keyCode==13){return false;}">
                <shiro:hasPermission name="role:add">
                    <div class="form-group" style="float:left;padding-top:10px;margin-right:10px;">
                        <a id="roleAddItem" class="btn btn-primary btn-sm" href="javascript:void(0);"  onclick="addRole(); " style="width: 95px;">新增角色</a>
                    </div>
                </shiro:hasPermission>
                <div style="float:right;margin-right: 20px;margin-top: 10px;margin-bottom: 10px;">
                    <div class="w-105" style="float: right;margin-left: 0px;">
                        <button type="button" class="btn btn-primary btn-sm" onclick="reFreshTable()">刷新</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <table id="queryTable"></table>
</div>
<script type="text/javascript">
    var roleId = '';
    var pageNum = 1;
    var pageSize = 10;
    var roleEmpowerPageUrl = 'roles/roleEmpowerPage';
    var roleAddPageUrl = 'view/sysManage/roleManage/roleAdd.jsp';
    var queryUrl = 'roles/roleQuery.do';
    var queryTable = $('#queryTable'), selections = [];
    window.operateEvents = {
        'click .modify': function (e, value, row, index) {
           /* roleId = row;
            _window._showPopup('修改角色', roleAddUrl, function () {
                pageNum = 1;
                queryTable.bootstrapTable('refresh', {url: 'role/query.do'});
            });*/
        },
        //授权
        'click .accredit': function (e, value, row, index) {
            roleId = row._id;
            _window._showPopup('赋权', roleEmpowerPageUrl, function () {
            }, 'md');
        }
    };
    $(function () {
        queryTable.bootstrapTable({
            columns: [
                {
                    field: 'id', title: '序号', sortable: false, visible: true, align: 'center',
                    formatter: function (value, row, index) {
                        return ((pageNum - 1) * pageSize + index + 1);
                    }
                }, {
                    field: '_id', title: '角色id', sortable: false, align: 'center', visible: false
                }, {
                    field: '_roleName', title: '角色名称', sortable: false, align: 'center',
                }, {
                    field: '_updateTime', title: '上次修改时间', sortable: false, visible: false, align: 'center',
                }, {
                    field: 'operate', title: '操作', align: 'center', events: operateEvents, formatter: operateFormatter
                }
            ],
            toolbar: '#formDiv',
            search: false,
            showToggle: false,
            minimumCountColumns: 2,
            queryParams: function (params) {
                params.roleName = $("#rName").val();
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
        queryTable.on('page-change.bs.table', function (number, size) {
            pageNum = size; //获取当前页面
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
            '<shiro:hasPermission name="role:update">',
            '<a class="accredit" href="javascript:void(0)" title="赋权">赋权',
            '</a>&nbsp;&nbsp;|&nbsp;&nbsp;',
            '<a class="modify" href="javascript:void(0)" title="修改">修改',
            '</a>',
            '</shiro:hasPermission>'
        ].join('');
    }

    function addRole() {
        _window._showPopup('新增角色', roleAddPageUrl, function () {
            reFreshTable();
        });
    }

    function reFreshTable(){
        pageNum=1;
        queryTable.bootstrapTable('refresh', {url: queryUrl});
    }
</script>
