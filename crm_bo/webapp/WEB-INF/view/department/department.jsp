<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/json; charset=UTF-8">
<title>第一个easyUI</title>
<%@include file="/WEB-INF/view/common/common.jsp"%>
<script type="text/javascript">
	$(function() {
		//声明变量
		var departmentGrid, departmentForm, departmentDlg, searchFrom;
		var departmentSearchDlg,departmentSearchForm;
		//缓存变量
		departmentGrid = $('#departmentGrid');
		departmentForm = $("#departmentForm");
		departmentDlg = $("#departmentDlg");
		searchFrom = $("#searchFrom");
		
		departmentSearchDlg = $("#departmentSearchDlg");
		departmentSearchForm = $("#departmentSearchForm");
		//初始化组件
		departmentForm.form({
			url : '/department/save',
			onSubmit : function() { //提交表单前的操作
				return $(this).form('validate');
				console.debug(this);
			},
			success : function(result) { // result返回的数据
				try {
					//出错信息，这里要放在try  里面才能捕获错误信息。现在在'success'回调函数中处理JSON字符串。
					var data = $.parseJSON(result);
					if (data.success) {
						departmentDlg.dialog('close'); // 关闭选项卡
						departmentGrid.datagrid('reload'); // 重新加载数据
					} else {
						$.messager.show({ //失败
							title : '保存出错',
							msg : data.errorMsg
						});
					}
				} catch (e) {
					$.messager.show({ //失败
						title : 'Error',
						msg : "出现转换异常！"
					});
				}
			}
		});
		//命令对象"，----这里面定义各种方法          创建一个组件。
		var objCrm = {
			create : function() {//新增
				departmentForm.form('clear'); //清除原来的。
				//设置状态有默认值
				$("#radio").prop("checked", true);
				departmentDlg.dialog('open').dialog('setTitle', '新增用户'); //打开一个会话框，设置标题
			},
			deleteObj : function() { //删除
				console.debug(111);
				var row = departmentGrid.datagrid('getSelected'); //获得选中的行的数据
				if (!row) {
					$.messager.alert('提示信息', '请选择要删除的行!', 'warning'); //消息的使用  
				}
				if (row) {
					$.messager.confirm('Confirm', '确认删除吗?', function(r) {
						if (r) {
							$.post('/department/delete/' + row.id, //这里是jQuery里面的json,所以不用转
							function(result) { //处理结果**********
								if (result.success) {
									departmentGrid.datagrid('reload'); // 刷新数据
								} else {
									$.messager.show({ // 显示错误
										title : 'Error',
										msg : result.msg
									//这里要和自己的
									});
								}
							}, 'json');
						}
					});
				}
			},
			update : function() {//修改
				var row = departmentGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选择修改的项!', 'warning');
				}
				if (row) {
					departmentDlg.dialog('open').dialog('setTitle', '修改用户');
					// 部门经理
					if (row.manager) {
						row["manager.id"] = row.manager.id;
					}
					// 上级部门*******************这里只是赋值，真正回显示在最后面
					if (row.parent) {
						row["parent.id"] = row.parent.id;
					}
					departmentForm.form('load', row); //回显
				}
			},
			save : function() { //保存
				departmentForm.submit();
			},
			cancel : function() { //取消
				departmentDlg.dialog('close');
			},
			refresh : function() {//刷新
				//重新载入当前页面数据  
				departmentGrid.datagrid("reload");
			},
			searchFrom : function() {//搜索
				//获取json数据，
				//alert(0);
				var departmentJson = searchFrom.serializeJson();
				//重新载入当前页面数据，这里只能加载jso格式数据  ，reload是带条件返回，load是从新加载返回首页。
				departmentGrid.datagrid("reload", departmentJson);
			},
			openSearchForm : function() {//高级搜索      打开
				departmentSearchDlg.dialog('open').dialog('setTitle', '高级查询');
			},
			cancelSearch : function() {//取消高级搜索
				departmentSearchForm.form('clear');
				departmentSearchDlg.dialog("close");
			},
			saveSearch : function() {//高级查询
				var paramJson = departmentSearchForm.serializeJson();
				departmentGrid.datagrid("reload", paramJson);
				
			}

		}
// *****************************************************************  
		//对页面所有组件进行监听        cancelSearch
		$("a[data-cmd]").on('click', function() {
			var cmd = $(this).data("cmd");//获取cmd **********
			if (cmd) {
				objCrm[cmd](); //获取对象属性，然后再调方法
			}
		});

	});
</script>
</head>
<body>
	<!-- 列表展示，分页  rownumbers="true"  style="height:auto"  field="username" 这里标签必须要用field属性，
	不能自定义了，因为这有这样才能 显示数据，否则没效果 -->
	<table id="departmentGrid" class="easyui-datagrid" title="部门管理"
		fit="true" url="/department/json" pagination="true" rownumbers="true"
		singleSelect="true" toolbar="#departmenttToolbar" fitColumns="true"
		border="1">
		<thead>
			<tr>
				<th field="id" width="80">id</th>
				<th field="sn" width="80">编号</th>
				<th field="name" width="80">部门名称</th>
				<th field="dirPath" width="80">路径</th>
				<th field="manager" width="80" formatter="objFormart">部门经理</th>
				<th field="parent" width="80" formatter="objFormart">上级部门</th>
				<th field="state" width="80" formatter="stateFormart">状态</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<!-- 放在标题栏下面，表格上面的工具按钮，增删改 -->
	<div id="departmenttToolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" data-cmd="create">添加</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" data-cmd="update">修改</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" data-cmd="deleteObj">删除</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-reload" data-cmd="refresh">刷新</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-search"  data-cmd="openSearchForm">高级查询</a>
		<form id="searchFrom" action="/department/json" method="post">
			关键字：<input  name="keyword" size="10"> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" data-cmd="searchFrom">搜索</a>
		</form>

	</div>

	<!-- 修改的选择框   required="true"   必须填 dlg 选择框-->
	<div id="departmentDlg" class="easyui-dialog"
		style="width: 400px; height: 280px; padding: 10px 20px" closed="true"
		buttons="#departmentDlg-buttons">
		<div class="ftitle">新增用户</div>
		<!-- 		里面的表格  -->
		<form id="departmentForm" class="myform" method="post">
			<!-- 这里必须要加id为隐藏域，因为修改的时候要用这个id来到传递参数。 -->
			<input name="id" type="hidden">
			<div class="fitem">
				<label>编号:</label> <input name="sn" class="easyui-validatebox"
					required="true">
			</div>
			<div class="fitem">
				<label>用户名:</label> <input name="name" class="easyui-validatebox"
					required="true">
			</div>
			<div class="fitem">
				<label>路径:</label> <input name="dirPath" class="easyui-validatebox">
			</div>
			<!--<select name="manager.id"这里才是参数传递，idField: 'itemid', 传递的参数,和下面的id 对应 textField: 'realName',表示显示的内容  -->
			<div class="fitem">
				<label>部门经理:</label> <select name="manager.id"
					class="easyui-combogrid" style="width: 250px"
					data-options="
            panelWidth: 500,
            idField: 'id',
            textField: 'realName', 
            url: '/department/departmentManager',
            method: 'post',
            columns: [[
                {field:'id',title:'ID',width:80},
                {field:'realName',title:'姓名',width:120},
                {field:'tel',title:'电话',width:80,align:'right'},
                {field:'email',title:'邮箱',width:80,align:'right'},
                {field:'state',title:'状态',width:120},
            ]],
            fitColumns: true
        ">
				</select>
			</div>
			<div class="fitem">
				<label>上级部门:</label> <input class="easyui-combotree"
					name="parent.id"
					data-options="url:'/department/parentDepartment',method:'post',panelHeight:'auto'"
					style="width: 200px;">
			</div>
			<div class="fitem">
				<label>状态:</label> <input id="radio" type="radio" name="state"
					value="0">正常 <input type="radio" name="state" value="-1">停用
			</div>
		</form>
	</div>

	<!-- 	选择框的按钮 -->
	<div id="departmentDlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-ok" data-cmd="save">保存</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" data-cmd="cancel">取消</a>
	</div>
<!-- 	************************************************************ -->
		<!-- 修改的选择框   required="true"   必须填 dlg 选择框-->
	<div id="departmentSearchDlg" class="easyui-dialog"
		style="width: 400px; height: 280px; padding: 10px 20px" closed="true"
		buttons="#departmentSearchDlg-buttons">
		<div class="ftitle">高级查询</div>
		<!-- 		里面的表格  -->
		<form id="departmentSearchForm" class="myform" method="post">
			<div class="fitem">
				<label>关键字:</label> <input name="keyword"  >
			</div>
			<!--<select name="manager.id"这里才是参数传递，idField: 'itemid', 传递的参数,和下面的id 对应 textField: 'realName',表示显示的内容  -->
			<div class="fitem">
				<label>部门经理:</label> <select name="managerId" class="easyui-combogrid"
				style="width: 250px"
					data-options="
            panelWidth: 500,
            idField: 'id',
            textField: 'realName', 
            url: '/department/departmentManager',
            method: 'post',
            columns: [[
                {field:'id',title:'ID',width:80},
                {field:'realName',title:'姓名',width:120},
                {field:'tel',title:'电话',width:80,align:'right'},
                {field:'email',title:'邮箱',width:80,align:'right'},
                {field:'state',title:'状态',width:120},
            ]],
            fitColumns: true
        ">
				</select>
			</div>
			<div class="fitem">
				<label>上级部门:</label> <input class="easyui-combotree"
					name="parentId"
					data-options="url:'/department/parentDepartment',method:'post',panelHeight:'auto'"
					style="width: 200px;">
			</div>
			<div class="fitem">
				<label>状态:</label>
				<input id="radio2" type="radio" name="state" value="0">正常 
				<input type="radio" name="state"
					value="-1">停用
			</div>
		</form>
	</div>

	<!-- 	选择框的按钮 -->
	<div id="departmentSearchDlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-ok" data-cmd="saveSearch">查询</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" data-cmd="cancelSearch">取消</a>
	</div>

</body>
</html>