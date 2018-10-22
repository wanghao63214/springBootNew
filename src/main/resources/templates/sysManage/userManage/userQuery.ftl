<div class="pageheader">
    <h2> 用户管理 </h2>
</div>
<div class="tab-content">
    <div id="userDiv">
        <form class="form-horizontal" onkeydown="if(event.keyCode==13){return false;}">
            <div style="float:left;width:100%;padding:10px 15px 0px 15px;">
                <shiro:hasPermission name="user:add">
                    <div class="form-group" style="float:left;">
                        <a id="userAddItem" class="btn btn-primary btn-sm"   onclick="addUser()" style="width: 95px;"  href="javascript:void(0);" >新增用户</a>
                    </div>
                </shiro:hasPermission>
                <div class="form-group" style="float:right;margin-right:6px;">
                    <button type="button" class="btn btn-primary btn-sm" onclick="reFreshTable()" style="margin-left: 1px;">刷新  </button>
                </div>
            </div>
        </form>
    </div>
    <table id="queryTable"></table>
</div>

<script type="text/javascript">
    var userId = '';
    var pageNum = 1;
    var pageSize = 10;
    var userAddPageUrl = 'user/userAddPage';
    var queryUrl = 'user/userQuery.do';
    var initPasswordUrl = 'user/initPassword.do';
    var queryTable = $('#queryTable'), selections = [];
    window.operateEvents = {
        'click .initPassword': function (e, value, row, index) {
            userId = row._id;
            _window._confirm('确定初始化密码？', function () {
                initPassword();
            })
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
                    field: '_id', title: '用户id', sortable: false, align: 'center', visible: false
                }, {
                    field: '_roleName', title: '角色名称', sortable: false, align: 'center', visible: true
                }, {
                    field: 'shop_name', title: '门店', sortable: false, align: 'center', visible: true
                }, {
                    field: '_userName', title: '用户名称', sortable: false, align: 'center',
                }, {
                    field: '_userMobile', title: '用户手机号', sortable: false, visible: 'ture', align: 'center',
                }, {
                    field: 'operate', title: '操作', align: 'center', events: operateEvents, formatter: operateFormatter
                }
            ],
            //toolbar: '#formDiv',
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
            '<a class="initPassword" href="javascript:void(0)" title="初始化密码">初始化密码',
            '</a>',
            '</shiro:hasPermission>'
        ].join('');
    }

    function addUser() {
        _window._showPopup('新增用户', userAddPageUrl, function () {
            reFreshTable();
        });
    }

    function reFreshTable() {
        pageNum = 1;
        queryTable.bootstrapTable('refresh', {url: queryUrl});
    }
    function initPassword(){
        $.ajax({
            type: "POST",
            url: initPasswordUrl,
            data: {
                id: userId,
            },
            success: function (msg) {
                _window._closeShade();
                if (msg.code == 1) {
                    _window._confirm('密码初始化成功!', function () {
                    }, true)
                } else {
                    _window._confirm('密码初始化失败!', function () {
                    }, true)
                }
                _window._colsePopup();
            }
        });
    }
</script>