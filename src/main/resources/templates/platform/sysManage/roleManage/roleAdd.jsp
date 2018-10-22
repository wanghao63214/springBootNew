<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="container-fluid" style="margin-top: 20px;">
<form class="form-horizontal" id="roleForm" action="role/add.do" method="post" onkeydown="if(event.keyCode==13){return false;}">
  <div class="form-group">
    <label for="inputPassword3" class="col-xs-offset-2 col-sm-2 control-label">角色名称：</label>
    <div class="col-xs-4">
       <input type="hidden" name="roleId"  id="roleId_1" value="">
      <input type="text" name="roleName"  id="roleName_1" class="form-control"  placeholder="角色名称"
      data-bv-stringlength="true"data-bv-stringlength-max="25" data-bv-stringlength-min="1"
	data-bv-stringlength-message="请输入1-25个字符">
    </div>
  </div>
  <div class="form-group" style="margin-top: 70px;">
    <div class="col-xs-offset-2 col-sm-7">
      <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <button type="submit" id="subBtn" class="btn btn-primary">保存</button>
    </div>
  </div>
</form>
</div>
<script type="text/javascript">
	$('#roleId_1').val(roleId.id);
	$('#roleName_1').val(roleId.name);
	roleId="";


	
	$(function() {
		/**
		 * 添加对象
		 */
		AddRoleBaseInfo = {
			_from : $("#roleForm"),
			_enableSubmit : function() { // 启用按钮
				$("#subBtn").attr('disabled', false);
			},
			_disabledSubmit : function() { // 禁用按钮
				$("#subBtn").attr('disabled', true);
			},
			_validator: function() {
				AddRoleBaseInfo._from.bootstrapValidator({
			        feedbackIcons: {
			            valid: 'glyphicon glyphicon-ok',
			            invalid: 'glyphicon glyphicon-remove',
			            validating: 'glyphicon glyphicon-refresh'
			        },
			        excluded: [':disabled'],
			         fields: {
			         	 'roleName': {
			            	trigger : 'blur',
			                validators: {
			                	  notEmpty: {
			                        message: '角色名称必填！'
			                    },
			                     callback : {
										message : '角色名称已被使用',
										callback : function(value, validator) {
											var flag = true;
											if (value != '') {
												$.ajax({
													url : 'role/validatorRoleName.do',
													data : {
														roleName :value,
														id:$("#roleId_1").val()
													},
													cache : false,
													async : false,
													type : 'POST',
													dataType : 'json',
													success : function(data) {
													flag=data.code==1?true:false;
													}
												});
											}
											return flag;
										}
									}
			                }
			            }
			         }
	      });
	   },
	   _submit : function() {
					if($('#roleId_1').val()){
							$("#roleForm").attr('action','role/update.do');
					}
					var options = {
						success : function(data) {
							if (data.code == 1) {
								_window._alert("提示", data.msg);
								_window._colsePopup();
							} else {
								_window._alert("提示", data.msg);
							}
						// 关闭遮罩
						_window._closeShade();
					},
					beforeSubmit : function(a, form, options) {
						// 启用遮罩
						_window._showShade();
						return true;
					}
				};
					AddRoleBaseInfo._from.ajaxForm(options).submit(function() {
							return false;
					});
		   }
		   
	 };
	 // 校验
		AddRoleBaseInfo._validator();
		// 提交
		AddRoleBaseInfo._submit();
});
	
	

</script>