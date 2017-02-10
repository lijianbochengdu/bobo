package com.lijianbo.ssm.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.lijianbo.ssm.domain.${domain};
import com.lijianbo.ssm.mapper.${domain}Mapper;
import com.lijianbo.ssm.query.${domain}Query;
import com.lijianbo.ssm.query.PageList;

@RunWith(SpringJUnit4ClassRunner.class)  //记住了
@ContextConfiguration("classpath:applicationContext.xml")
public class ${domain}ServiceTest {
	@Autowired
	${domain}Mapper ${lowerDomain}Mapper;
	@Autowired
	I${domain}Service ${lowerDomain}Service;
	
	@Test
	public void testSave() {
		${domain} ${lowerDomain} = new ${domain}();
		
	}

	@Test
	public void testDelete() {
		${lowerDomain}Service.delete(7L);
	}

	@Test
	public void testUpdate() {
		${domain} ${lowerDomain} = ${lowerDomain}Service.get(9L);
		${lowerDomain}Service.update(${lowerDomain});
	}

	@Test
	public void testGet() {
		${domain} ${lowerDomain} = ${lowerDomain}Service.get(1L);
		System.out.println(${lowerDomain});
	}

	@Test
	public void testGetAll() {
		System.out.println(${lowerDomain}Service.getAll().size());
	}

	@Test
	public void testGetPageList() {
		${domain}Query  ${lowerDomain}Query = new ${domain}Query();
		
		PageList list = ${lowerDomain}Service.findByQuery(${lowerDomain}Query);
		${lowerDomain}Query.setPage(2);
		System.out.println("记录数"+list.getTotal());
		System.out.println("rows:"+list.getRows());
	}
}
