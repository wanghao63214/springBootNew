<div class="pageheader">
    <h2 style="color: white;"> JAVA学习计划 </h2>
</div>

<div class="contentpanel containermain">
    <div class="tab-content">
        <div>
            <form class="form-inline" action="#" onkeydown="if(event.keyCode==13){return false;}">
                <shiro:hasPermission name="role:add">
                    <div class="form-group" style="float:left;padding-top:10px;margin-right:10px;">
                        <a id="roleAddItem" class="btn btn-primary btn-sm" href="javascript:void(0);"
                           onclick="javascript:Container._add()" " style="width: 95px;">新增计划</a>
                    </div>
                    <div class="form-group" style="float:left;padding-top:10px;margin-right:10px;">
                        <a id="roleAddItem" class="btn btn-primary btn-sm" href="javascript:void(0);"
                           onclick="javascript:Container._add()" " style="width: 95px;">execel批量下载</a>
                    </div>
                </shiro:hasPermission>
                <div style="float:right;margin-right: 20px;margin-top: 10px;margin-bottom: 10px;">
                    <div class="w-105" style="float: right;margin-left: 0px;">
                        <button type="button" class="btn btn-primary btn-sm" onclick="javascript:Container._search()">
                            刷新
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <table id="queryTable"></table>
    <div>
        <div class="jumbotron">
            <h3>研发二部部员JAVA基础培训规则</h3>
            <span style="display:block">  1，每次培训结束，主持人随机抽选并公布下次培训主持人。</span>
            <span style="display:block">  2，主持人根据计划培训，并准备问题，在每次培训完成之后对每个人提问。</span>
            <span style="display:block">  3，参训人员根据计划，准备问题，在每次培训期间对主持人提问，每人最少一个问题，不得同其他参训人员重复。</span>
            <span style="display:block">  4，下次培训时间由抽选出的下次培训主持人公布。</span>
        </div>
    </div>
</div>
<script type="text/javascript">
    var queryUrl = 'study/studyPlanQuery.do';
    var subQueryUrl = 'study/subStudyPlanQuery.do';
    var addUrl = 'study/studyPlanAdd';
    var uploadUrl = 'study/uploadPage';
    //事件监听
    window.operateEvents = {
        'click .updateFile': function (e, value, row, index) {
            _window._showPopup('上传', uploadUrl + "?id=" + row._id, function () {
                Container._search();
            }, 'md');
        }
    };
    //开始
    var Container = {
        _pageNum: 1,
        _pageSize: 10,
        _offset: 0,
        _limit: 10,
        _height: function () {
            //return getToauditHeight() - 40;
        },
        _queryURL: queryUrl,
        _tableGrid: $("#queryTable"),
        _query: function () {
            Container._tableGrid
                    .bootstrapTable({
                        columns: [
                            {
                                field: "id", title: "序号", visible: true, align: "center",
                                formatter: function (value, row, index) {
                                    return ((Container._pageNum - 1) * Container._pageSize + index + 1);
                                }
                            },
                            {
                                field: "_id", title: "_id", visible: false, align: "center"
                            },
                            {
                                field: "_operate_date", title: "日期", visible: true, align: "center"
                            },
                            {
                                field: "_content", title: "内容", visible: true, align: "center", width: "800px"
                            },
                            {
                                field: "_attachment_url", title: "附件", visible: true, align: "center",
                                formatter: function (value, row, index) {
                                    if (value != null && value != '') {
                                        var downloadBaseUrl = "study/downloadFile?" + "id=" + row._id + "&attachmentUrl=" + value;
                                        return [
                                            "<a class='glyphicon glyphicon-paperclip' download='" + value + "' " +
                                            " href='study/downloadFile?id=" + row._id +
                                            "&attachmentUrl=" + value + "' style='cursor: pointer;'></a>"
                                        ].join('');
                                    } else {
                                        return "-";
                                    }
                                }
                            }, {
                                field: 'operate', title: '更新附件', align: 'center', events: operateEvents, formatter: operateFormatter
                            }
                        ],
                        queryParams: function (params) {
                            return params;
                        },
                        rowStyle: function (value, row, index) {
                            return {
                                classes: "divnowrap"
                            };
                        },
                        url: Container._queryURL,
                        idField: "id",
                        pageList: "[10]",
                        //toolbar : Container._toolbar,
                        search: false,
                        showToggle: false,
                        //showColumns : true,
                        minimumCountColumns: 2,
                        showPaginationSwitch: false,
                        pagination: true,
                        showFooter: false,
                        detailView: true,//父子表
                        height: Container._height(),
                        contentType: "application/x-www-form-urlencoded",
                        sidePagination: "server",
                        showExport: false,
                        onExpandRow: function (index, row, $detail) {
                            Container._initSubTable(index, row, $detail);
                        }
                    });
            Container._tableGrid.on('page-change.bs.table', function (number, size) {
                Container._pageNum = size; //获取当前页面
            });
        },
        _search: function () {
            Container._pageNum = 1;
            Container._tableGrid.bootstrapTable("refresh", {
                url: Container._queryURL
            });
        },
        _add: function () {
            _window._showPopup('新增计划', addUrl, function () {
                Container._search();
            }, 'lg');
        },
        _downloadFile: function (row) {
            $.ajax({
                type: "POST",
                url: 'study/downloadFile',
                data: {_id: row._id},
                success: function (msg) {
                    if (msg.code == 1) {
                        // window.location.href = downloadBaseUrl + msg.attachment;
                    } else {
                        _window._alert("提示", '下载异常！');
                    }
                }
            });
        },
        _initSubTable: function (index, row, $detail) {
            subTable._table = $detail.html('<table></table>').find('table');
            subTable._query(row._id);
        },
        _export: function () {
            $('#agQueryForm').attr("action", 'ag/query_export.do?loginName=' + _userName).submit();
        },
        _changestatus: function (row) {
            _window._showShade();
            $.ajax({
                type: "POST",
                url: 'ag/agStatusChange.do',
                data: {id: row.id, status: row.status},
                success: function (msg) {
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
        _pageNum: 1,
        _pageSize: 10,
        _table: null,
        _queryURL: subQueryUrl,
        _query: function (id) {
            $(subTable._table)
                    .bootstrapTable(
                            {
                                columns: [
                                    {
                                        field: "id", title: "序号", visible: false,
                                        formatter: function (value, row, index) {
                                            return ((subTable._pageNum - 1) * (subTable._pageSize) + index + 1);
                                        }
                                    },
                                    {
                                        field: "_id", title: "_id", visible: false, align: "center"
                                    },
                                    {
                                        field: "_study_plan_id",
                                        title: "_study_plan_id",
                                        visible: false,
                                        align: "center"
                                    },
                                    {
                                        field: "_point", title: "知识点", visible: true, align: "center"
                                    },
                                    {
                                        field: "_question", title: "问题", visible: true, align: "center"
                                    }, {
                                        field: "_use_case", title: "使用场景", visible: true, align: "center"
                                    }],
                                queryParams: function (params) {
                                    params.studyPlanId = id;
                                    return params;
                                },
                                rowStyle: function (value, row, index) {
                                    return {
                                        classes: "divnowrap"
                                    };
                                },
                                url: subTable._queryURL,
                                idField: "id",
                                pageList: "[10]",
                                search: false,
                                showToggle: false,
                                showColumns: false,
                                minimumCountColumns: 2,
                                showPaginationSwitch: false,
                                pagination: true,
                                showFooter: false,
                                contentType: "application/x-www-form-urlencoded",
                                sidePagination: "server",
                                showExport: false,
                            });
            $(subTable._table).on('page-change.bs.table', function (number, size) {
                subTable._pageNum = size; //获取当前页面
            });
        },
        _search: function () {
            subTable._pageNum = 1;
            $(subTable._table).bootstrapTable("refresh", {
                url: subTable._queryURL
            });
        },
        _changeUserstatus: function (row) {
            _window._showShade();
            $.ajax({
                type: "POST",
                url: 'ag/userStatusChange.do',
                data: {id: row.id, userStatus: row.userStatus},
                success: function (msg) {
                    _window._closeShade();
                    if (msg.code == 1) {
                        _window._alert("成功", '操作成功!');
                    } else {
                        _window._alert("失败", '操作失败!');
                    }

                }
            });
        },
        _userPwdInit: function (row) {
            _window._showShade();
            $.ajax({
                type: "POST",
                url: 'ag/userPwdInit.do',
                data: {id: row.id},
                success: function (msg) {
                    _window._closeShade();
                    if (msg.code == 1) {
                        _window._alert("成功", '操作成功!');
                    } else {
                        _window._alert("失败", '操作失败!');
                    }

                }
            });
        },
        _userDel: function (row) {
            _window._showShade();
            $.ajax({
                type: "POST",
                url: 'ag/userDel.do',
                data: {id: row.id},
                success: function (msg) {
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
    $(function () {
        // 初始化查询
        Container._query();

    });
    function operateFormatter(value, row, index) {
        return [
            '<a class="updateFile" href="javascript:void(0)" title="上传">上传',
            '</a>'
        ].join('');
    }
</script>
