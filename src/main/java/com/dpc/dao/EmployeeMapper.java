package com.dpc.dao;

import com.dpc.domain.Employee;
import com.dpc.domain.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee row);

    int insertSelective(Employee row);

    List<Employee> selectByExample(EmployeeExample example);

    Employee selectByPrimaryKey(Integer empId);

    List<Employee> selectByExampleWithDept(EmployeeExample example);
    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("row") Employee row, @Param("example") EmployeeExample example);

    int updateByExample(@Param("row") Employee row, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee row);

    int updateByPrimaryKey(Employee row);
}