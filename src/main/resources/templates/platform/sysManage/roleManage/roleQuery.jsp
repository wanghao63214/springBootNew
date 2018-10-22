<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<div class="pageheader" >
	<h2 style="color: white;">
		角色管理
	</h2>
</div>
<div class="contentpanel containermain">
<div class="tab-content" >
<div >
	<form class="form-inline" onsubmit="javascript:$rTable.bootstrapTable('refresh', {url: 'role/query.do'});return false;" 
	action="#" onkeydown="if(event.keyCode==13){return false;}">
	 <shiro:hasPermission name="role:add">
	 <div class="form-group" style="float:left;padding-top:10px;margin-right:10px;">
					<a id="roleAddItem" class="btn btn-primary btn-sm" href="javascript:void(0);" onclick="addShowRole(); " style="width: 95px;">新增角色</a>
	        </div>
	</shiro:hasPermission>
	<div style="float:right;margin-right: 20px;margin-top: 10px;margin-bottom: 10px;">
		 	  <div class="w-105" style="float: right;margin-left: 0px;">
			      <button type="button" class="btn btn-primary btn-sm" onclick="queryTable()">查询</button>
	          </div>
	          <div class="w-200" style="margin-right: 5px;float: right;">
		          <input type="search" name="rName" id="rName" style="width:200px;height: 35px;padding: 3px;" class="form-control"  placeholder="角色名称(模糊查询)">
		      </div>
	</div>
	  </form>
	 </div>
</div>
    <table id="rTable"></table>
</div>
<script type="text/javascript">
	var roleEditorUrl = locationHref + 'platform/sysManage/roleManage/roleEditor';
	var roleAddUrl = 'view/platform/sysManage/roleManage/roleAdd.jsp';
	var queryDo = 'role/query.do';
    var $rTable = $('#rTable'), selections = [];
    window.operateEvents = {
        'click .modify': function (e, value, row, index) {
            	roleId=row;
            	_window._showPopup('修改角色',roleAddUrl,function(){
            		pageNum = 1;
            		$rTable.bootstrapTable('refresh', {url: 'role/query.do'});
            	});
            	
            },
            'click .accredit': function (e, value, row, index) {
            	roleId=row.id;
            	window.location.href=roleEditorUrl;
            }
        };
   var pageNum=1;
   var pageSize = 10;
    $(function () {
        $rTable.bootstrapTable({
            columns: [
                     {
                        field: 'id',
                        title: '序号',
                        sortable: false,
                        visible : true,
                        align: 'center',
                        formatter: function(value, row, index) {
	                     		return ((pageNum - 1) * pageSize + index + 1);
	                     }
                    },  {
                        field: 'name',
                        title: '角色名称',
                        sortable: false,
                        align: 'center',
                    }, {
                        field: 'updateTime',
                        title: '上次修改时间',
                        sortable: false,
                        visible:true,
                        align: 'center',
                    },{
                        field: 'operate',
                        title: '操作',
                        align: 'center',
                        events: operateEvents,
                        formatter: operateFormatter
                    }
                ],
                toolbar:'#formDiv',
                search:false,
                showToggle:false,
                minimumCountColumns:2,
                queryParams:function(params){
                	params.roleName=$("#rName").val();
                	return params;
                },
                showPaginationSwitch:false,
                pagination:true,
                idField:'id',
                pageList:'[10]',
                showFooter:false,
                height : getToauditHeight(),
                onClickRow:linesSelected,
                detailFormatter:'detailFormatter',
                rowStyle:function(value, row, index){
                	return {classes :"divnowrap"};
                },
                contentType:"application/x-www-form-urlencoded",
                sidePagination:'server',
                url:queryDo,
                showExport:false
        });
        	     /**
         *表格分页设置
         **/
         $rTable.on('page-change.bs.table', function(number, size) {
            pageNum = size; //获取当前页面
        });
        
    });
    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }

    function operateFormatter(value, row, index) {
   	 return [
   	        	'<shiro:hasPermission name="role:update">',
   	            '<a class="accredit" href="javascript:void(0)" title="赋权">赋权',
   	            '</a>&nbsp;&nbsp;|&nbsp;&nbsp;',
   	         	'<a class="modify" href="javascript:void(0)" title="修改">修改',
	            '</a>',
   	        	'</shiro:hasPermission>'
   	  ].join('');
   }

    function totalTextFormatter(data) {
        return 'Total';
    }

    function totalNameFormatter(data) {
        return data.length;
    }

    function totalPriceFormatter(data) {
        var total = 0;
        $.each(data, function (i, row) {
            total += +(row.price.substring(1));
        });
        return '$' + total;
    }

    function getHeight() {
        return $(window).height()*1.018;
    }
    function addShowRole(){
    	_window._showPopup('新增角色',roleAddUrl,function(){
    		pageNum=1;
    		$rTable.bootstrapTable('refresh', {url: queryDo});
    	});
    }
    function queryTable(){
		pageNum=1;
		$rTable.bootstrapTable('refresh', {url: 'role/query.do'});
	}
</script>
