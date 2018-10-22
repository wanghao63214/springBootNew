function simulationOnclik(url,dialogTitle,iseditor){
	window.parent.mainmodeurl=url;
	if(iseditor==undefined){
		iseditor=true
	}
	dialogTitle=dialogTitle+"|||||"+iseditor;
	$('#popupbuuton_',window.parent.document).attr('data-whatever',dialogTitle);
	$('#popupbuuton_',window.parent.document).click();
}