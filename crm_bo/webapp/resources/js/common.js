//处理关联对象的显示值，formatter="objFormart" 调用就采用直接填写方法名
function objFormart(value, row, index) {
	return value ? value.realName || value.name : "";
}
//状态
function stateFormart(value, row, index) {
	//return value==0?"正常":"<font color='red'>停用</font>";
	if (value == 0) {
		return "<font color='green'>正常</font>";
	} else {
		return "<font color='red'>停用</font>";
	}
}
//转化为json格式数据
$.fn.serializeJson = function() {
	//创建一个空的json
	var paramObj = {};
	//获取集合 序列化表格元素 (类似 '.serialize()' 方法) 返回 JSON 数据结构数据。
	var arrays = $(this).serializeArray();
	//
	$(arrays).each(function(index,obj){
		paramObj[obj.name]=obj.value;  //将参数封装到对象中
	});
	return paramObj;  //一定要返回封装后的对象，否则无效
}







