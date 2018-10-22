/**
 * 公共窗体对象
 */
var _window = {
    /**
     * 操作确认弹窗
     * @param message 提示内容
     * @param callback 回调方法
     * @param hideclasse 取消按钮是否隐藏，传递任何值表示隐藏
     */
    _confirm: function(message, callback,hideclasse){
        var classArray="btn-error";
        if(hideclasse!=undefined){
            classArray="btn-error hidden";
        }
        $.messager.model = {
            ok:{ text: "确认", classed: 'btn-primary' },
            cancel: { text: "取消", classed: classArray }
        };
        $.messager.confirm("提示", message, callback);
    },

    /**
     * 弹窗显示
     * @param title 标题
     * @param content 内容
     */
    _alert: function(title, content){
        $.messager.alert(title, content);
    },

    /**
     * 打开公共弹窗
     * @param title 标题
     * @param url 加载页面的地址
     * @param callback 关闭弹出处理事件
     */
    _showPopup: function(title, url, callback, pass){
        var model = "pop_modal";
        var modelTitle = "pop_title";
        var modelHtml = "pop_body";
        $("#pop_modal_div").removeClass();
        if(pass=='sm'){//小
            $("#pop_modal_div").addClass("modal-dialog modal-sm");
        }else if(pass=='md'){//中
            $("#pop_modal_div").addClass("modal-dialog modal-md");
        }else if(pass=='lg'){//大
            $("#pop_modal_div").addClass("modal-dialog modal-lg");
        }else{
            $("#pop_modal_div").addClass("modal-dialog modal-md");
        }
        // 清除标题
        $("#"+modelTitle).empty();
        // 写入标题
        $("#"+modelTitle).html(title);
        // 将url中的页面加载到弹窗
        $("#"+modelHtml).html('').load(url);
        // 显示弹窗
        $("#"+model).modal({
            show:true
        });

        // 清除关闭监听事件
        $("#"+model).unbind('hidden.bs.modal');
        // 定义关闭模态窗口关闭事件
        if(callback != undefined){
            $("#"+model).on('hidden.bs.modal', function (e) {
                callback();
            })
        }

    },

    /**
     * 关闭公共弹窗
     */
    _colsePopup: function(){
        var model = "pop_modal";
        $("#"+model).modal('hide');
    },

    /**
     * 取得模态弹窗的高度
     * @returns
     */
    _popupHeight: function(){
        return $('#shell_payment_popup_modal .modal-content').height();
    },

    /**
     * 启用遮罩
     */
    _showShade: function(){
        $('#themasklayer').show('normal',function(){
            $(this).children().css('z-index',2040)
            //style="z-index: 1051;"
        });
    },

    /**
     * 关闭遮罩
     */
    _closeShade: function(){
        $('#themasklayer').hide('normal',function(){
            $(this).children().css('z-index',0)
        });
    }
}