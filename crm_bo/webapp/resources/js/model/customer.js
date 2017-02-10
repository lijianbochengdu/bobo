//处理关联对象的显示值，formatter="objFormart" 调用就采用直接填写方法名
function objFormart(value, row, index) {
	return value ? value.realName || value.name : "";
}
//状态
function genderFormart(value, row, index) {
	if (value) {
		return "<font color='green'>男</font>";
	} else {
		return "<font color='red'>女</font>";
	}
}