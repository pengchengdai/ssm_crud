package com.dpc.controller;

import com.dpc.domain.CommonResponseMsg;
import com.dpc.domain.Employee;
import com.dpc.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author dpc
 * @create YEAR−{YEAR}-YEAR−{MONTH}-11 13:55
 */
@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    @RequestMapping(value = "/delEmp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    //用于单条数据或多条数据的删除
    public CommonResponseMsg<?> updateEmp(@PathVariable("ids") String ids){
        /*
        单条记录的删除：ids=1
        多条记录的删除：ids=1-2-3-4
         */
        System.out.println(ids);
        String[] idArr = ids.split("-");
        List<Integer> list = new ArrayList<>();
        if(idArr.length==1){
            list.add(Integer.parseInt(idArr[0]));
        }else{
            for (int i=0;i<idArr.length;i++) {
                list.add(Integer.parseInt(idArr[i]));
            }
        }
        employeeService.delEmp(list);
        CommonResponseMsg<?> crm = new CommonResponseMsg<>();
        return crm.success();
    }


    @RequestMapping(value = "/updateEmp/{empId}",method = RequestMethod.PUT)
    //@PutMapping("/updateEmp/{empId}")
    @ResponseBody
    public CommonResponseMsg<?> updateEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        CommonResponseMsg<Employee> crm = new CommonResponseMsg<>();
        crm.success();
        return crm;
    }

    @RequestMapping(value = "/findEmpById/{id}",method = RequestMethod.GET)
    @ResponseBody
    public CommonResponseMsg<Employee> findEmpById(@PathVariable("id") Integer empId){
        Employee employee = employeeService.findEmployee(empId);
        CommonResponseMsg<Employee> crm = new CommonResponseMsg<>();
        crm.success();
        return crm.append("employee",employee);
    }



    @RequestMapping("/findEmpByName")
    @ResponseBody
    public CommonResponseMsg<String> findEmpByName(@RequestParam("eName") String empName){
        CommonResponseMsg<String> crm = new CommonResponseMsg<>();
        //校验用户名格式
        String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,8})$";
        if(!empName.matches(regex)){
            crm.fail().append("error_msg","用户名为6~16位英文或2~8位汉字!!");
            return crm;
        }

        //校验用户名是否存在
        boolean bl = employeeService.checkEmpName(empName);
        if(bl){
            crm.fail().append("error_msg","用户名以存在!!");
        }else{
            crm.success();
        }
        return crm;
    }


    @RequestMapping("/empsAjax")
    @ResponseBody//需要导入jackson-databind
    //返回通用的响应
    public CommonResponseMsg<PageInfo<Employee>> empsAjax(@RequestParam(value = "pn",defaultValue = "1") int pn){
        //开始分页
        PageHelper.startPage(pn,5);
        //后面的查询操作就是1个分页操作
        List<Employee> emps =  employeeService.findAll();
        //将分页结果封装为1个PageInfo,并设置关联的导航页
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(emps,5);
        CommonResponseMsg<PageInfo<Employee>> crm = new CommonResponseMsg<>();
        crm = crm.success().append("pageInfo",pageInfo);
        return crm;
    }

    @RequestMapping(value = "/saveEmp",method = RequestMethod.POST)
    @ResponseBody
    //@Valid进行数据校验，BindingResult数据校验结果
    public CommonResponseMsg<?> saveEmp(@Valid Employee employee, BindingResult result){
        System.out.println("=================="+result);
        if(result.hasErrors()){//如果有错误
            Map<String,String> map = new HashMap<>();
            //获取校验字段的所有错误
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                String field = fieldError.getField();//校验字段
                String message = fieldError.getDefaultMessage();//错误信息
                map.put(field,message);
            }
            CommonResponseMsg<?> crm = new CommonResponseMsg().fail().append("errors",map);
            return crm;

        }else{
            employeeService.saveEmp(employee);
            CommonResponseMsg<?> crm = new CommonResponseMsg().success();
            return crm;
        }
    }

    //@RequestMapping("/empsForAjax")
    //@ResponseBody//需要导入jackson-databind
    public  PageInfo empsForAjax(@RequestParam(value = "pn",defaultValue = "1") int pn){
        System.out.println(pn);
        //开始分页
        PageHelper.startPage(pn,5);
        //后面的查询操作就是1个分页操作
        List<Employee> emps =  employeeService.findAll();
        //将分页结果封装为1个PageInfo,并设置关联的导航页
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(emps,5);
        return pageInfo;
    }

    //@RequestMapping("/emps")
    public String emps(@RequestParam(value = "pn",defaultValue = "1") int pn, Model model){
        //开始分页
        PageHelper.startPage(pn,5);
        //后面的查询操作就是1个分页操作
        List<Employee> emps =  employeeService.findAll();
        //将分页结果封装为1个PageInfo,并设置关联的导航页
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(emps,5);
        //将pageInfo添加到request域中
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }


}
