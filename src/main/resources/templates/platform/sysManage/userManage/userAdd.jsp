<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String tmpUrl =(String)request.getParameter("loginName");
	String userQueryUrl ="view/index.jsp?loginName="+tmpUrl+"#platform/sysManage/userManage/userQuery";
 %>
<div class="pageheader">
	<h2>
		<i class="fa fa-edit"></i>用户管理
	</h2>
</div>
<div class="contentpanel container-fluid">
	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="panel-btns">
				<a href=<%=userQueryUrl %>
					class="panel-close">×</a>
			</div>
			<div class="panel-btns" id="qwe">
			<h4 class="panel-title" id="panelTitleId1">新增用户</h4>
			</div>
			<div class="panel-btns" id="asd">
			<h4 class="panel-title" id="editTitleId1">编辑用户</h4>
			</div>
		</div>
		<div class="panel-body panel-body-nopadding ">
			<form id="addUserForm123" action='user/add.do' method="post" onkeydown="if(event.keyCode==13){return false;}"
				class="form-horizontal -form-bordered " autocomplete="off" 
				target="_self">
				<div class="form-group" style="display: none;">
					<label class="col-xs-2 control-label">用户ID：</label>
					<div class="col-xs-4">
						<input type="hidden" id="id" name="userId" placeholder="用户ID"
							class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label">用户名： <span class="asterisk">*</span></label>
					<div class="col-xs-4">
				<!-- 	<input type="text" id="" name="userName" placeholder="用户名" style="display:block" 
					required data-bv-notempty="true"> -->
<!-- 					<input type="password" id="" name="password" placeholder="密码" style="display:none"> -->
					
						<input type="text" id="userName" name="userName" placeholder="用户名"
							class="form-control" required data-bv-notempty="true"
							data-bv-notempty-message="用户名不能为空" data-bv-stringlength="true"
							data-bv-stringlength-max="15" data-bv-stringlength-min="1"
							data-bv-stringlength-message="请输入1-15个字符">
					</div>
				</div>
				<!-- 防止自动填写用户名密码 -->
				<input type="text" style="display:none">
				<div class="form-group" id="passwordDiv">
					<label class="col-xs-2 control-label">密码： <span class="asterisk">*</span></label>
					<div class="col-xs-4">
						<input type="password" id="password" name="password"
							placeholder="密码" class="form-control" required
							data-bv-stringlength="true" data-bv-stringlength-max="15"
							data-bv-stringlength-min="6" data-bv-notempty-message="密码不能为空"
							data-bv-stringlength-message="请输入6-15个字符"
							data-bv-different="true" data-bv-different-field="userName"
							data-bv-different-message="密码不能和用户名相同">
					</div>
				</div>
				<div class="form-group" id="confirmPwdDiv">
					<label class="col-xs-2 control-label">确认密码： <span class="asterisk">*</span></label>
					<div class="col-xs-4">
						<input type="password" id="confirmPwd" name="confirmPwd"
							placeholder="确认密码" class="form-control" required
							data-bv-notempty="true" data-bv-notempty-message="确认密码不能为空"
							data-bv-stringlength="true" data-bv-stringlength-max="15"
							data-bv-stringlength-min="6"
							data-bv-stringlength-message="请输入6-15个字符"
							data-bv-identical="true" data-bv-identical-field="password"
							data-bv-identical-message="确认密码必须和密码一致" data-bv-different="true"
							data-bv-different-field="userName"
							data-bv-different-message="密码不能和用户名相同">
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label">用户昵称： <span class="asterisk">*</span></label>
					<div class="col-xs-4">
						<input type="text" id="anotherName" name="anotherName"
							placeholder="用户昵称" class="form-control" 
							>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label">盐值： <span class="asterisk">*</span></label>
					<div class="col-xs-4">
						<input type="text" id="salt" name="salt" placeholder="盐值"  required
							class="form-control" required data-bv-notempty="true"
							data-bv-notempty-message="盐值不能为空">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-2 control-label">角色名称： <span class="asterisk">*</span></label>
					<div class="col-xs-4">
						<select style="width: 100%;" class="select2"  id="roleId" name="roleId" required placeholder="请选择角色" required data-bv-notempty="true"
							data-bv-notempty-message="角色名称不能为空"></select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label">手机号：</label>
					<div class="col-xs-4">
						<input type="text" id="mobile" name="mobile" placeholder="手机号" 
							data-bv-stringlength="true"
							data-bv-stringlength-max="11"
							class="form-control"  data-bv-regexp="true"
							data-bv-regexp-regexp="(13[0-9]|15[012356789]|17[5678]|18[0-9]|14[57])[0-9]{8}"
							data-bv-regexp-message="手机号不合法(暂时不支持港澳台号码)">
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label">邮箱：</label>
					<div class="col-xs-4">
						<input type="text" id="email" name="email" placeholder="邮箱" 
							class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label">用户状态： <span
						class="asterisk">*</span></label>
					<div class="col-xs-4">
						<select style="width: 100%;" id="isDisable" name="isDisable" required>
							<option value="1" selected="selected">正常</option>
							<option value="2">禁用</option>
						</select>
					</div>
				</div>
					
				<div class="form-group" style="display: none;">
					<label class="col-xs-2 control-label">登录次数：</label>
					<div class="col-xs-4">
						 <input type="hidden" name="loginCount">
					</div>
				</div>
			<!-- 	<div class="form-group" style="display: none;" id="createDateDiv">
					<label class="col-xs-2 control-label">创建时间： <span
						class="asterisk">*</span></label>
					<div class="col-xs-4">
						<input type="hidden" name="createDate" id="createDate" class="form-control"  readonly="readonly"/>
					</div>
				</div> -->
				<div class="form-group" style="display: none;" id="lastLoginDiv">
					<label class="col-xs-2 control-label">登录时间： <span
						class="asterisk">*</span></label>
					<div class="col-xs-4">
						<input type="hidden" name="lastLogin" id="lastLogin" class="form-control"  readonly="readonly"/>
					</div>
				</div>
				<div class="form-group" style="display: none;" id="updateDateDiv">
					<label class="col-xs-2 control-label">修改时间： <span
						class="asterisk">*</span></label>
					<div class="col-xs-4">
						<input type="hidden" name="updateDate" id="updateDate" class="form-control" readonly="readonly"/>
					</div>
				</div>
				<div class="panel-footer">
					<div class="row">
						<div class="text-c">
							<a id="cancelBtnsss" class="btn btn-default"
								href=<%=userQueryUrl %>>关闭</a>
							<input type="submit" class="btn btn-primary" value="确定" />
						</div>
					</div>
				</div>
			</form>
		</div>

	</div>
</div>

<script type="text/javascript">

	var userQueryUrl =locationHref +  'platform/sysManage/userManage/userQuery';
	var validatorUserNameDo = 'user/validatorUserName.do';
	var updateDo = 'user/update.do';
	
	$(function() {
		$('#isDisable').select2();
		//查询所有的角色
		$('#addUserForm123').bootstrapValidator({
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'gyphicon glyphicon-refresh'
				},
				fields : {
					anotherName :{
						validators: {
								notEmpty: {
	                        	message: '昵称必填！'
	                   			},
							 stringLength: {/*长度提示*/
	                            min: 1,
	                            max: 50,
	                            message: '长度必须在1到50之间'
	                        }
                        }
					},email:{
						validators: {
							 stringLength: {/*长度提示*/
	                            min: 1,
	                            max: 50,
	                            message: '长度必须在1到50之间'
	                         },
	                         regexp: {
	                         	regexp: /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/,
	                         	message: "邮箱格式错误"
	                         }       
                        }
					
					},userName : {
						trigger : 'blur',
						validators : {
							callback : {
								message : '用户名已被使用',
								callback : function(value, validator) {
									var flag = true;
									if (value != ""&&$("#id").val()=="") {
										$.ajax({
											url : validatorUserNameDo ,
											data : {
												'username' : value
											},
											cache : false,
											async : false,
											type : 'POST',
											dataType : 'json',
											success : function(data) {
												if (data == 0) {
													flag = true;
												} else {
													flag = false;
												}
											}
										});
									}
									return flag;
								}
							}
						},
						 stringLength: {/*长度提示*/
                            min: 1,
                            max: 15,
                            message: '长度必须在1到15之间'
                        }
					}
				}
			});
		if (passoptions != undefined && passoptions != null
				&& passoptions != '') {
				//alert("1");
			//编辑
			$("#qwe").hide();
			$("#asd").show();
			$('#passwordDiv').css('display','none');
			$('#confirmPwdDiv').css('display','none');
			$('#password').attr('disable','disable');
			$('#confirmPwd').attr('disable','disable');
			$("#userName").attr('readonly','true');
			$("#userName").val(passoptions.userName);
			$('#anotherName').val(passoptions.anotherName);
			$("#salt").attr('readonly','true');
			$("#salt").val(passoptions.salt);
			select2Ajax({"selectId": 'roleId', "url": 'role/queryAllRoles.do',"value":passoptions.roleId});
			$('#mobile').val(passoptions.mobile);
			$('#email').val(passoptions.email);
			$('#id').val(passoptions.id);
			$('#isDisable').val(passoptions.userStatus);
			$('#isDisable').select2('val',passoptions.userStatus);
			$('#createDateDiv').css('display','block');
			$('#lastLoginDiv').css('display','block');
			$('#updateDateDiv').css('display','block');

			//$('#createDate').attr('type','text');
			$('#lastLogin').attr('type','text');
			$('#updateDate').attr('type','text');
			
			//$('#createDate').val(passoptions.createDate);
			$('#lastLogin').val(passoptions.lastLogin);
			$('#updateDate').val(passoptions.createTime);
			
			$('#addUserForm123').attr('action', updateDo);
			
			
			$('#addUserForm123').bootstrapValidator({
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'gyphicon glyphicon-refresh'
				}
			});
			
		} else {//添加
			select2Ajax({"selectId": 'roleId', "url": 'role/queryAllRoles.do'});
			$("#qwe").show();
			$("#asd").hide();
		}
		
		//form 表单提交用插件jQuery.form.js模拟iframe 开始
		var options = {
			success : function(data) {
				if (data.code == 0) {
					alert("添加成功");
					window.location.href = userQueryUrl;
				} else {
					alert(data.msg);
				}

			},
			beforeSubmit : function(a, form, options) {
				return true;
			}
		};
		$("#addUserForm123").ajaxForm(options).submit(function() {
			return false;
		});
	});
</script>