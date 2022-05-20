package com.dpc.controller;

import com.dpc.domain.CommonResponseMsg;
import com.dpc.domain.Department;
import com.dpc.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author dpc
 * @create YEAR−{YEAR}-YEAR−{MONTH}-14 22:59
 */
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService service;


    @RequestMapping("/depts")
    @ResponseBody
    public CommonResponseMsg<List<Department>> findDepts(){
        List<Department> list = service.findAll();
        CommonResponseMsg<List<Department>> crm = new CommonResponseMsg();
        return crm.success().append("list",list);
    }
}
