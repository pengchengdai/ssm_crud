package com.dpc.test;

import com.dpc.dao.DepartmentMapper;
import com.dpc.dao.EmployeeMapper;
import com.dpc.domain.Department;
import com.dpc.domain.Employee;
import com.dpc.domain.EmployeeExample;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * @author dpc
 * @create YEAR−{YEAR}-YEAR−{MONTH}-10 21:29
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:bean.xml")
public class MapperTest {
    @Autowired
    DepartmentMapper mapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void DeptTest(){
//        ApplicationContext context = new ClassPathXmlApplicationContext("bean.xml");
//        DepartmentMapper bean = context.getBean(DepartmentMapper.class);
//        Department department = new Department(null,"产品部");
//        mapper.insertSelective(department);

        //批量插入：需要通过SqlSession获取Bean
//        EmployeeMapper empMapper = sqlSession.getMapper(EmployeeMapper.class);
//        for(int i=0;i<1000;i++){
//            String uuid = UUID.randomUUID().toString().substring(0,10);
//            empMapper.insertSelective(new Employee(null,uuid+i,"M",uuid+"@dpc.com"));
//        }

        //查询
        /*Employee employee = employeeMapper.selectByPrimaryKeyWithDept(1);
        System.out.println(employee);
        Department dept = employee.getDept();
        System.out.println(dept);


*/


        /*EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo("c6957fe1-50");
        List<Employee> employees = employeeMapper.selectByExample(example);
        System.out.println(employees);*/

        /*Employee employee = employeeMapper.selectByPrimaryKey(1);
        System.out.println(employee);*/

        Employee employee = new Employee();
        employee.setEmpId(1);
        employee.setEmpName("zs");
        employee.setGender("F");
        employee.setEmail("zs12455@qq.com");
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdEqualTo(employee.getEmpId());
        employeeMapper.updateByExampleSelective(employee,example);

    }
}
