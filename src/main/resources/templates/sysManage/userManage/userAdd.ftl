<div class="contentpanel container-fluid">
    <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding ">
            <form id="addUserForm123" action='user/add.do' method="post"  onkeydown="if(event.keyCode==13){return false;}"
                  class="form-horizontal -form-bordered " autocomplete="off"  target="_self">
                <div class="form-group">
                    <label class="col-xs-2 control-label">用户名： <span class="asterisk">*</span></label>
                    <div class="col-xs-4">

                        <input type="text" id="userName" name="userName" placeholder="用户名" style="width:320px" required class="form-control">
                    </div>
                </div>
                <div class="form-group" id="passwordDiv">
                    <label class="col-xs-2 control-label">密码： <span class="asterisk">*</span></label>
                    <div class="col-xs-4">
                        <!-- 防止自动填写用户名和密码 -->
                        <input type="text" style="display:none">
                        <input type="password" id="hide" class="form-control" style="display:none" required>
                        <input type="password" id="password" name="password" style="width:320px"  placeholder="密码" class="form-control" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">确认密码： <span class="asterisk">*</span></label>
                    <div class="col-xs-4">
                        <input type="password" id="confirmPwd" name="confirmPwd" style="width:320px"
                               placeholder="确认密码" class="form-control" required
                               data-bv-identical="true" data-bv-identical-field="password"
                               data-bv-identical-message="确认密码必须和密码一致" data-bv-different="true">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">盐值： <span class="asterisk">*</span></label>
                    <div class="col-xs-4">
                        <input type="text" id="salt" name="salt" placeholder="盐值" required style="width:320px"
                               class="form-control" required data-bv-notempty="true"
                               data-bv-notempty-message="盐值不能为空">
                    </div>
                </div>
                <div class="form-group">
                    <label for="roleId" class="col-xs-2 control-label">角色名称： <span class="asterisk">*</span></label>
                    <div class="col-xs-4">
                        <select style="width:320px" class="select2" id="roleId" name="roleId" required>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="app_poi_code" class="col-xs-2 control-label">门店： <span class="asterisk">*</span></label>
                    <div class="col-xs-4">
                        <select id="app_poi_code" class="select2" style="width:320px" class="form-control">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">手机号：</label>
                    <div class="col-xs-4">
                        <input type="text" id="mobile" name="mobile" placeholder="手机号" class="form-control" style="width:320px">
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

    var insertUrl = "user/insert.do";
    $(function () {
        select2Ajax({"selectId": 'app_poi_code', "defaultText": '全部', "url": 'orderManage/completedOrder/getApp.do'});
        select2Ajax({"selectId": 'roleId', "url": 'roles/getRolesSelect.do'});
    });
    function submitForm() {
        _window._showShade();
        $.ajax({
            type: "POST",
            url: insertUrl,
            data: {
                rolename: $('#roleName_1').val(),
                username: $('#userName').val(),
                pwd: $('#password').val(),
                salt: $('#salt').val(),
                roleid: $('#roleId').val(),
                usermobile: $('#mobile').val(),
                appPoiCode: $('#app_poi_code').val(),

            },
            success: function (msg) {
                _window._closeShade();
                if (msg.code == 1) {
                    _window._confirm('添加用户成功!', function () {
                    }, true)
                    _window._colsePopup();
                } else {

                }
            }
        });
    }
</script>