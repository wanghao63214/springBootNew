var _mainpanelHeight='';
//左侧menu入口
$(function() {
	_mainpanelHeight=$('.mainpanel').height();
	if (location.hash != '') {// 页面刷新调转到主页
		window.location.href = window.location.href.split('#')[0] ;
		return;
	}
	//获取左侧树
	jQuery.getJSON("showMeuns" ,function(data){
			$("#nav-ul").append(menuTree(bTree(data)));
	});
	var contentBox = $("#content-box");
	//not neccessary
	$("#nav-ul>li").on("click", function() {
		$("#nav-ul").find("li").removeClass("active");
		$(this).addClass("active");
	});

	// 修改数据按下s
	$(document).on("click", ".fix-item", function() {
		options = {};
		options.id = $(this).parent().attr("data-id");
	});
	//监听到锚点修改
	$(window).hashchange(function() {
		if (location.hash == '') {
			return;
		}
		$(".mainpanel").removeAttr("style");//格式化
		$(".mainpanel").css('min-height',_mainpanelHeight+"px");
		var hash = location.hash.replace("#", "");
		//keypart
		$(contentBox).load(hash);
	});

	$('#confirmalert').on('hidden.bs.modal', function(e) {
		callbackobj();
	})
	// 实现多层弹出层效果开始
	$(document).on('show.bs.modal', '.modal', function(event) {
		$(this).appendTo($('body'));
	}).on('shown.bs.modal', '.modal.in', function(event) {
		setModalsAndBackdropsOrder();
	}).on('hidden.bs.modal', '.modal', function(event) {
		setModalsAndBackdropsOrder();
		if ($('.modal.in').length == 0) {
			$('body').removeClass('modal-open');
		}
	});
	function setModalsAndBackdropsOrder() {
		$('body').addClass('modal-open');
		var modalZIndex = $('.modal.in').length + 1050 + 1;
		var backdropZIndex = modalZIndex - 1;
		$('.modal-backdrop').addClass('hidden');
		$('#themasklayer .modal-backdrop').removeClass('hidden');
		$('.modal.in:last').css('z-index', modalZIndex);
		$('.modal-backdrop.in:last').css('z-index', backdropZIndex)
				.removeClass('hidden');
	}
	// 实现多层弹出层效果结束

	// 开始弹出应用列表
	$('#appTableModalFade').on('show.bs.modal', function(event) {
		appTableModalFade();
		var button = $(event.relatedTarget);
		var recipient = button.data('whatever');
		var appid = button.data('appid');
		var appname = button.data('appname');
		$('#addappId').val(appid);
		$('#addappIdName').val(appname);
		var modal = $(this);
		modal.find('.modal-title').text(recipient);
	});
	// 结束弹出应用列表
	// 开始弹出通道列表
	$('#channelTableModalFade').on('show.bs.modal', function(event) {
		channelTableModalFade();
		var button = $(event.relatedTarget)
		var recipient = button.data('whatever')
		var channelid = button.data('channelid')
		var channelname = button.data('channelname')
		$('#addchannelId').val(channelid)
		$('#addchannelIdName').val(channelname)
		var modal = $(this);
		modal.find('.modal-title').text(recipient);
	})
	// 结束弹出通道列表
	// 开始弹出CP列表
	$('#cpTableModalFade').on('show.bs.modal', function(event) {
		cpTableModalFade();
		var button = $(event.relatedTarget)
		var recipient = button.data('whatever')
		var cpid = button.data('cpid')
		var cpname = button.data('cpname')
		$('#addcpId').val(cpid)
		$('#addcpIdName').val(cpname)
		var modal = $(this);
		modal.find('.modal-title').text(recipient);
	})
	// 结束弹出CP列表
	//开始弹出添加
	$('#cpTableModalFade1').on('show.bs.modal', function(event) {
		cpTableModalFade1();
		var button = $(event.relatedTarget);
		var recipient = button.data('whatever');
		var cpid = button.data('cpid');
		var cpname = button.data('cpname');
		$('#addcpId1').val(cpid);
		$('#addcpIdName1').val(cpname);
		var modal = $(this);
		modal.find('.modal-title').text(recipient);
	});
})

	function bTree(data) {//data为List<Map<String, Object>>类型
		var map = {};//最终要返回的类型是对象
		var root;//集合中第一个parentId
		for (var i =0 ; i <data.length; i++) {//遍历所有当前角色的模块和菜单

			if (i == 0) {
				root = data[i].pId;//集合中第一个parentId
			}
			if (map[data[i].pId] == null) {//对象属性没有值
				map[data[i].pId] = new Array();//map对象用parentId作为健，值为新建的数组
			}
			map[data[i].pId].push(data[i]);//map[data[i].pId]是数组，data[i]是一个map，也就是数据库的一条数据，添加n条数据
		}
		//此循环的目的是新建一个对象，将数据库中所有数据的parentId作为健，值为数据库中所有以这个健为父级的子级
		//结构为:
		//对象{tree:array[map1{child},map2],
		//	  pid:array[map3,map4] }
		var idx = 0;
		for (key in map) {//循环这个对象
			if (idx == 0){
				map["tree"] = {};//map对象中又新建一个健为tree
			}
			var id;
			for (var i = map[key].length -1; i>= 0; i --){//循环map对象中的数组
				id = map[key][i].id;

				if (map[id] != null) {//发现数据库的一条数据是父级
					map[key][i]["child"] = map[id];//数据map中新建一个属性child
				}
			}
		}

		map["tree"] = map[root];
		return map["tree"];
	}

function menuTree(data){
	var menuTreeObj="";
	var href="";
	for(var i =0 ; i <data.length; i++){
		if(data[i]["child"] != undefined && data[i]["child"].length>0){
			menuTreeObj+='<li class="nav-parent"><a href="javascript:void(0);"  rel="#"><i class="fa fa-file-text"></i> <span>'+data[i].text+'</span></a>';
			menuTreeObj+='<ul class="children">';
			menuTreeObj+=menuTree(data[i]["child"]);
			menuTreeObj+='</ul></li>';
		}else{
			var urlkey=window.location.href+"#"+data[i].url;//window.location.href为当前页面url
			if(data[i].url==null||data[i].url==''){
				urlkey="";
			}
			menuTreeObj+='<li><a href="'+urlkey+'" ><i class="fa fa-caret-right"></i> <span>'+data[i].text+'</span></a></li>';
		}
	}
	return menuTreeObj;
}
