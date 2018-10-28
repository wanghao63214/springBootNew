<div class="contentpanel container-fluid">
    <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding ">
            <form id="addUserForm123" action='user/add.do' method="post"  onkeydown="if(event.keyCode==13){return false;}"
                  class="form-horizontal -form-bordered " autocomplete="off"  target="_self">
                <div class="form-group">
                    <label class="col-xs-2 control-label">内容： <span class="asterisk">*</span></label>
                    <div class="col-xs-4">
                        <input type="text" id="content" name="content" placeholder="内容" style="width:320px" required class="form-control">
                    </div>
                </div>
                <div class="form-group" style="margin-top:5px">
                    <label for="dateTime"  class="col-xs-2 control-label">日期：<span class="asterisk">*</span></label>
                    <div class="col-xs-4">
                        <input name="datepicker" placeholder="请选择日期"  type="text" style="width:320px; background-color:white"
                           class="form-control" readonly="readonly" id="dateTime" >
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="row">
                        <div class="text-c">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <button type="button" class="btn btn-primary" onclick="submitForm()">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>

<script type="text/javascript">

    var insertUrl = "study/insert.do";
    $(function () {
        $("#dateTime").val(_dateFormat(new Date().getTime(), "yyyy-MM-dd"));
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
    function submitForm() {
        _window._showShade();
        $.ajax({
            type: "POST",
            url: insertUrl,
            data: {
                content: $('#content').val(),
                operateDate: $('#dateTime').val()
            },
            success: function (msg) {
                _window._closeShade();
                if (msg.code == 1) {
                    _window._confirm('操作成功!', function () {
                    }, true)
                    _window._colsePopup();
                } else {

                }
            }
        });
    }
</script>