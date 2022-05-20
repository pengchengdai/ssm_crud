package com.dpc.service.impl;

import com.dpc.dao.DepartmentMapper;
import com.dpc.domain.Department;
import com.dpc.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author dpc
 * @create YEAR−{YEAR}-YEAR−{MONTH}-14 23:02
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    private DepartmentMapper mapper;

    @Override
    public List<Department> findAll() {
        List<Department> departments = mapper.selectByExample(null);
        return departments;
    }
}
