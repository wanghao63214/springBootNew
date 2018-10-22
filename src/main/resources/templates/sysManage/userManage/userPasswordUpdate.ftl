<div class="container-fluid" style="margin-top: 20px;">
    <form class="form-horizontal" id="roleForm" action="#" method="post"
          onkeydown="if(event.keyCode==13){return false;}">
        <div class="form-group" id="oldPasswordDiv">
            <label class="col-xs-2 control-label">原密码： <span class="asterisk">*</span></label>
            <div class="col-xs-4">
                <!-- 防止自动填写用户名和密码 -->
                <input type="text" style="display:none">
                <input type="password" id="hide" class="form-control" style="display:none" required>
                <input type="password" id="oldPassword" name="password" style="width:320px"  placeholder="密码" class="form-control" required>
            </div>
        </div>
        <div class="form-group" id="passwordDiv">
            <label class="col-xs-2 control-label">密码： <span class="asterisk">*</span></label>
            <div class="col-xs-4">
                <input type="password" id="password" name="password" style="width:320px"  placeholder="密码" class="form-control" required>
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">确认： <span class="asterisk">*</span></label>
            <div class="col-xs-4">
                <input type="password" id="confirmPwd" name="confirmPwd" style="width:320px"
                       placeholder="确认密码" class="form-control" required
                       data-bv-identical="true" data-bv-identical-field="password"
                       data-bv-identical-message="确认密码必须和密码一致" data-bv-different="true">
            </div>
        </div>
        <div class="form-group" style="margin-top: 70px;">
            <div class="col-xs-offset-2 col-sm-7">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <button type="button" onclick="submitFormPopWindow()" class="btn btn-primary">保存</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
       var updatePasswordUrlPopWindow = "user/updatePassword.do";
       function submitFormPopWindow() {
           var oldPassword = $('#oldPassword').val();
           var password = $('#password').val();
           var confirmPwd = $('#confirmPwd').val();
           if (!oldPassword || !password || !confirmPwd) {
               alert("密码不允许为空！");
               return;
           }
           if (password != confirmPwd) {
               alert("确认密码和密码不相同！");
               return;
           }
           _window._showShade();
           $.ajax({
               type: "POST",
               url: updatePasswordUrlPopWindow,
               data: {oldPassword: oldPassword, password: password, confirmPwd: confirmPwd},
               success: function (msg) {
                   _window._closeShade();
                   if (msg.code == 1) {
                       _window._confirm('密码修改成功!', function () {
                       }, true)
                       _window._colsePopup();
                   } else {
                       _window._confirm('密码修改失败!', function () {
                       }, true)
                   }
               }
           });
       }
</script>