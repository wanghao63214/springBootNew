<!-- 弹窗 -->
<div class="modal" id="appTableModalFade" tabindex="-1" role="dialog"
	aria-labelledby="appTableModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="appTableModalLabel"></h4>
			</div>
			<div class="modal-body">
				<div id="appTablelistSearch">
					<form class="form-inline">
						<div class="form-group">
							<%--<label for="pendingCpName" class="col-xs-4 control-label">应用名称：</label>--%>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="appName"
									placeholder="模糊查询">
							</div>
						</div>
						<div class="form-group">
							<%--<label for="pendingCpName" class="col-xs-4 control-label">公司名称：</label>--%>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="cpName"
									placeholder="模糊查询">
							</div>
						</div>
						<button type="button" class="btn btn-primary btn-sm"
							onclick="refreshAppTable();">查询</button>
					</form>
				</div>
				<table id="appTablebody"></table>
			</div>
			<div class="modal-footer">
				<input type="hidden" id="addappId"> <input type="hidden"
					id="addappIdName">
			</div>
		</div>
	</div>
</div>
<div class="modal" id="channelTableModalFade" tabindex="-1"
	role="dialog" aria-labelledby="channelTableModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="channelTableModalLabel"></h4>
			</div>
			<div class="modal-body">
				<div id="channelTablelistSearch">
					<form class="form-inline">
						<div class="form-group">
							<label for="channelNameSearch" class="col-xs-4 control-label">通道名称：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="channelNameSearch"
									placeholder="模糊查询">
							</div>
						</div>
						<button type="button" class="btn btn-primary btn-sm"
							onclick="channelTableModalFade();">查询</button>
					</form>
				</div>
				<table id="channelTablebody"></table>
			</div>
			<div class="modal-footer">
				<input type="hidden" id="addchannelId"> <input type="hidden"
					id="addchannelIdName">
			</div>
		</div>
	</div>
</div>
<div class="modal" id="cpTableModalFade" tabindex="-1" role="dialog"
	aria-labelledby="cpTableModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="cpTableModalLabel"></h4>
			</div>
			<div class="modal-body">
				<div id="cpTablelistSearch">
					<form class="form-inline">
						<div class="form-group">
							<label for="cpNameSearch" class="col-xs-4 control-label">公司名称：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="cpNameSearch"
									placeholder="模糊查询">
							</div>
						</div>
						<button type="button" class="btn btn-primary btn-sm"
							onclick="refreshTable();">查询</button>
					</form>
				</div>
				<table id="cpTablebody"></table>
			</div>
			<div class="modal-footer">
				<input type="hidden" id="addcpId"> <input type="hidden"
					id="addcpIdName">
			</div>
		</div>
	</div>
</div>
<div class="modal" id="cpTableModalFade1" tabindex="-1" role="dialog"
	aria-labelledby="cpTableModalLabel1">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="cpTableModalLabel1"></h4>
			</div>
			<div class="modal-body">
				<div id="cpTablelistSearch1">
					<form class="form-inline">
						<div class="form-group">
							<label for="cpNameSearch1" class="col-xs-4 control-label">CP名称：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="cpNameSearch1"
									placeholder="模糊查询">
							</div>
						</div>
						<button type="button" class="btn btn-primary btn-sm"
							onclick="cpTableModalFade1();">查询</button>
					</form>
				</div>
				<table id="cpTablebody1"></table>
			</div>
			<div class="modal-footer">
				<input type="hidden" id="addcpId1"> <input type="hidden"
					id="addcpIdName1">
			</div>
		</div>
	</div>
</div>
<!-- 公共弹窗--新建角色 -->
<div class="modal fade" id="pop_modal" tabindex="-1" aria-labelledby="shell_payment_popup_modal" data-backdrop="static">
	<div id="pop_modal_div" class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h5 class="modal-title" id="pop_title"></h5>
			</div>
			<div class="modal-body" id="pop_body" style="overflow-x:auto; "></div>
		</div>
	</div>
</div>