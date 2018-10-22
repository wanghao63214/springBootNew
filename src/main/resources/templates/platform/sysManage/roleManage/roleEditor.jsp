<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	String tmpUrl =(String)request.getParameter("loginName");
	String roleQueryUrl = "view/index.jsp?loginName="+tmpUrl+"#platform/sysManage/roleManage/roleQuery";
%>
<!--用户行为策略-->
<div class="pageheader">
		<h2><i class="fa fa-home"></i>首页&gt;系统管理&gt;角色管理<span></span></h2>
</div>
<div class="contentpanel containermain">
	<div class="panel panel-default">
		<form id="addAppForm" class="form-horizontal -form-bordered " 
		onkeydown="if(event.keyCode==13){return false;}" action="app/add.do" method="post"  >
			<div class="panel-heading">
				<div class="panel-btns">
					<a href=<%=roleQueryUrl %> class="panel-close">×</a>
				</div>
				<h6 class="panel-title">角色授权</h6>
			</div>
			<div class="panel-body panel-body-nopadding cl">
				<div class="form-group" style="margin-top: 10px;margin-bottom: 10px;">
					<label class="col-xs-5 control-label">
							权限字段：<span class="asterisk">*</span>
					</label>
					<div class="col-xs-3">
							<input name="appId" value=""  type="hidden">
							<ul id="roleTree" class="ztree" style="width:260px; overflow:auto;display: none;"></ul>
							<div id="roleTreestatus" style="margin-top: 0px;"><i class="fa fa-spinner fa-spin"></i></div>
					</div>
				</div>			
			</div>
			<div class="panel-footer">
			 <div class="row">
				<div class="text-c">
					<a id="cancelBtn" class="btn btn-default" href=<%=roleQueryUrl%> >取&nbsp;&nbsp;消</a>&nbsp;&nbsp;
					<button id="confirmBtn" type="button" onclick="sumt()" class="btn btn-primary">确&nbsp;&nbsp;定</button>
				</div>
			 </div>
			</div>
			</form>
		</div>
</div>
<script type="text/javascript">

var roleQueryUrl = locationHref + 'platform/sysManage/roleManage/roleQuery';
var updateRolePermissionsDo = "role/updateRolePermissions.do";
var showCheckedTreeDo = 'role/showCheckedTree.do';
var setting = {
		async: {
			enable: true,
			url:showCheckedTreeDo,
			otherParam:{"roleId":roleId},
			dataFilter: filter
		},
		check: {
			enable: true,
			autoCheckTrigger: true
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onCheck: onCheck,
			onAsyncSuccess: onAsyncSuccess
		}
	};
var zNodes =[
  			{ id:1, pId:0, name:"半勾选 1", halfCheck:true, isParent:true},
  			{ id:2, pId:0, name:"半勾选 2", halfCheck:true, checked:true, isParent:true},
  			{ id:3, pId:0, name:"随意勾选 3", checked:true, isParent:true}
  		];
$(function() {
	$.fn.zTree.init($("#roleTree"), setting);
})
function onAsyncSuccess(event, treeId, treeNode, msg) {
	$('#roleTreestatus').hide();
	$('#roleTree').show();
	cancelHalf(treeNode);
}
function cancelHalf(treeNode) {
	if(treeNode==null) return;
	if (treeNode.checkedEx) return;
	var zTree = $.fn.zTree.getZTreeObj("roleTree");
	treeNode.halfCheck = false;
	zTree.updateNode(treeNode);			
}
function onCheck(event, treeId, treeNode) {
	cancelHalf(treeNode)
	treeNode.checkedEx = true;
}
function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	for (var i=0, l=childNodes.length; i<l; i++) {
		childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
	}
	return childNodes;
}
	function sumt(){
		var zTree = $.fn.zTree.getZTreeObj("roleTree");
		var checkNodes = zTree.getCheckedNodes(true);
		var checkId='';
		 for(var i=0;i<checkNodes.length;i++){
			 checkId=checkId+","+checkNodes[i].id; //获取选中节点的值
          }
		 checkId=checkId.substring(1);
		 _window._showShade();
		 $.ajax({
	      		type: "POST",
	  		    url: updateRolePermissionsDo,
	  		    data: {roleId:roleId,permissionsIds:checkId},
	  		    success: function(msg){
	  		    	_window._closeShade();
	  		    	if(msg.code==1){
	  		    		_window._confirm('角色赋权成功!',function(){
	  		    			window.location.href= roleQueryUrl;
			    		},true)
	  		    	}else{
	  		    		
	  		    	}
	  		    }
	      	});
	}
</script>