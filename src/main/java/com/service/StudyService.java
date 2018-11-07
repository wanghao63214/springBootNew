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
            if (!(null == studyPlanDetail.getStudyPlanId() || studyPlanDetail.getStudyPlanId().equals(""))) {
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

    public void insert(StudyPlan studyPlan) {
        try {
            studyPlanMapper.insert(studyPlan);
        } catch (Exception e) {
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

    public String dialResultRedisQuery(String key) {
        return redisUtils.getString(key);
    }

    /**
     * 上传文件
     *
     * @param file
     * @param studyPlan
     * @throws Exception
     */
    public void uplaodFile(MultipartFile file, StudyPlan studyPlan) throws Exception {
        try {
            if (file == null) {
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
     *
     * @param file
     * @throws Exception
     */
    public void batchImport(MultipartFile file) throws Exception {
        String fileName = null;
        List<StudyPlan> studyPlanList = null;
        try {
            fileName = file.getOriginalFilename();
            studyPlanList = new ArrayList<StudyPlan>();
            if (!fileName.matches("^.+\\.(?i)(xls)$") && !fileName.matches("^.+\\.(?i)(xlsx)$")) {
                throw new Exception("上传文件格式不正确");
            }
            boolean isExcel2003 = fileName.matches("^.+\\.(?i)(xlsx)$") ? false : true;
            InputStream is = file.getInputStream();
            Workbook wb = (isExcel2003 == true) ? new HSSFWorkbook(is) : new XSSFWorkbook(is);
            Sheet sheet = wb.getSheetAt(0);
            if (null == sheet) {
                throw new Exception("Excel文件出错");
            }
            StudyPlan studyPlan;
            //跳过表头标题，循环sheet中数据
            for (int r = 1; r <= sheet.getLastRowNum(); r++) {
                Row row = sheet.getRow(r);
                if (row == null) continue;
                studyPlan = new StudyPlan();
                //判断是否有未填写的并保存到StudyPlan中
                inspectorAndAdd(r, row, studyPlan);
                //添加到StudyPlan集合中
                studyPlanList.add(studyPlan);
            }
            //批量持久化
            StudyPlanMapper_Manual.batchInsert(studyPlanList);
        } catch (Exception e) {
            throw new Exception(e);
        }
    }

    /**
     * 检查excel 中每个cell 和 添加到pojo
     *
     * @param r
     * @throws Exception
     */
    private void inspectorAndAdd(int r, Row row, StudyPlan studyPlan) throws Exception {
        String[] strArray = {"content", "operateDate", "url"};
        Cell cell = null;
        for(int i = 0; i<row.getLastCellNum();i++){
            cell = row.getCell(i);
            //判断是否为空
            if (null == cell || cell.getCellType() == Cell.CELL_TYPE_BLANK || cell.toString().trim().isEmpty()) {
                throw new Exception("导入失败(第" + (r + 1) + "行)" + strArray[i] + "为空");
            }
            //每一列的判断
            switch (i) {
                case 0:
                    cell.setCellType(cell.CELL_TYPE_STRING);
                    studyPlan.setContent(cell.getStringCellValue().trim());
                    break;
                case 1:
                    if (cell.getCellType() != cell.CELL_TYPE_NUMERIC) {
                        throw new Exception("导入失败(第" + (r + 1) + "行,)" + strArray[i] + "格式错误");
                    }
                    studyPlan.setOperateDate(cell.getDateCellValue());
                    break;
                case 2:
                    cell.setCellType(cell.CELL_TYPE_STRING);
                    studyPlan.setAttachmentUrl(cell.getStringCellValue().trim());
                    break;
            }
        }
    }

}
