<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script src="<%=basePath%>js/lib/sanjiliandong/jquery.provincesCity.js"></script>
<script src="<%=basePath%>js/lib/sanjiliandong/provincesdata.js"></script>
<form id="basicForm" onkeydown="if(event.keyCode==13){return false;}"
	action='<%=basePath %>user/confirmPassword.do?userId=${userId}' method="post" class="form-horizontal" target="_self">

	<div class="panel panel-default">
		<div class="panel-body">
			<div class="form-group">
				<label class="col-xs-3 control-label">密码重置： <span
					class="asterisk">*</span></label>
				<div class="col-xs-9">
					<input type="password" name="password" value=""
						class="form-control" placeholder="请输入..." 
							data-bv-notempty="true"
							data-bv-notempty-message="确认密码不能为空"
							
							data-bv-stringlength="true"
							data-bv-stringlength-max="15"
							data-bv-stringlength-min="6"
							data-bv-stringlength-message="请输入6-15个字符"
							
							data-bv-identical="true"
							data-bv-identical-field="passwordConfirm"
							data-bv-identical-message="确认密码必须和密码一致"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-3 control-label">再次确认： <span
					class="asterisk">*</span></label>
				<div class="col-xs-9">
					<input type="password" name="passwordConfirm" value=""
						class="form-control" placeholder="请输入..." 
						data-bv-notempty="true"
							data-bv-notempty-message="确认密码不能为空"
							
							data-bv-stringlength="true"
							data-bv-stringlength-max="15"
							data-bv-stringlength-min="6"
							data-bv-stringlength-message="请输入6-15个字符"
							
							data-bv-identical="true"
							data-bv-identical-field="password"
							data-bv-identical-message="确认密码必须和密码一致"/>
				</div>
			</div>
		</div>
	</div>
	<!-- panel-body -->
	<div class="panel-footer">
		<div class="row">
			<div class="col-xs-7 col-sm-offset-3 text-center">
				<button class="btn btn-primary" type="submit">保存</button>
				<button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</form>


<script type="text/javascript">
	$(function() {
		
		$('#basicForm').bootstrapValidator();
		
		//form 表单提交用插件jQuery.form.js模拟iframe 开始
		var options = {
			success : function(data) {
				$("#themasklayer").hide(4);
				if (data.code == 0) {
					alert("添加成功");
					$('#mainmodefade').modal('hide');
					window.document.getElementsByTagName('iframe')[0].contentWindow.document
							.getElementById("querybutton").click();
				} else {
					alert(data.msg);
				}

			},
			beforeSubmit : function(a, form, options) {
				$("#themasklayer").show(4).children().css("z-index", "2551")
						.removeClass("hidden");
			}
		};
		$("#basicForm").ajaxForm(options);
		//form 表单提交用插件jQuery.form.js模拟iframe 结束
		$('#basicForm select[name="password"]').val('${user.password}');
		if ('${readorwrite}' == 'read') {
			$("#basicForm input[type='text']").attr('disabled', 'disabled ')
		}
	})
</script>
