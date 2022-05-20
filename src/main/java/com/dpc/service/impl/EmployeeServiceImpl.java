package com.dpc.service.impl;

import com.dpc.dao.EmployeeMapper;
import com.dpc.domain.Employee;
import com.dpc.domain.EmployeeExample;
import com.dpc.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author dpc
 * @create YEAR−{YEAR}-YEAR−{MONTH}-11 13:59
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    public EmployeeMapper mapper;

    @Override
    public List<Employee> findAll() {
        List<Employee> employees = mapper.selectByExampleWithDept(null);
        return employees;
    }

    @Override
    public void saveEmp(Employee employee) {
        mapper.insertSelective(employee);
    }

    @Override
    public boolean checkEmpName(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        List<Employee> employees = mapper.selectByExample(example);
        return employees.size()>0;
    }

    @Override
    public Employee findEmployee(int id) {
        return mapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateEmp(Employee employee) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdEqualTo(employee.getEmpId());
        mapper.updateByExampleSelective(employee,example);
    }

    @Override
    public void delEmp(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        mapper.deleteByExample(example);
    }
}
