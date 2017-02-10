<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/json; charset=UTF-8">
<title>Role列表展示</title>
<%@include file="/WEB-INF/view/common/common.jsp"%>
<script type="text/javascript">

	$(function() {
		var roleForm = $("#roleForm");
		var roleDatagrid = $("#roleDatagrid");
		var roleDialog = $("#roleDialog");
		var roleAttrDatagrid = $("#roleAttrDatagrid");
		var selectPermissionDatagrid = $("#selectPermissionDatagrid");
		var allPermissionDatagrid = $("#allPermissionDatagrid");
		
		//初始化组件
		roleForm.form({
			url : '/role/save',
			onSubmit : function(param) { //提交表单前的操作
				//得到选择的所有行
				var rows = selectPermissionDatagrid.datagrid("getRows");
			for (var i = 0; i < rows.length; i++) {
				param['permissions['+i+'].id'] = rows[i].id; //将行的权限id给permissions
			}	
				return $(this).form('validate');
				//console.debug(this);
			},
			success : function(result) { // result返回的数据
				try {
					//出错信息，这里要放在try  里面才能捕获错误信息。现在在'success'回调函数中处理JSON字符串。
					var data = $.parseJSON(result);
					if (data.success) {
						roleDialog.dialog('close'); // 关闭选项卡
						roleDatagrid.datagrid('reload'); // 重新加载数据
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

		//命令对象"，   这里面定义各种方法     创建一个组件。
		var objCrm = {
			create : function() {//新增
				roleForm.form('clear'); //清除原来的。
				//设置状态有默认值
				/* 	$("#radio").prop("checked", true); */
				roleDialog.dialog('open').dialog('setTitle', '新增用户'); //打开一个会话框，设置标题
			},
			deleteObj : function() { //删除
				var row = roleDatagrid.datagrid('getSelected'); //获得选中的行的数据
				if (!row) {
					$.messager.alert('提示信息', '请选择要删除的行!', 'warning'); //消息的使用  
				}
				//console.debug("================"+row.id);
				if (row) {
					$.messager.confirm('Confirm', '确认删除吗?', function(r) {
						if (r) {
							$.post('/role/delete/' + row.id, //这里是jQuery里面的json,所以不用转
							function(result) { //处理结果**********
								if (result.success) {
									roleDatagrid.datagrid('reload'); // 刷新数据
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
				alert(0);
				var row = roleDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选择修改的项!', 'warning');
					return;
				}
				console.debug("===========修改的id==="+row.id);
					roleForm.form('load', row); //回显 角色
					//loadData加载本地数据，旧的行将会被移除
					selectPermissionDatagrid.datagrid("loadData",row.permissions);
					//console.debug(row.permissions);
					roleDialog.dialog('open').dialog('setTitle', '修改角色权限');
			},
			save : function() { //保存
				roleForm.submit();
			},
			cancel : function() { //取消
				roleDialog.dialog('close');
			},
			refresh : function() {//刷新
				//重新载入当前页面数据  
				roleDatagrid.datagrid("reload");
			}

		}

		//对页面所有组件进行监听
		$("a[data-cmd]").on('click', function() {
			var cmd = $(this).data("cmd");//获取cmd **********
			if (cmd) {
				objCrm[cmd](); //获取对象属性，然后再调方法
			}
		});

		/*主页   角色展示*/
		roleDatagrid.datagrid({
			url : '/role/json',
			fit : true,
			pagination : "true", //如果为true，则在数据表格控件底部显示分页工具栏。
			rownumbers : "true", //行号
			singleSelect : "true",  //单选
			toolbar : "#roletToolbar",
			title : "角色管理",
			fitColumns : "true",  //列自动扩展
			columns : [ [ {
				field : 'sn',
				title : '角色编号',
				width : 100,
				align : 'center'
			}, {
				field : 'name',
				title : '角色名称',
				width : 100,
				align : 'center'
			},{
				field : 'id',
				title : 'id',
				width : 100,
				align : 'center'
			}  ] ]
		});

		/*会话框*/
		roleDialog.dialog({
			title : '会话框',
			width : 700,
			height : 500,
			closed : true, //默认是打开，还是关闭，默认打开，刷新的时候就会打开。true是手动点击开
			cache : false, //放入缓存
			modal : true, //此方法指定对话框是否是模式对话框。模式对话框包含发送到父框架的所有用户输入内容。
			toolbar : [ {
				text : '保存',
				iconCls : 'icon-ok',
				handler : function() {
					roleForm.submit();
				}
			}, '-', {
				text : '取消',
				iconCls : 'icon-cancel',
				handler : function() {
					roleDialog.dialog('close');
				}
			} ]
		});
		/*######左侧选择权限*/
		selectPermissionDatagrid.datagrid({
			width : 200,
			width : 320,
			height : 300,
			columns : [ [ {
				field : 'name',
				title : '权限名称',
				width : 70
			}, {
				field : 'resource',
				title : '资源地址',
				width : 120,
				align : 'right'
			}, {
				field : 'state',
				title : '状态',
				width : 50,
				align : 'right'
			} ] ],
			onDblClickRow : removePermission
		//appendRow:

		});
		/*************右侧所有权限*/
		allPermissionDatagrid.datagrid({
			url : '/permission/json',
			width : 320,
			height : 300,
			onDblClickRow : addPermission,
			columns : [ [ {
				field : 'name',
				title : '权限名称',
				width : 70
			}, {
				field : 'resource',
				title : '资源地址',
				width : 120,
				align : 'right'
			}, {
				field : 'state',
				title : '状态',
				width : 50,
				align : 'right'
			} ] ]
		});

	});
	
	
	//添加权限
	function addPermission(rowIndex, rowData) {
		var selectPermissionDatagrid = $("#selectPermissionDatagrid");
		var rows = selectPermissionDatagrid.datagrid("getRows");
		for (var i = 0; i < rows.length; i++) {
			//console.debug(rowData.id);
			if (rows[i].id == rowData.id) {//判断左侧是否存在
				return;
			}
		}
		selectPermissionDatagrid.datagrid("appendRow", rowData);
	}
	//移除权限  onDblClickRow 
	function removePermission(rowIndex, rowData) {
		$("#selectPermissionDatagrid").datagrid("deleteRow", rowIndex);
		console.debug(rowIndex);
	}
</script>
</head>
<body>
	<table id="roleDatagrid"></table>
	<div id="roleDialog" class="easyui-dialog" title="My Dialog"
		style="width: 400px; height: 200px;"
		data-options="iconCls:'icon-save',resizable:true">
		<form id="roleForm" >
		<input name="id" type="hidden">
			<table >
				<tr>
					<td colspan="2"><label>角色编号:</label><input name="sn"
						class="easyui-validatebox" required="true"> <label>用户名:</label>
						<input name="name" class="easyui-validatebox" required="true">
						<table id="roleAttrDatagrid"></table></td>
				</tr>
				<tr>
					<td><table id="selectPermissionDatagrid"></table></td>
					<td><table id="allPermissionDatagrid"></table></td>
				</tr>


			</table>
		</form>
	</div>


	<!-- 放在标题栏下面，表格上面的工具按钮，增删改 -->
	<div id="roletToolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" data-cmd="create">添加</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" data-cmd="update">修改</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" data-cmd="deleteObj">删除</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-reload" data-cmd="refresh">刷新</a>
	</div>


</body>
</html>