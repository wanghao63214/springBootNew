<div class="pageheader">
    <h2 style="color: white;"> JAVA学习计划 </h2>
</div>
<div class="contentpanel containermain">
    <div class="tab-content">
        <div>
            <form class="form-inline"  action="#" onkeydown="if(event.keyCode==13){return false;}">
                <shiro:hasPermission name="role:add">
                    <div class="form-group" style="float:left;padding-top:10px;margin-right:10px;">
                        <a id="roleAddItem" class="btn btn-primary btn-sm" href="javascript:void(0);" onclick="javascript:Container._add()" " style="width: 95px;">新增计划</a>
                    </div>
                </shiro:hasPermission>
                <div style="float:right;margin-right: 20px;margin-top: 10px;margin-bottom: 10px;">
                    <div class="w-105" style="float: right;margin-left: 0px;">
                        <button type="button" class="btn btn-primary btn-sm" onclick="javascript:Container._search()" >刷新</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <table id="queryTable"></table>
</div>
<script type="text/javascript">
    var queryUrl = 'study/studyPlanQuery.do';
    var subQueryUrl = 'study/subStudyPlanQuery.do';
    var addUrl = 'study/studyPlanAdd';
    //事件监听
    window.agEvents = {
        'click .agUserAddEventsClass': function (e, value, row, index) {
            _window._showPopup("添加用户", agUserAddUrl + '?agId='+ row.id, function(){
                //Container._search();
                subTable._search();
            });
        },
        'click .agUpdateEventsClass': function (e, value, row, index) {
            passoptions = row;
            _window._showPopup("修改代理商", agAddUrl, function(){
                Container._search();
            },'lg');
        },
        'click .agUserUpdateEventsClass': function (e, value, row, index) {
            passoptions = row;
            _window._showPopup("修改代理商用户", agUserUpdateUrl, function(){
                subTable._search();
            });
        },
        'click .agUserDisableClass': function (e, value, row, index) {
            var temp = row.userStatus==1?"是否停封该用户？":"是否启用该用户？";
            _window._confirm(temp, function(){
                subTable._changeUserstatus(row);
                subTable._search();
            });
        },
        'click .agUserPwdInitClass': function (e, value, row, index) {
            _window._confirm("是否确认重置密码", function(){
                subTable._userPwdInit(row);
            });
        },
        'click .agUserDelClass': function (e, value, row, index) {
            _window._confirm("是否确认删除用户", function(){
                subTable._userDel(row);
                subTable._search();
            });
        }
    }
    //开始
    var Container = {
        _pageNum : 1,
        _pageSize : 10,
        _offset : 0,
        _limit : 10,
        _height : function() {
            //return getToauditHeight() - 40;
        },
        _queryURL : queryUrl,
        _tableGrid : $("#queryTable"),
        _query : function() {
            Container._tableGrid
                    .bootstrapTable({
                        columns : [
                            {
                                field: "id", title: "序号", visible: true, align: "center",
                                formatter: function (value, row, index) {
                                    return ((Container._pageNum - 1) * Container._pageSize + index + 1);
                                }
                            },
                            {
                                field: "_operate_date", title: "日期", visible: true, align: "center"
                            },
                            {
                                field: "_content", title: "内容", visible: true, align: "center", width:"800px"
                            }
                        ],
                        queryParams : function(params) {
                            return params;
                        },
                        rowStyle : function(value, row, index) {
                            return {
                                classes : "divnowrap"
                            };
                        },
                        url : Container._queryURL,
                        idField : "id",
                        pageList : "[10]",
                        //toolbar : Container._toolbar,
                        search : false,
                        showToggle : false,
                        //showColumns : true,
                        minimumCountColumns : 2,
                        showPaginationSwitch : false,
                        pagination : true,
                        showFooter : false,
                        detailView : true,//父子表
                        height : Container._height(),
                        contentType : "application/x-www-form-urlencoded",
                        sidePagination : "server",
                        showExport : false,
                        onExpandRow : function(index, row, $detail) {
                           Container._initSubTable(index, row, $detail);
                        }
                    });
            Container._tableGrid.on('page-change.bs.table', function(number, size) {
                Container._pageNum = size; //获取当前页面
            });
        },
        _search : function() {
            Container._pageNum = 1;
            Container._tableGrid.bootstrapTable("refresh", {
                url : Container._queryURL
            });
        },
        _add : function() {
            _window._showPopup('新增计划', addUrl, function() {
                Container._search();
            },'lg');
        },
        _initSubTable : function(index, row, $detail) {
            subTable._table = $detail.html('<table></table>').find('table');
            subTable._query(row.id);
        },
        _export : function() {
            $('#agQueryForm').attr("action", 'ag/query_export.do?loginName=' + _userName).submit();
        },
        _changestatus : function(row){
            _window._showShade();
            $.ajax({
                type : "POST",
                url : 'ag/agStatusChange.do',
                data : {id:row.id, status:row.status},
                success : function(msg) {
                    _window._closeShade();
                    if (msg.code == 1) {
                        _window._alert("成功", '操作成功!');
                    } else {
                        _window._alert("失败", '操作失败!');
                    }
                    Container._search();
                }
            });
        },
    };
    var subTable = {
        _pageNum : 1,
        _pageSize : 10,
        _table : null,
        _queryURL : subQueryUrl,
        _query : function(id) {
            $(subTable._table)
                    .bootstrapTable(
                            {
                                columns : [
                                    {
                                        field : "id", title : "序号", visible : false,
                                        formatter: function(value, row, index) {
                                            return ((subTable._pageNum - 1) * (subTable._pageSize) + index + 1);
                                        }
                                    },
                                    {
                                        field : "_id", title : "_id", visible : false, align : "center"
                                    },
                                    {
                                        field : "_study_plan_id", title : "_study_plan_id", visible : false, align : "center"
                                    },
                                    {
                                        field : "_point", title : "要点", visible : true, align : "center"
                                    },
                                    {
                                        field : "_question", title : "问题", visible : true, align : "center"
                                    }  ],
                                queryParams : function(params) {
                                    params.agId = id;
                                    params._time = new Date().getTime();
                                    return params;
                                },
                                rowStyle : function(value, row, index) {
                                    return {
                                        classes : "divnowrap"
                                    };
                                },
                                url : subTable._queryURL,
                                idField : "id",
                                pageList : "[10]",
                                search : false,
                                showToggle : false,
                                showColumns : false,
                                minimumCountColumns : 2,
                                showPaginationSwitch : false,
                                pagination : true,
                                showFooter : false,
                                contentType : "application/x-www-form-urlencoded",
                                sidePagination : "server",
                                showExport : false,
                            });
            $(subTable._table).on('page-change.bs.table', function(number, size) {
                subTable._pageNum = size; //获取当前页面
            });
        },
        _search : function() {
            subTable._pageNum = 1;
            $(subTable._table).bootstrapTable("refresh", {
                url : subTable._queryURL
            });
        },
        _changeUserstatus : function(row){
            _window._showShade();
            $.ajax({
                type : "POST",
                url : 'ag/userStatusChange.do',
                data : {id:row.id, userStatus:row.userStatus},
                success : function(msg) {
                    _window._closeShade();
                    if (msg.code == 1) {
                        _window._alert("成功", '操作成功!');
                    } else {
                        _window._alert("失败", '操作失败!');
                    }

                }
            });
        },
        _userPwdInit: function (row){
            _window._showShade();
            $.ajax({
                type : "POST",
                url : 'ag/userPwdInit.do',
                data : {id:row.id},
                success : function(msg) {
                    _window._closeShade();
                    if (msg.code == 1) {
                        _window._alert("成功", '操作成功!');
                    } else {
                        _window._alert("失败", '操作失败!');
                    }

                }
            });
        },
        _userDel: function (row){
            _window._showShade();
            $.ajax({
                type : "POST",
                url : 'ag/userDel.do',
                data : {id:row.id},
                success : function(msg) {
                    _window._closeShade();
                    if (msg.code == 1) {
                        _window._alert("成功", '操作成功!');
                    } else {
                        _window._alert("失败", '操作失败!');
                    }

                }
            });
        }
    }
    // 初始化数据
    $(function() {
        // 初始化查询
        Container._query();

    });
</script>
