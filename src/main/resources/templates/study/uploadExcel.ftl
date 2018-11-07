<div class="contentpanel container-fluid">
    <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding ">
            <form id="popWindowForm"  enctype="multipart/form-data" action='study/uploadExcel' method="post"  onkeydown="if(event.keyCode==13){return false;}"
                  class="form-horizontal -form-bordered " autocomplete="off"  target="_self">
                <div class="form-group">
                    <label class="col-xs-2 control-label">上传文件：</label>
                    <div class="col-xs-4">
                        <input type="file" id="file" name="file" placeholder="请选择" style="width:320px" required class="form-control">
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="row">
                        <div class="text-c">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <button type="button" class="btn btn-primary" onclick="popWindowSave()">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
<script>
    function popWindowSave() {
        var options = {
            type: 'post',
            url: 'study/uploadExcel',
            success: function (data) {
                alert();
                if (data.code == 1) {
                    _window._colsePopup();
                }else{
                    _window._alert("提示",data.msg);
                }
            }
        };
        $("#popWindowForm").ajaxSubmit(options);
        get();//此处为上传文件的进度条
    }
</script>