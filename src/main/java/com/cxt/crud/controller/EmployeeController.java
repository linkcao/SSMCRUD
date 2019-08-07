package com.cxt.crud.controller;

import com.cxt.crud.bean.Employee;
import com.cxt.crud.bean.Msg;
import com.cxt.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService; //service层查出员工数据
    /**
     * 导入jackson包
     * 处理员工crud请求
     */
    //将返回的数据转换成JSON
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue = "1")Integer pn){
        /**
         *引入PageHelper 分页插件
         *传入页码也每页的大小
         */
        PageHelper.startPage(pn,5);
        //紧接着的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo 包装查询后的结果 ， 之主要将pageInfo交给页面
        PageInfo page = new PageInfo(emps,5);//传入连续显示的页数
        //PageInfo分装了详细的信息，包括查询出来的信息
        //交给页面的详细信息
        return Msg.success().add("pageInfo",page);


    }

    /**
     *保存用户
     * 1、支持JSR303校验
     * 2、导入Hibernate-Validator
     *
     * @Valid校验  BindingResult 绑定校验结果
     * @param employee
     * @return
     */
    @RequestMapping(value="/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){  //将提交的信息自动封装成对象
        if(result.hasErrors()){
            //校验失败 返回失败在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError:errors){
//                System.out.println("错误的字段名"+fieldError.getField());
//                System.out.println("错误的信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            //返回错误的信息
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkemp(@RequestParam(value = "empName" ) String empName){

        //判断用户名是否为合法的用户名
        String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6到16位数字字母组合或2到5中文");

        };
        boolean canUse = employeeService.checkemp(empName);
        return canUse?Msg.success():Msg.fail().add("va_msg","用户名不可用");
    }

    /**
     * 查询员工数据
     *
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") int empId){
        Employee employee = employeeService.getEmp(empId);
        return Msg.success().add("emp",employee);
    }

    /**
     * 如果之间通过Ajax的PUT请求 封装的数据会无法封装对象 通过wbm.xml设置拦截器 完成
     *
     * 更新员工
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}" ,method = RequestMethod.PUT)
    public Msg updataEmp(Employee employee){
        //员工更新按钮
      //  System.out.println(employee);
        employeeService.updataEmp(employee);
        return Msg.success();
    }

    /**
     * 如果之间通过Ajax的PUT请求 封装的数据会无法封装对象 通过wbm.xml设置拦截器 完成
     * 删除员工
     * 批量删除1-2-3
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empIds}" ,method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("empIds") String empIds){

        List<Integer> del_ids = new ArrayList<>();
        if(empIds.contains("-")){
            String[] str_ids =empIds.split("-");
            for(String string:str_ids){
               del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBath(del_ids);
            return Msg.success();
        }else{
            employeeService.deleteEmp(Integer.parseInt(empIds));
            return Msg.success();
        }
    }

  //  @RequestMapping("/emps")
    public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn,
                          Model model){
        /**
         *引入PageHelper 分页插件
         *传入页码也每页的大小
         */
        PageHelper.startPage(pn,5);
        //紧接着的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo 包装查询后的结果 ， 之主要将pageInfo交给页面
        PageInfo page = new PageInfo(emps,5);//传入连续显示的页数
        //PageInfo分装了详细的信息，包括查询出来的信息
        //交给页面的详细信息
        model.addAttribute("pageInfo",page);

        return "list";
    }

}
