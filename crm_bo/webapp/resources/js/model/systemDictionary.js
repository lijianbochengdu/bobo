//处理关联对象的显示值，formatter="objFormart" 调用就采用直接填写方法名
function objFormart(value, row, index) {
	return value ? value.realName || value.name : "";
}
//状态
function stateFormart(value, row, index) {
	if (value == 0) {
		return "<font color='green'>正常</font>";
	} else {
		return "<font color='red'>停用</font>";
	}
}