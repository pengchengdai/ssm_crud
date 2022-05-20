package com.dpc.test;

import com.dpc.domain.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author dpc
 * @create YEAR−{YEAR}-YEAR−{MONTH}-11 15:26
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:bean.xml","classpath:SqlMapConfig.xml"})
@WebAppConfiguration//将SpringMVC容器自动转配
public class PageHelperTest {
    //虚拟mvc
    MockMvc mvc;
    //SpringMVC容器
    @Autowired
    WebApplicationContext context;

    @Before
    public void init(){
        mvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void pageTest() throws Exception {
        //模拟请求，拿到返回值
        MockHttpServletRequestBuilder builder = MockMvcRequestBuilders.get("/emps");
        MvcResult result = mvc.perform(builder.param("pn", "1")).andReturn();
        //获取请求
        MockHttpServletRequest request = result.getRequest();
        PageInfo<Employee> pageInfo = (PageInfo<Employee>) request.getAttribute("pageInfo");
        System.out.println("当前页码="+pageInfo.getPageNum());
        System.out.println("总页码="+pageInfo.getPages());
        System.out.println("总记录数="+pageInfo.getTotal());

        System.out.println("获取关联页码");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int num : nums) {
            System.out.print(num+",");
        }
        System.out.println();

        System.out.println("分页数据");
        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println(employee);
        }
    }

}
