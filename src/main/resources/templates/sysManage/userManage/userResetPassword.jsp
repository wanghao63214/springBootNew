<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="pageheader">
	<h2>
		<i class="fa fa-edit"></i>用户管理
	</h2>
</div>
<div class="contentpanel container-fluid">
	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="panel-btns">
				<a id="back" 
					class="panel-close">×</a>
			</div>
			<h4 class="panel-title" id="panelTitleId">密码重置</h4>
		</div>
		<div class="panel-body panel-body-nopadding ">
			<form id="addUserForm124" action='user/updatePassword.do' method="post"
				class="form-horizontal -form-bordered " autocomplete="off" onkeydown="if(event.keyCode==13){return false;}"
				target="_self">
				<div class="form-group" style="display: none;">
					<label class="col-xs-2 control-label">用户ID：</label>
					<div class="col-xs-4">
						<input type="hidden" id="id" name="userId" placeholder="用户ID"
							class="form-control">
					</div>
				</div>
				<div class="form-group" id="passwordDiv">
					<label class="col-xs-2 control-label">新密码：</label>
					<div class="col-xs-4">
						<input type="password" id="password" name="password"
							placeholder="密码" class="form-control" required
							data-bv-stringlength="true" data-bv-stringlength-max="15"
							data-bv-stringlength-min="6"
							data-bv-stringlength-message="请输入6-15个字符"
							/>
					</div>
				</div>
				<div class="form-group" id="confirmPwdDiv">
					<label class="col-xs-2 control-label">确认密码：</label>
					<div class="col-xs-4">
						<input type="password" id="confirmPwd" name="confirmPwd"
							placeholder="确认密码" class="form-control" required
							data-bv-notempty="true" data-bv-notempty-message="确认密码不能为空"
							data-bv-stringlength="true" data-bv-stringlength-max="15"
							data-bv-stringlength-min="6"
							data-bv-stringlength-message="请输入6-15个字符"
							data-bv-identical="true" data-bv-identical-field="password"
							data-bv-identical-message="确认密码必须和密码一致" />
					</div>
				</div>
				<div class="panel-footer">
					<div class="row">
						<div class="text-c">
							<a id="cancelBtnsss" class="btn btn-default"
								>关闭</a>
							<input type="submit" class="btn btn-primary" value="确定" />
						</div>
					</div>
				</div>
			</form>
		</div>

	</div>
</div>

<script type="text/javascript">
	$("#back").attr("href",locationHref + "platform/sysManage/userManage/userQuery");
	$("#cancelBtnsss").attr("href",locationHref + "platform/sysManage/userManage/userQuery");
	$(function() {
		
		$("#id").val(passoptions.id);
		
		$('#addUserForm124').bootstrapValidator({
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'gyphicon glyphicon-refresh'
			}});
		//form 表单提交用插件jQuery.form.js模拟iframe 开始
		var options = {
			success : function(data) {
				
				if (data.code == 0) {
					alert("添加成功");
					window.location.href =locationHref +  'platform/sysManage/userManage/userQuery';
				} else {
					alert(data.msg);
					if(data.code==1&&data.value==true){
						window.location.href="logout.do";
					}
				}

			},
			beforeSubmit : function(a, form, options) {
				return true;
			}
		};
		$("#addUserForm124").ajaxForm(options).submit(function() {
			return false;
		});
	});
</script>