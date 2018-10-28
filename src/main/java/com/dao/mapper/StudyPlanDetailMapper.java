package com.dao.mapper;

import com.dao.beans.StudyPlanDetail;
import com.dao.beans.StudyPlanDetailExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface StudyPlanDetailMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    long countByExample(StudyPlanDetailExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    int deleteByExample(StudyPlanDetailExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    int insert(StudyPlanDetail record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    int insertSelective(StudyPlanDetail record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    List<StudyPlanDetail> selectByExample(StudyPlanDetailExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    StudyPlanDetail selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    int updateByExampleSelective(@Param("record") StudyPlanDetail record, @Param("example") StudyPlanDetailExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    int updateByExample(@Param("record") StudyPlanDetail record, @Param("example") StudyPlanDetailExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    int updateByPrimaryKeySelective(StudyPlanDetail record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table _study_plan_detail
     *
     * @mbg.generated
     */
    int updateByPrimaryKey(StudyPlanDetail record);
}