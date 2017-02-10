package com.lijianbo.ssm.web.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lijianbo.ssm.domain.${domain};
import com.lijianbo.ssm.domain.Employee;
import com.lijianbo.ssm.query.${domain}Query;
import com.lijianbo.ssm.query.PageList;
import com.lijianbo.ssm.service.I${domain}Service;
import com.lijianbo.ssm.utils.CrudResult;

/**
 * 说明：
 *
 */
@Controller
@RequestMapping("/${lowerDomain}")
public class ${domain}Controller {
	@Autowired
	I${domain}Service ${lowerDomain}Service;
	${domain} ${lowerDomain};
	/*
	 * 跳转页面
	 */
	@RequestMapping("/list")
	public String list() {
		return "${lowerDomain}/${lowerDomain}";
	}
	/*
	 * 返回页面数据
	 */
	@RequestMapping("/json")
	@ResponseBody  //会自动转为json
	public PageList json(${domain}Query baseQuery) {
		return  ${lowerDomain}Service.findByQuery(baseQuery);
	}
	/*
	 * 删除
	 * 这里采用resful 的格式
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Object delete(@PathVariable Long id) throws Exception {
		try {
			if (id != null) {
				${lowerDomain}Service.delete(id);  //删除
				return new CrudResult();
			} else {
				return new CrudResult("请传入id"); 
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new CrudResult("删除异常！错误信息："+e.getMessage());
		}
	}
	
	/*
	 * 新增和修改的保存
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Object save(${domain} ${lowerDomain}) throws Exception {
		try {
			if (${lowerDomain}.getId() == null ) {
				${lowerDomain}Service.save(${lowerDomain});
				return new CrudResult();
			} else {
				${lowerDomain}Service.update(${lowerDomain});
				return new CrudResult();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new CrudResult("保存出现转换异常，请注意格式"+e.getMessage());
		}
	}
	/*
	 * 下拉  树
	 */
//	@RequestMapping("/parent${domain}")
//	@ResponseBody
//	public List<${domain}> parent${domain}() throws Exception {
//		return ${lowerDomain}Service.getParentDeptTree();
//	}
	
	
}
