<div class="contentpanel container-fluid">
    <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding ">
            <form id="form"  enctype="multipart/form-data" action='study/uploadFile' method="post"  onkeydown="if(event.keyCode==13){return false;}"
                  class="form-horizontal -form-bordered " autocomplete="off"  target="_self">
                <input type="hidden" name="id" value=${id}>
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
                            <button type="button" class="btn btn-primary" onclick="save()">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
<script>
    function save() {
        _window._showShade();
        var options = {
            type: 'post',
            url: 'study/uploadFile',
            success: function () {
                _window._closeShade();
                _window._colsePopup();
            }
        };
        $("#form").ajaxSubmit(options);
        get();//此处为上传文件的进度条
        _window
    }
</script>