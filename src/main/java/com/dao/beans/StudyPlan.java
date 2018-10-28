package com.dao.beans;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class StudyPlan {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _study_plan._id
     *
     * @mbg.generated
     */
    private Integer id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _study_plan._content
     *
     * @mbg.generated
     */
    private String content;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _study_plan._operate_date
     *
     * @mbg.generated
     */
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date operateDate;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _study_plan._id
     *
     * @return the value of _study_plan._id
     *
     * @mbg.generated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _study_plan._id
     *
     * @param id the value for _study_plan._id
     *
     * @mbg.generated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _study_plan._content
     *
     * @return the value of _study_plan._content
     *
     * @mbg.generated
     */
    public String getContent() {
        return content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _study_plan._content
     *
     * @param content the value for _study_plan._content
     *
     * @mbg.generated
     */
    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _study_plan._operate_date
     *
     * @return the value of _study_plan._operate_date
     *
     * @mbg.generated
     */
    public Date getOperateDate() {
        return operateDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _study_plan._operate_date
     *
     * @param operateDate the value for _study_plan._operate_date
     *
     * @mbg.generated
     */
    public void setOperateDate(Date operateDate) {
        this.operateDate = operateDate;
    }
}