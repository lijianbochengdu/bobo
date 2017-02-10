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
		var employeeGrid, employeeForm, employeeDlg, searchFrom;
		var clearFrom;
		//缓存变量
		employeeGrid = $('#employeeGrid');
		employeeForm = $("#employeeForm");
		employeeDlg = $("#employeeDlg");
		searchFrom = $("#searchFrom");
		clearFrom = $("#clearFrom");

		//初始化组件
		employeeForm.form({
			url : '/employee/save',
			onSubmit : function() { //提交表单前的操作
				return $(this).form('validate');
				console.debug(this);
			},
			success : function(result) { // result返回的数据
				try {
					//出错信息，这里要放在try  里面才能捕获错误信息。现在在'success'回调函数中处理JSON字符串。
					var data = $.parseJSON(result);
					if (data.success) {
						employeeDlg.dialog('close'); // 关闭选项卡
						employeeGrid.datagrid('reload'); // 重新加载数据
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
				employeeForm.form('clear'); //清除原来的。
				//设置状态有默认值
				$("#radio").prop("checked", true);
				employeeDlg.dialog('open').dialog('setTitle', '新增用户'); //打开一个会话框，设置标题
			},
			deleteObj : function() { //删除
				//console.debug(111);
				var row = employeeGrid.datagrid('getSelected'); //获得选中的行的数据
				if (!row) {
					$.messager.alert('提示信息', '请选择要删除的行!', 'warning'); //消息的使用  
				}
				if (row) {
					$.messager.confirm('Confirm', '确认删除吗?', function(r) {
						if (r) {
							$.post('/employee/delete/' + row.id, //这里是jQuery里面的json,所以不用转
							function(result) { //处理结果**********
								if (result.success) {
									employeeGrid.datagrid('reload'); // 刷新数据
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
				var row = employeeGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选择修改的项!', 'warning');
				}
				if (row) {
					employeeDlg.dialog('open').dialog('setTitle', '修改用户');
					// 部门经理
					if (row.manager) {
						row["manager.id"] = row.manager.id;
					}
					// 上级部门*******************这里只是赋值，真正回显示在最后面
					if (row.parent) {
						row["parent.id"] = row.parent.id;
					}
					employeeForm.form('load', row); //回显
				}
			},
			save : function() { //保存
				employeeForm.submit();
			},
			cancel : function() { //取消
				employeeDlg.dialog('close');
			},
			refresh : function() {//刷新
				//重新载入当前页面数据  
				employeeGrid.datagrid("reload");
				/* searchFrom.datagrid("clear"); */
			},
			searchFrom : function() {//搜索
				//将通过调用序列化的方法，将参数封装为一个对象。
				var paramObj = searchFrom.serializeJson();
				//重新载入当前页面数据  ，同时传递当前页面的查询条件，参数，这样就还是会回到原来的页面。
				employeeGrid.datagrid('load', paramObj);
			},
			clearFrom : function() {//清空搜索
				//alert(0);
				searchFrom.form("clear");
				//将通过调用序列化的方法，将参数封装为一个对象。
				var paramObj = searchFrom.serializeJson();
				//重新载入当前页面数据  ，同时传递当前页面的查询条件，参数，这样就还是会回到原来的页面。
				employeeGrid.datagrid('load', paramObj);
				//employeeGrid.datagrid("reload");      这个是重新加载，但是会带参数 
			},
			leave : function() {//离职
				//alert(0);
				
				var row = employeeGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选择要修改的项!', 'warning');
				}
				if (row) {
					$.messager.confirm('Confirm', '确认离职吗?', function(r) {
						if (r) {
							$.post('/employee/leave/'+ row.id, 
							function(result) { //处理结果**********
								if (result.success) {
									$("#leave").linkbutton('disable');//灰色图标
									employeeGrid.datagrid('reload'); // 刷新数据
								} else {
									$.messager.show({ // 显示错误
										title : 'Error',
										msg : result.msg
									});
								}
							}, 'json');
						}
					});
				}
				
				
				
			}

		}

		//对页面所有组件进行监听
		$("a[data-cmd]").on('click', function() {
			var cmd = $(this).data("cmd");//获取cmd **********
			if (cmd) {
				if($(this).hasClass("l-btn-disabled")){
					return;
				}
				objCrm[cmd](); //获取对象属性，然后再调方法
			}
		});

	});
	//状态
	function employeeStateFormart(value, row, index) {
		if (value == 0) {
			return "<font color='green'>正常</font>";
		} else {
			return "<font color='red'>离职</font>";
		}
	}
	
// 	datagrid:在用户点击一行的时候触发，参数包括：
	// 	rowIndex：点击的行的索引值，该索引值从0开始。
	// 	rowData：对应于点击行的记录。
	function clickRow(rowIndex, rowData) {
		//alert(rowIndex);
		if(rowData.state==-1){//离职状态
			//把离职按钮禁用掉
			$("#leave").linkbutton('disable');
		}else{
			$('#leave').linkbutton('enable');//启用按钮
		}
	}
</script>
</head>
<body>
	<!-- 列表展示，分页  rownumbers="true"  style="height:auto"  field="username" 这里标签必须要用field属性，
	不能自定义了，因为这有这样才能 显示数据，否则没效果 -->
	<table id="employeeGrid" class="easyui-datagrid" fit="true"
		url="/employee/json" pagination="true" rownumbers="true"
		singleSelect="true" toolbar="#employeetToolbar" fitColumns="true"
		border="1" data-options="onClickRow:clickRow">
		<thead>
			<tr>
				<th field="id" width="80">id</th>
				<th field="username" width="80">员工编号</th>
				<th field="realName" width="80">员工姓名</th>
				<th field="password" width="80">密码</th>
				<th field="tel" width="80">电话</th>
				<th field="email" width="80">email</th>
				<th field="inputTime" width="80">录入时间</th>
				<th field="state" width="80" formatter="employeeStateFormart">状态</th>
				<th field="department" width="80" formatter="objFormart">部门</th>
				<th field="role" width="80" formatter="objFormart">角色</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<!-- 放在标题栏下面，表格上面的工具按钮，增删改 -->
	<div id="employeetToolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" data-cmd="create">添加</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" data-cmd="update">修改</a> 
			
			<c:if test="${crm:permission('部门列表')}">          
				<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-remove" data-cmd="deleteObj">删除</a>
			</c:if> 
			
			 <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-reload" data-cmd="refresh">刷新</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" data-cmd="leave" id="leave">离职</a>
		<div>
			<form id="searchFrom" action="/employee/json" method="post">
				关键字：<input name="keyword" style="height: 17px" size="10">
				部门：<input class="easyui-combotree" name="departmentId"
					data-options="url:'/department/parentDepartment',method:'post',panelHeight:'auto'"
					style="width: 140px;"> 录入时间从：<input class="easyui-datebox"
					name="biginDate" style="height: 17px" size="10">到 <input
					class="easyui-datebox" name="endDate" style="height: 17px"
					size="10"> <a href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-search"
					data-cmd="searchFrom">搜索</a> <a href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-search"
					data-cmd="clearFrom">清空搜索</a>
			</form>
		</div>
	</div>




	<!-- 修改的选择框   required="true"   必须填 dlg 选择框-->
	<div id="employeeDlg" class="easyui-dialog"
		style="width: 400px; height: 280px; padding: 10px 20px" closed="true"
		buttons="#employeeDlg-buttons">
		<div class="ftitle">新增用户</div>
		<!-- 		里面的表格  -->
		<form id="employeeForm" class="myform" method="post">
			<!-- 这里必须要加id为隐藏域，因为修改的时候要用这个id来到传递参数。 -->
			<input name="id" type="hidden">
			<div class="fitem">
				<label>员工编号:</label> <input name="username"
					class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>员工姓名:</label> <input name="realName"
					class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>密码:</label> <input name="password" class="easyui-validatebox"
					required="true">
			</div>
			<div class="fitem">
				<label>电话:</label> <input name="tel" class="easyui-validatebox"
					required="true">
			</div>
			<div class="fitem">
				<label>邮箱:</label> <input name="email" class="easyui-validatebox">
			</div>
			<div class="fitem">
				<label>录入时间:</label> <input name="inputTime"
					class="easyui-datetimebox" required style="width: 150px">
			</div>
			<div class="fitem">
				<label>电话:</label> <input name="" class="easyui-validatebox">
			</div>
			<!--<select name="manager.id"这里才是参数传递，idField: 'itemid', 传递的参数,和下面的id 对应 textField: 'realName',表示显示的内容  -->
			<div class="fitem">
				<label>角色:</label> <select name="role.id" class="easyui-combogrid"
					style="width: 250px"
					data-options="
            panelWidth: 500,
            idField: 'id',
            textField: 'name', 
            url: '/role/json',
            method: 'post',
            columns: [[
                {field:'id',title:'ID',width:80},
                {field:'sn',title:'角色编号',width:120},
                {field:'name',title:'角色名称',width:80,align:'right'}
            ]],
            fitColumns: true
        ">
				</select>
			</div>
			<div class="fitem">
				<label>部门:</label> <input class="easyui-combotree"
					name="department.id"
					data-options="url:'/department/parentDepartment',method:'post',panelHeight:'auto'"
					style="width: 200px;">
			</div>
			<div class="fitem">
				<label>状态:</label> <input id="radio" type="radio" name="state"
					value="0">正常 <input type="radio" name="state" value="-1">离职
			</div>
		</form>
	</div>

	<!-- 	选择框的按钮 -->
	<div id="employeeDlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-ok" data-cmd="save">保存</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" data-cmd="cancel">取消</a>
	</div>

</body>
</html>