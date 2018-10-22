Tool = (function(window, $) {
    /*
     * Date对象上加format方法
     */
    Date.prototype.format = function(format) {
        var date = {
            "M+": this.getMonth() + 1,
            "d+": this.getDate(),
            "h+": this.getHours(),
            "m+": this.getMinutes(),
            "s+": this.getSeconds(),
            "q+": Math.floor((this.getMonth() + 3) / 3),
            "S+": this.getMilliseconds()
        };
        if (/(y+)/i.test(format)) {
            format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
        }
        for (var k in date) {
            if (new RegExp("(" + k + ")").test(format)) {
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
            }
        }
        return format;
    }
    return {
        /**
         * 将时间戳转换成相应格式
         * 
         * @time 时间戳
         * @fmt 要转换的格式
         */
        getDate: function (AddDayCount) {
            var dd = new Date();
            dd.setDate(dd.getDate() + AddDayCount); //获取AddDayCount天后的日期
            var y = dd.getFullYear();
            var m = dd.getMonth() + 1; //获取当前月份的日期
            var d = dd.getDate();
            if(m<10){m="0"+m};
             if(d<10){d="0"+d}
            return y + "-" + m + "-" + d;
        },
        formatTime: function(time, fmt) {
                if (time) {
                    if (10 == time.toString().length) {
                        time = time + "000";
                    }
                    fmt = fmt ? fmt : 'yyyy-MM-dd hh:mm:ss';
                    return new Date(parseInt(time)).format(fmt);
                } else {
                    return "";
                }
            }
            /**
             * 将json赋值给表单元素，根据key和表单name对应的方式
             * 
             * @jsonValue 要赋值的json数据
             */
            ,
        getFormJson: function(id) {
            var o = {};
            var a = $(id).serializeArray();
            $.each(a, function() {
                if (o[this.name]) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            $.each(o, function(key, val) {
                if ($.isArray(val)) {
                    o[key] = val.join(",");
                }
            });
            return o;
        },
        /**
         * 将json赋值给表单元素，根据key和表单name对应的方式
         * 
         * @jsonValue 要赋值的json数据
         */
        setFormJson: function(id, jsonValue) {
            var obj = $(id);
            $.each(jsonValue, function(name, ival) {
                var $oinput = obj.find("input[name='" + name + "']");
                if ($oinput.attr("type") == "radio" || $oinput.attr("type") == "checkbox") {
                    $oinput.each(function() {
                        if (Object.prototype.toString.apply(ival) == '[object Array]') { // 是复选框，并且是数组
                            for (var i = 0; i < ival.length; i++) {
                                if ($(this).val() == ival[i]) $(this).attr("checked", "checked");
                            }
                        } else {
                            if ($(this).val() == ival) $(this).attr("checked", "checked");
                        }
                    });
                } else {
                    $oinput.val(ival);
                }
                var $oselect = obj.find("select[name='" + name + "']");
                $oselect.each(function() {
                    $(this).select2("val", ival);
                });
                var $textarea = obj.find("textarea[name='" + name + "']");
                $textarea.each(function() {
                    $(this).val(ival);
                });
            });
        },
        /**
         * 将json赋值给表单元素，根据key和表单name对应的方式
         * 
         * @jsonValue 要赋值的json数据
         */
        setSelect2: function(options) {
            var defaultOps = {
                "width": "100%",
                id: "",
                data:"null",
                seach: 0,
                placeholder: "请选择",
                required: true,
                value: "",
                root: {
                    "id": 'id',
                    name: "name"
                },
                _extend: ""
            }
            var _extend = options._extend || defaultOps._extend;
            var _root = options.root || defaultOps.root;
            var _id = options.id || defaultOps.id;
            var _width = options.width || defaultOps.width;
            var _seach = (options.seach == true) ? true : -1;
            var _placeholder = options.placeholder || defaultOps.placeholder;
            var _obj = $(_id);
            var _data = options.data || defaultOps.data;
            var _value = options.value || defaultOps.value;
            if (_value == "" && options.required == false) {
                _value = _data[0].id || _data[0].key;
            }
            if (options.required == false) {
                var _required = false;
            } else {
                var _required = defaultOps.required;
            }
            var _options = '';
            if (_required) {
                _options = '<option value="">' + _placeholder + '</option>';
            }
            if(_data!="null"){  $.each(_data, function(index, _this) {
                var _key = _this[_root.id];
                var _val = _this[_root.name];
                _options += '<option value="' + _key + '">' + _val + '</option>'
            });
             _obj.html(_options);
            }
            _obj.select2({
                "width": _width,
                "val": _value,
                minimumResultsForSearch: _seach
            }).select2("val", _value);
        },
        /**
         * 刷新select2列表
         * 
         * @jsonValue 要赋值的json数据
         */
        refreshSelect2: function(options) {
            var defaultOps = {
                id: "",
                data: [],
                value: ""
            }
            var _id = options.id || defaultOps.id;
            var _data = options.data || defaultOps.data;
            var _obj = $(_id);
            var _data = options.data || defaultOps.data;
            var _value = options.value || defaultOps.value;
            var _options = '<option value="">' + $(_id).find('option:first').text() + '</option>';
            $.each(_data, function(index, _this) {
                var _key = _this.key || _this.id;
                var _val = _this.value || _this.name
                _options += '<option value="' + _key + '">' + _val + '</option>'
            });
            _obj.html(_options);
            _obj.select2("val", _value);
        },
        /**
         * 指定长度截取字符串，并且显示省略号
         * 
         * @str 要截取的字符串
         * @len 要截取的长度
         */
        subStr: function(str, len) {
            if (undefined == str || str == null || str == '') {
                return str = '<div>' + '-' + '</div>';
            } else {
                var length = str.length;
                var S = str.substr(0, len);
                if (length > len) {
                    var S = str.substr(0, len) + "...";
                }
                return str = '<div title="' + str + '">' + S + '</div>';
            }
        },
        /**
         * 将元转成分保留相应位数
         * 
         * @s 传入的float数字
         * @n 希望返回小数点几位
         */
        fmoney: function(s, n) {
            n = n > 0 && n <= 20 ? n : 2;
            s = s / 100;
            s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
            var l = s.split(".")[0].split("").reverse(),
                r = s.split(".")[1];
            t = "";
            for (i = 0; i < l.length; i++) {
                t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
            }
            return t.split("").reverse().join("") + "." + r;
        },
        /**
         * 跳转到指定页面
         * 
         * @eml 承载被加载的内容容器
         * @path 要加载的路径
         */
        loadPage: function(eml, path) {
            var _this = $(eml);
            var _path = path;
            _this.load(_path);
        },
        /**
         * 本地存储功能-存储 @ obj：要存储的对象 @ key :存储的key值
         */
        setStorage: function(obj, key) {
            sessionStorage[key] = JSON.stringify(obj);
        },
        /**
         * 本地存储功能-读取 @ key :根据key读取相应的对象
         */
        getStorage: function(key) {
            var str = sessionStorage[key] || ""
            if (str == "") {
                return false
            }
            return JSON.parse(str);
        },
        /**
         * 本地存储功能-删除 @ obj：要存储的对象
         */
        delStorage: function(key) {
            var _key = key || "";
            if (_key == "") {
                sessionStorage.clear();
            }
            sessionStorage[key] = null;
        },
        /**
         * 导出数据接收文件流form方式提交后台 
         * @ url：服务端导出接口
         * @options:传给服务端的data参数 json格式
         */
        exportFile: function(url, options) {
            var inputGroupH = '';
            $.each(options, function(key, val) {
                inputGroupH += '<input value="' + val + '" name="' + key + '"/>'
            });
            var toolFormHtml = '<form method="post" id="toolForm" action="' + url + '">' + inputGroupH + '</form>';
            $('body').append(toolFormHtml);
            $("#toolForm").submit();
            $("#toolForm").remove();
        }
    }
})(window, $);