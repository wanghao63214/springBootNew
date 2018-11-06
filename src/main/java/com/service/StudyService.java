package com.service;

import com.dao.beans.*;
import com.dao.mapper.StudyPlanDetailMapper;
import com.dao.mapper.StudyPlanDetailMapper_Manual;
import com.dao.mapper.StudyPlanMapper;
import com.dao.mapper.StudyPlanMapper_Manual;
import com.github.pagehelper.PageHelper;
import com.utils.FileUtils;
import com.utils.RedisUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.InputStream;
import java.util.*;

/**
 * 角色的service层
 *
 * @author zhangge
 */
@Service
public class StudyService {

    @Autowired
    private StudyPlanMapper studyPlanMapper;

    @Autowired
    private StudyPlanMapper_Manual StudyPlanMapper_Manual;

    @Autowired
    private StudyPlanDetailMapper studyPlanDetailMapper;

    @Autowired
    private StudyPlanDetailMapper_Manual studyPlanDetailMapper_Manual;

    @Autowired
    private RedisUtils redisUtils;

    /**
     * wh
     *
     * @return 角色查询
     */
    public Map<String, Object> studyPlanQuery(StudyPlan studyPlan, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            StudyPlanExample studyPlanExample = new StudyPlanExample();
            map.put("total", studyPlanMapper.countByExample(studyPlanExample));
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = StudyPlanMapper_Manual.selectListMap(studyPlanExample);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }
    /**
     * wh
     */
    public Map<String, Object> subStudyPlanQuery(StudyPlanDetail studyPlanDetail, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            StudyPlanDetailExample studyPlanDetailExample = new StudyPlanDetailExample();
            StudyPlanDetailExample.Criteria criteria = studyPlanDetailExample.createCriteria();
            if (!(null == studyPlanDetail.getStudyPlanId() ||  studyPlanDetail.getStudyPlanId().equals(""))) {
                criteria.andStudyPlanIdEqualTo(studyPlanDetail.getStudyPlanId());
            }
            map.put("total", studyPlanDetailMapper.countByExample(studyPlanDetailExample));
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = studyPlanDetailMapper_Manual.selectListMap(studyPlanDetailExample);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }

    public void insert(StudyPlan studyPlan){
        try{
            studyPlanMapper.insert(studyPlan);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public void dialResultRedisSave(String choosenName) {
        String temp = redisUtils.getString("choosenName");

        if (null == temp || temp.length() > 300) {
            redisUtils.saveString("choosenName", choosenName);
        } else {
            redisUtils.saveString("choosenName", temp + "<br/>" + choosenName);
        }
    }

    public String dialResultRedisQuery(String key){
        return redisUtils.getString(key);
    }

    /**
     * 上传文件
     * @param file
     * @param studyPlan
     * @throws Exception
     */
    public void uplaodFile(MultipartFile file, StudyPlan studyPlan) throws  Exception{
        try {
            if(file == null){
                throw new Exception("文件不能为空");
            }
            String realPath = "/root/download/" + studyPlan.getId() + "/";//默认linux系统
            String operateSystem = System.getProperty("os.name");
            // 设置文件路径
            if (operateSystem.toLowerCase().startsWith("win")) {
                realPath = "D:\\testFolder\\" + studyPlan.getId() + "\\";
            }
            String contentType = file.getContentType();
            String fileName = file.getOriginalFilename();
            FileUtils.uploadFile(file.getBytes(), realPath, fileName);
            //如果成功保存路径到数据库
            studyPlan.setAttachmentUrl(fileName);
            studyPlanMapper.updateByPrimaryKeySelective(studyPlan);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
    }
    /**
     * 处理上传execel文件
     * @param file
     * @param studyPlan
     * @throws Exception
     */
    public void batchImport(MultipartFile file, StudyPlan studyPlan) throws  Exception{
        String fileName = file.getOriginalFilename();
        boolean notNull = false;
        List<Account> userList = new ArrayList<Account>();
        if (!fileName.matches("^.+\\.(?i)(xls)$") && !fileName.matches("^.+\\.(?i)(xlsx)$")) {
            throw new Exception("上传文件格式不正确");
        }
        boolean isExcel2003 = true;
        if (fileName.matches("^.+\\.(?i)(xlsx)$")) {
            isExcel2003 = false;
        }
        InputStream is = file.getInputStream();
        Workbook wb = null;
        if (isExcel2003) {
            wb = new HSSFWorkbook(is);
        } else {
            wb = new XSSFWorkbook(is);
        }
        Sheet sheet = wb.getSheetAt(0);
        if(sheet!=null){
            notNull = true;
        }
        Account user;
        for (int r = 1; r <= sheet.getLastRowNum(); r++) {
            Row row = sheet.getRow(r);
            if (row == null){
                continue;
            }
            user = new Account();
            if( row.getCell(0).getCellType() !=1){
                throw new Exception("导入失败(第"+(r+1)+"行,姓名请设为文本格式)");
            }
            String name = row.getCell(0).getStringCellValue();
            if(name == null || name.isEmpty()){
                throw new Exception("导入失败(第"+(r+1)+"行,姓名未填写)");
            }
            row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
            String phone = row.getCell(1).getStringCellValue();
            if(phone==null || phone.isEmpty()){
                throw new Exception("导入失败(第"+(r+1)+"行,电话未填写)");
            }
            String add = row.getCell(2).getStringCellValue();
            if(add==null){
                throw new Exception("导入失败(第"+(r+1)+"行,不存在此单位或单位未填写)");
            }

            Date date;
            if(row.getCell(3).getCellType() !=0){
                throw new Exception("导入失败(第"+(r+1)+"行,入职日期格式不正确或未填写)");
            }else{
                date = row.getCell(3).getDateCellValue();
            }
            String des = row.getCell(4).getStringCellValue();
            user.setUsername(name);
            userList.add(user);
        }
    /*    for (User userResord : userList) {
            String name = userResord.getName();
            int cnt = userMapper.selectByName(name);
            if (cnt == 0) {
                userMapper.addUser(userResord);
                System.out.println(" 插入 "+userResord);
            } else {
                userMapper.updateUserByName(userResord);
                System.out.println(" 更新 "+userResord);
            }
        }*/
    }
}
