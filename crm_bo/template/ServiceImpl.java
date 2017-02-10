package com.lijianbo.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lijianbo.ssm.domain.${domain};
import com.lijianbo.ssm.domain.Employee;
import com.lijianbo.ssm.mapper.${domain}Mapper;
import com.lijianbo.ssm.query.BaseQuery;
import com.lijianbo.ssm.query.${domain}Query;
import com.lijianbo.ssm.query.PageList;
import com.lijianbo.ssm.service.I${domain}Service;
@Service
public class ${domain}ServiceImpl implements I${domain}Service {
	//这里没有dao了，通过mapper来实现持久化
	@Autowired
	${domain}Mapper ${lowerDomain}Mapper;
	
	@Override
	public void save(${domain} ${lowerDomain}) {
		${lowerDomain}Mapper.save(${lowerDomain});
	}

	@Override
	public void delete(Long id) {
		${lowerDomain}Mapper.delete(id);
	}

	@Override
	public void update(${domain} ${lowerDomain}) {
		${lowerDomain}Mapper.update(${lowerDomain});
	}

	@Override
	public ${domain} get(Long id) {
		return ${lowerDomain}Mapper.get(id);
	}

	@Override
	public List<${domain}> getAll() {
		return ${lowerDomain}Mapper.getAll();
	}

	/*
	 * 处理分页，高级查询，这里要将两个的查询合并放在PageList中，否则怎么返回一个数据呢 
	 * 融合getTotal 与findByQuery
	 */
	@Override
	public PageList findByQuery(BaseQuery ${lowerDomain}Query) {
		PageList pageList = new PageList();
		//总记录数
		Integer total = ${lowerDomain}Mapper.getTotal(${lowerDomain}Query);
		if(total != null && total == 0){
			return pageList;
		}
		pageList.setTotal(total);
		//查询数据
		 List<${domain}> rows = this.${lowerDomain}Mapper.findByQuery(${lowerDomain}Query);
		 pageList.setRows(rows);
		 return pageList;
	}

	/*
	 * 其他方法
	 */
//	@Override
//	public List<Employee> get${domain}Manager() {
//		return ${lowerDomain}Mapper.get${domain}Manager();
//	}
}
