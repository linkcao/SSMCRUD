package com.cxt.crud.dao;

import com.cxt.crud.bean.Department;
import com.cxt.crud.bean.DepartmentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DepartmentMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    long countByExample(DepartmentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    int deleteByExample(DepartmentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    int deleteByPrimaryKey(Integer deptId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    int insert(Department record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    int insertSelective(Department record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    List<Department> selectByExample(DepartmentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    Department selectByPrimaryKey(Integer deptId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    int updateByExampleSelective(@Param("record") Department record, @Param("example") DepartmentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    int updateByExample(@Param("record") Department record, @Param("example") DepartmentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    int updateByPrimaryKeySelective(Department record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tnp_dept
     *
     * @mbg.generated Fri Aug 02 11:38:25 GMT+08:00 2019
     */
    int updateByPrimaryKey(Department record);
}