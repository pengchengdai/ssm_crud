package com.dpc.service;

import com.dpc.domain.Employee;

import java.util.List;

/**
 * @author dpc
 * @create YEAR−{YEAR}-YEAR−{MONTH}-11 13:58
 */
public interface EmployeeService {
    List<Employee> findAll();

    void saveEmp(Employee employee);

    boolean checkEmpName(String empName);

    Employee findEmployee(int id);

    void updateEmp(Employee employee);

    void delEmp(List<Integer> ids);
}
