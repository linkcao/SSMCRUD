package com.cxt.crud.service;

import com.cxt.crud.bean.Employee;
import com.cxt.crud.bean.EmployeeExample;
import com.cxt.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
//业务逻辑组件
@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    //查询所有员工 这 不是一个分页查询
    public List<Employee> getAll() {
        EmployeeExample example = new EmployeeExample();
        example.setOrderByClause("emp_id ASC");
        return employeeMapper.selectByExampleWithDept(example);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }
//检验用户名是否可用
    public boolean checkemp(String empName) {
        //按照条件找出符合条件的用户数
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria =  employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    public Employee getEmp(int empId){
        return employeeMapper.selectByPrimaryKey(empId);
    }

    public void updataEmp(Employee employee) {
        //按照主键有选择的更新
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(int empId) {
        employeeMapper.deleteByPrimaryKey(empId);
    }

    public void deleteBath(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete form xx where id in(1,2,3);
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
