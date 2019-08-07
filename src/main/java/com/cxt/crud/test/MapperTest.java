import com.cxt.crud.bean.Department;
import com.cxt.crud.bean.Employee;
import com.cxt.crud.bean.EmployeeExample;
import com.cxt.crud.dao.DepartmentMapper;
import com.cxt.crud.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/**
 * Spring的单元测试
 */
//测试DAO
    //RunWith单元测试是指定spring 的单元测试模块
    //直接autowire
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Test
    public void testCRUD(){
    //    ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
     //   DepartmentMapper departmentMapper = app.getBean(DepartmentMapper.class);
     //   departmentMapper.insertSelective(new Department(null,"飞行部")) ;
        // 员工插入
       // employeeMapper.insertSelective(new Employee(null,"jack","M","92485448@qq.com",2));
    /*    for(int i = 0;i < 1000 ;i++){
            String uid = UUID.randomUUID().toString().substring(0,5) + i;
            employeeMapper.insertSelective(new Employee(null,uid,"M",uid + "@163.com",1));
        }
        System.out.println("批量完成");
    */
    Employee employee = new Employee();
    EmployeeExample example = new EmployeeExample();
    example.setOrderByClause("emp_id ASC");
    List<Employee> list = employeeMapper.selectByExampleWithDept(example);
    for(Employee emp:list)
    System.out.println(emp);

    }
}
