<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/json; charset=UTF-8">
<title>SystemDictionary列表展示</title>
<%@include file="/WEB-INF/view/common/common.jsp"%>
<script type="text/javascript">
	$(function() {
		//声明变量
		var systemDictionaryGrid, systemDictionaryForm, systemDictionaryDlg;
		//缓存变量
		systemDictionaryGrid = $('#systemDictionaryGrid');//数据表格
		systemDictionaryForm = $("#systemDictionaryForm");//新增或修改的表单
		systemDictionaryDlg = $("#systemDictionaryDlg");//会话框
		//初始化组件
		systemDictionaryForm.form({
			url : '/systemDictionary/save',
			onSubmit : function() { //提交表单前的操作
				return $(this).form('validate');
				console.debug(this);
			},
			success : function(result) { // result返回的数据
				try {
					//出错信息，这里要放在try  里面才能捕获错误信息。现在在'success'回调函数中处理JSON字符串。
					var data = $.parseJSON(result);
					if (data.success) {
						systemDictionaryDlg.dialog('close'); // 关闭选项卡
						systemDictionaryGrid.datagrid('reload'); // 重新加载数据
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
				systemDictionaryForm.form('clear'); //清除原来的。
				//设置状态有默认值
				/* 	$("#radio").prop("checked", true); */
				systemDictionaryDlg.dialog('open').dialog('setTitle', '新增用户'); //打开一个会话框，设置标题
			},
			deleteObj : function() { //删除
				console.debug(111);
				var row = systemDictionaryGrid.datagrid('getSelected'); //获得选中的行的数据
				if (!row) {
					$.messager.alert('提示信息', '请选择要删除的行!', 'warning'); //消息的使用  
				}
				if (row) {
					$.messager.confirm('Confirm', '确认删除吗?', function(r) {
						if (r) {
							$.post('/systemDictionary/delete/' + row.id, //这里是jQuery里面的json,所以不用转
							function(result) { //处理结果**********
								if (result.success) {
									systemDictionaryGrid.datagrid('reload'); // 刷新数据
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
				var row = systemDictionaryGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选择修改的项!', 'warning');
				}
				if (row) {
					systemDictionaryDlg.dialog('open').dialog('setTitle',
							'修改用户');
					// 部门经理
					//if (row.manager) {
					//	row["manager.id"] = row.manager.id;
					//}
					// 上级部门******这里只是赋值，真正回显示在最后面
					//if (row.parent) {
					//	row["parent.id"] = row.parent.id;
					//}
					systemDictionaryForm.form('load', row); //回显
				}
			},
			save : function() { //保存
				systemDictionaryForm.submit();
			},
			cancel : function() { //取消
				systemDictionaryDlg.dialog('close');
			},
			refresh : function() {//刷新
				//重新载入当前页面数据  
				systemDictionaryGrid.datagrid("reload");
			}

		}

		//对页面所有组件进行监听
		$("a[data-cmd]").on('click', function() {
			var cmd = $(this).data("cmd");//获取cmd **********
			if (cmd) {
				objCrm[cmd](); //获取对象属性，然后再调方法
			}
		});
	});
	//状态
	function dictionaryStateFormart(value, row, index) {
		if (value == 0) {
			return "<font color='green'>正常</font>";
		} else {
			return "<font color='red'>废弃</font>";
		}
	}

</script>

<script type="text/javascript">
	// 	************数据字典明细*********
//声明变量
var systemDictionaryItemGrid, systemDictionaryItemForm, systemDictionaryItemDlg;
//缓存变量
systemDictionaryItemGrid = $('#systemDictionaryItemGrid');//数据表格
systemDictionaryItemForm = $("#systemDictionaryItemForm");//新增或修改的表单
systemDictionaryItemDlg = $("#systemDictionaryItemDlg");//会话框
//初始化组件
systemDictionaryItemForm.form({
	url : '/systemDictionaryItem/save',
	onSubmit : function() { //提交表单前的操作
		return $(this).form('validate');
		console.debug(this);
	},
	success : function(result) { // result返回的数据
		try {
			//出错信息，这里要放在try  里面才能捕获错误信息。现在在'success'回调函数中处理JSON字符串。
			var data = $.parseJSON(result);
			if (data.success) {
				systemDictionaryItemDlg.dialog('close'); // 关闭选项卡
				systemDictionaryItemGrid.datagrid('reload'); // 重新加载数据
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
var objCrmItem = {
	createItem : function() {//新增
		systemDictionaryItemForm.form('clear'); //清除原来的。
		//设置状态有默认值
		/* 	$("#radio").prop("checked", true); */
		systemDictionaryItemDlg.dialog('open').dialog('setTitle',
				'新增用户'); //打开一个会话框，设置标题
	},
	deleteObjItem : function() { //删除
		console.debug(111);
		var row = systemDictionaryItemGrid.datagrid('getSelected'); //获得选中的行的数据
		if (!row) {
			$.messager.alert('提示信息', '请选择要删除的行!', 'warning'); //消息的使用  
		}
		if (row) {
			$.messager.confirm('Confirm', '确认删除吗?', function(r) {
				if (r) {
					$.post('/systemDictionaryItem/delete/' + row.id, //这里是jQuery里面的json,所以不用转
							function(result) { //处理结果**********
								if (result.success) {
									systemDictionaryItemGrid
											.datagrid('reload'); // 刷新数据
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
	updateItem : function() {//修改
		var row = systemDictionaryItemGrid.datagrid('getSelected');
		if (!row) {
			$.messager.alert('温馨提示', '请选择修改的项!', 'warning');
		}
		if (row) {
			systemDictionaryItemDlg.dialog('open').dialog('setTitle',
					'修改用户');
			// 部门经理
			//if (row.manager) {
			//	row["manager.id"] = row.manager.id;
			//}
			// 上级部门******这里只是赋值，真正回显示在最后面
			//if (row.parent) {
			//	row["parent.id"] = row.parent.id;
			//}
			systemDictionaryItemForm.form('load', row); //回显
		}
	},
	saveItem : function() { //保存
		systemDictionaryItemForm.submit();
	},
	cancelItem : function() { //取消
		systemDictionaryItemDlg.dialog('close');
	},
	refreshItem : function() {//刷新
		//重新载入当前页面数据  
		systemDictionaryItemGrid.datagrid("reload");
	}

}

//对页面所有组件进行监听
$("a[data-cmdItem]").on('click', function() {
	var cmdItem = $(this).data("cmdItem");//获取cmd **********
	if (cmdItem) {
		objCrmItem[cmdItem](); //获取对象属性，然后再调方法
	}
});
});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west'" title="数据字典目录" style="width: 800px;"
		border="0">
		<!-- 	***********放置原来数据字典目录页面 -->

		<!-- 列表展示，分页  rownumbers="true"  style="height:auto"  field="username" 这里标签必须要用field属性，
	不能自定义了，因为这有这样才能 显示数据，否则没效果 -->
		<table id="systemDictionaryGrid" class="easyui-datagrid" title="数据字典"
			fit="true" url="/systemDictionary/json" pagination="true"
			rownumbers="true" singleSelect="true"
			toolbar="#systemDictionarytToolbar" fitColumns="true" border="1">
			<thead>
				<tr>
					<th field="sn" width="sn">编号</th>
					<th field="name" width="80">分类名称</th>
					<th field="intro" width="80">字典目录简介</th>
					<th field="state" width="80" formatter="dictionaryStateFormart">状态</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>

		<!-- 放在标题栏下面，表格上面的工具按钮，增删改 -->
		<div id="systemDictionarytToolbar">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-add" data-cmd="create">添加</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-edit" data-cmd="update">修改</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-remove" data-cmd="deleteObj">删除</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-reload" data-cmd="refresh">刷新</a>
		</div>

		<!-- 修改的选择框   required="true"   必须填 dlg 选择框-->
		<div id="systemDictionaryDlg" class="easyui-dialog"
			style="width: 400px; height: 280px; padding: 10px 20px" closed="true"
			buttons="#systemDictionaryDlg-buttons">
			<div class="ftitle">新增用户</div>
			<!-- 里面的表格  -->
			<form id="systemDictionaryForm" class="myform" method="post">
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
					<label>简介:</label> <input name="intro">
				</div>
				<div class="fitem">
					<label>状态:</label> <input name="state">
				</div>
			</form>
		</div>

		<!-- 选择框的按钮 -->
		<div id="systemDictionaryDlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-ok" data-cmd="save">保存</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-cancel" data-cmd="cancel">取消</a>
		</div>
	</div>
	</div>

	<div data-options="region:'center',iconCls:'icon-ok'">
		<!--************放置数据字典明细页面*********** -->
		<table id="systemDictionaryItemGrid" class="easyui-datagrid"
			title="数据字典明细管理" fit="true" url="/systemDictionaryItem/json"
			pagination="true" rownumbers="true" singleSelect="true"
			toolbar="#systemDictionaryItemtToolbar" fitColumns="true" border="1">
			<thead>
				<tr>
					<th field="name" width="80">明细名称</th>
					<th field="requence" width="requence">明细编号</th>
					<th field="intro" width="80">字典目录明细</th>
					<th field="parent" width="80" formatter="objFormart">所属分类</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<!-- 放在标题栏下面，表格上面的工具按钮，增删改 -->
		<div id="systemDictionaryItemtToolbar">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-add" data-cmdItem="createItem">添加</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-edit" data-cmdItem="updateItem">修改</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-remove" data-cmdItem="deleteObjItem">删除</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-reload" data-cmdItem="refreshItem">刷新</a>
		</div>
		<!-- 修改的选择框   required="true"   必须填 dlg 选择框-->
		<div id="systemDictionaryItemDlg" class="easyui-dialog"
			style="width: 400px; height: 280px; padding: 10px 20px" closed="true"
			buttons="#systemDictionaryItemDlg-buttons">
			<div class="ftitle">新增用户</div>
			<!-- 里面的表格  -->
			<form id="systemDictionaryItemForm" class="myform" method="post">
				<input name="id" type="hidden">
				<div class="fitem">
					<label>所属分类:</label> <input name="parentId"
						class="easyui-validatebox" required="true">
				</div>
				<div class="fitem">
					<label>名称:</label> <input name="name" class="easyui-validatebox"
						required="true">
				</div>
				<div class="fitem">
					<label>明细编号:</label> <input name="requence">
				</div>
				<div class="fitem">
					<label>简介:</label> <input name="intro">
				</div>

			</form>
		</div>
		<!-- 选择框的按钮 -->
		<div id="systemDictionaryItemDlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-ok" data-cmd="saveItem">保存</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-cancel" data-cmd="cancelItem">取消</a>
		</div>

	</div>
</body>
</html>