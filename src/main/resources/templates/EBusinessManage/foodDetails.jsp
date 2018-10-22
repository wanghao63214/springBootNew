<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid" style="margin-top: 20px;">
    <div id="foodDetailContent" style="width:800px;">
    </div>
    <div class="form-group" style="margin-top: 70px;">
        <div class="col-xs-offset-2 col-sm-7">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('#foodDetailContent').html(food_name_check);

    });
</script>