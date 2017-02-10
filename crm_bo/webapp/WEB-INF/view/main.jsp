<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@taglib uri="/struts-tags" prefix="s"%>  
报错说这个找不到，那么直接去掉就是了嘛，反正我们没有Struts2的标签 --%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>CRM管理系统-EasyUI_李建波</title>
<%@include file="/WEB-INF/view/common/common.jsp"%>
<script type="text/javascript">
	$(function() { //页面加载完后
		$("#mainImg").attr("width", $("#tabs").width());
		$("#mainImg").attr("height", $("#tabs").height());

		$("#menuTree")
				.tree(
						{ //创建这个树的组件
							onClick : function(node) { //添加点击事件
								var url = node.url; //node 是一个节点属性
								var text = node.text; //显示节点文本，一般是我们的标题
								if (!url) {
									return;
								}
								var tt = $('#tabs'); //缓存选项卡对象
								if (tt.tabs("exists", text)) { //如果存在
									tt.tabs("select", text); //就选择到这个文本
								} else {
									tt
											.tabs(
													'add',
													{ //添加一个选项卡。
														title : text,
														content : "<iframe frameborder='0' src='" //这里要用iframe标签，这个会将页面中的引用的样式都全部带过来，
														//而原来的href  则只会把url请求的body中的内容引用过来，不能动态显示数据
																+ url
																+ "' style='width:100%;height:99.1%'></iframe>",
														closable : true
													});
								}
							}
						});
	});
</script>

</head>
<body id="body" class="easyui-layout" fit="true">
	<div data-options="region:'north'" style="height: 20px">
		fiyBird客户管理有限公司
		<div align="right">
		欢迎你，${loginUser.realName} 
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-back" onclick="javascript:location.href='/logOut'">退出</a>
		</div>
	</div>
	<div data-options="region:'south',split:true" style="height: 30px;">版权归FirBird科技股份公司所有，联系电话028-8567888</div>
	<!-- 	<div data-options="region:'east',split:true" title="East" -->
	<!-- 		style="width: 180px;">一般是说明，可以不要</div> -->
	<div data-options="region:'west',split:true,title:'系统菜单'"
		style="width: 170px">
		树菜单(有权限)
		<ul id="menuTree" class="easyui-tree"
			data-options="url:'/main/left',
				animate:true,lines:true">
		</ul>
	</div>
	<!-- 主面板 -->
	<div data-options="region:'center',title:'主面板',iconCls:'icon-ok'">
		<div id="tabs" class="easyui-tabs" fit="true">
			<div title="飞鸟科技" style="padding: 10px">
				<img id="mainImg" alt="飞鸟科技客户管理" src="/resources/image/3.jpg">
			</div>
		</div>
		<table class="easyui-datagrid"
			data-options="method:'get',border:false,singleSelect:true,fit:true,fitColumns:true">
			<thead>
			</thead>
		</table>
	</div>
	<!-- split boolean 为true时用户可以通过分割栏改变面板大小。  -->

</body>
</html>

