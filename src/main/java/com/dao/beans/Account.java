package com.dao.beans;

import java.util.Date;

public class Account {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._id
     *
     * @mbg.generated
     */
    private Integer id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._userName
     *
     * @mbg.generated
     */
    private String username;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._agId
     *
     * @mbg.generated
     */
    private Integer agid;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._pwd
     *
     * @mbg.generated
     */
    private String pwd;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._roleId
     *
     * @mbg.generated
     */
    private Integer roleid;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._salt
     *
     * @mbg.generated
     */
    private String salt;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._platType
     *
     * @mbg.generated
     */
    private Integer plattype;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._userEmail
     *
     * @mbg.generated
     */
    private String useremail;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._userMobile
     *
     * @mbg.generated
     */
    private String usermobile;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._loginCount
     *
     * @mbg.generated
     */
    private Integer logincount;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._anotherName
     *
     * @mbg.generated
     */
    private String anothername;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._userStatus
     *
     * @mbg.generated
     */
    private Integer userstatus;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._lastLogin
     *
     * @mbg.generated
     */
    private Date lastlogin;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._createTime
     *
     * @mbg.generated
     */
    private Date createtime;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._Type
     *
     * @mbg.generated
     */
    private Integer type;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._optUserId
     *
     * @mbg.generated
     */
    private String optuserid;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._realName
     *
     * @mbg.generated
     */
    private String realname;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account._remark
     *
     * @mbg.generated
     */
    private String remark;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column _account.app_poi_code
     *
     * @mbg.generated
     */
    private String appPoiCode;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._id
     *
     * @return the value of _account._id
     *
     * @mbg.generated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._id
     *
     * @param id the value for _account._id
     *
     * @mbg.generated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._userName
     *
     * @return the value of _account._userName
     *
     * @mbg.generated
     */
    public String getUsername() {
        return username;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._userName
     *
     * @param username the value for _account._userName
     *
     * @mbg.generated
     */
    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._agId
     *
     * @return the value of _account._agId
     *
     * @mbg.generated
     */
    public Integer getAgid() {
        return agid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._agId
     *
     * @param agid the value for _account._agId
     *
     * @mbg.generated
     */
    public void setAgid(Integer agid) {
        this.agid = agid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._pwd
     *
     * @return the value of _account._pwd
     *
     * @mbg.generated
     */
    public String getPwd() {
        return pwd;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._pwd
     *
     * @param pwd the value for _account._pwd
     *
     * @mbg.generated
     */
    public void setPwd(String pwd) {
        this.pwd = pwd == null ? null : pwd.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._roleId
     *
     * @return the value of _account._roleId
     *
     * @mbg.generated
     */
    public Integer getRoleid() {
        return roleid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._roleId
     *
     * @param roleid the value for _account._roleId
     *
     * @mbg.generated
     */
    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._salt
     *
     * @return the value of _account._salt
     *
     * @mbg.generated
     */
    public String getSalt() {
        return salt;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._salt
     *
     * @param salt the value for _account._salt
     *
     * @mbg.generated
     */
    public void setSalt(String salt) {
        this.salt = salt == null ? null : salt.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._platType
     *
     * @return the value of _account._platType
     *
     * @mbg.generated
     */
    public Integer getPlattype() {
        return plattype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._platType
     *
     * @param plattype the value for _account._platType
     *
     * @mbg.generated
     */
    public void setPlattype(Integer plattype) {
        this.plattype = plattype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._userEmail
     *
     * @return the value of _account._userEmail
     *
     * @mbg.generated
     */
    public String getUseremail() {
        return useremail;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._userEmail
     *
     * @param useremail the value for _account._userEmail
     *
     * @mbg.generated
     */
    public void setUseremail(String useremail) {
        this.useremail = useremail == null ? null : useremail.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._userMobile
     *
     * @return the value of _account._userMobile
     *
     * @mbg.generated
     */
    public String getUsermobile() {
        return usermobile;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._userMobile
     *
     * @param usermobile the value for _account._userMobile
     *
     * @mbg.generated
     */
    public void setUsermobile(String usermobile) {
        this.usermobile = usermobile == null ? null : usermobile.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._loginCount
     *
     * @return the value of _account._loginCount
     *
     * @mbg.generated
     */
    public Integer getLogincount() {
        return logincount;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._loginCount
     *
     * @param logincount the value for _account._loginCount
     *
     * @mbg.generated
     */
    public void setLogincount(Integer logincount) {
        this.logincount = logincount;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._anotherName
     *
     * @return the value of _account._anotherName
     *
     * @mbg.generated
     */
    public String getAnothername() {
        return anothername;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._anotherName
     *
     * @param anothername the value for _account._anotherName
     *
     * @mbg.generated
     */
    public void setAnothername(String anothername) {
        this.anothername = anothername == null ? null : anothername.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._userStatus
     *
     * @return the value of _account._userStatus
     *
     * @mbg.generated
     */
    public Integer getUserstatus() {
        return userstatus;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._userStatus
     *
     * @param userstatus the value for _account._userStatus
     *
     * @mbg.generated
     */
    public void setUserstatus(Integer userstatus) {
        this.userstatus = userstatus;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._lastLogin
     *
     * @return the value of _account._lastLogin
     *
     * @mbg.generated
     */
    public Date getLastlogin() {
        return lastlogin;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._lastLogin
     *
     * @param lastlogin the value for _account._lastLogin
     *
     * @mbg.generated
     */
    public void setLastlogin(Date lastlogin) {
        this.lastlogin = lastlogin;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._createTime
     *
     * @return the value of _account._createTime
     *
     * @mbg.generated
     */
    public Date getCreatetime() {
        return createtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._createTime
     *
     * @param createtime the value for _account._createTime
     *
     * @mbg.generated
     */
    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._Type
     *
     * @return the value of _account._Type
     *
     * @mbg.generated
     */
    public Integer getType() {
        return type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._Type
     *
     * @param type the value for _account._Type
     *
     * @mbg.generated
     */
    public void setType(Integer type) {
        this.type = type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._optUserId
     *
     * @return the value of _account._optUserId
     *
     * @mbg.generated
     */
    public String getOptuserid() {
        return optuserid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._optUserId
     *
     * @param optuserid the value for _account._optUserId
     *
     * @mbg.generated
     */
    public void setOptuserid(String optuserid) {
        this.optuserid = optuserid == null ? null : optuserid.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._realName
     *
     * @return the value of _account._realName
     *
     * @mbg.generated
     */
    public String getRealname() {
        return realname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._realName
     *
     * @param realname the value for _account._realName
     *
     * @mbg.generated
     */
    public void setRealname(String realname) {
        this.realname = realname == null ? null : realname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account._remark
     *
     * @return the value of _account._remark
     *
     * @mbg.generated
     */
    public String getRemark() {
        return remark;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account._remark
     *
     * @param remark the value for _account._remark
     *
     * @mbg.generated
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column _account.app_poi_code
     *
     * @return the value of _account.app_poi_code
     *
     * @mbg.generated
     */
    public String getAppPoiCode() {
        return appPoiCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column _account.app_poi_code
     *
     * @param appPoiCode the value for _account.app_poi_code
     *
     * @mbg.generated
     */
    public void setAppPoiCode(String appPoiCode) {
        this.appPoiCode = appPoiCode == null ? null : appPoiCode.trim();
    }
}