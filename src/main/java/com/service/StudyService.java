package com.service;

import com.dao.beans.*;
import com.dao.mapper.StudyPlanDetailMapper;
import com.dao.mapper.StudyPlanMapper;
import com.dao.mapper.StudyPlanMapper_Manual;
import com.github.pagehelper.PageHelper;
import com.utils.ExcelUtils;
import com.utils.FileUtils;
import com.utils.LambdaUtils;
import com.utils.RedisUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.util.*;

/**
 * 角色的service层
 *
 * @author zhangge
 */
@Service
public class StudyService implements ExcelUtils.Inspector<StudyPlan> {

    @Autowired
    private StudyPlanMapper studyPlanMapper;

    @Autowired
    private StudyPlanMapper_Manual StudyPlanMapper_Manual;

    @Autowired
    private StudyPlanDetailMapper studyPlanDetailMapper;

    @Autowired
    private RedisUtils redisUtils;

    @Value("${spring.servlet.multipart.max-file-size}")
    private String max_file_size;

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
            List<StudyPlanDetail> list = studyPlanDetailMapper.selectByExample(studyPlanDetailExample);
            map.put("rows", new LambdaUtils<StudyPlanDetail>().ListObjectToListMap(list));
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
        String extName = null;
        //允许上传的文件类型
        String fileType = "jpg,jpeg,gif,png,bmp";
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
            String fileName = file.getOriginalFilename();
            //判断是否为允许上传的文件类型
            //获取文件后缀名
            extName = fileName.substring(fileName.indexOf(".") + 1).toLowerCase().trim();
            if (!Arrays.<String>asList(fileType.split(",")).contains(extName)) {
                throw new Exception("文件类型不正确");
            }
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
        List<StudyPlan> studyPlanList = null;
        StudyPlan studyPlan = null;
        try {
            studyPlanList = new ArrayList<>();
            ExcelUtils excelUtils = new ExcelUtils<StudyPlan>();
            int titleRowNum = 1;
            excelUtils.batchImport(file, titleRowNum, studyPlanList, studyPlan, this);
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
    public void inspectorAndAdd(int titleRowNum, int r, Row row, int columnNum, StudyPlan studyPlan, String[] strArray, List<StudyPlan> list) throws Exception {
        Cell cell = null;
        studyPlan = new StudyPlan();
        for (int i = 0; i < columnNum; i++) {
            cell = row.getCell(i);
            if (r == titleRowNum) {//判断是第一行，标题行
                inspectNull(cell, r, i, null);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                strArray[i] = cell.getStringCellValue();
            } else {//非标题行的检验
                //判断是否为空
                inspectNull(cell, r, i, strArray[i]);
                //每一列的判断
                switch (i) {
                    case 0:
                        cell.setCellType(cell.CELL_TYPE_STRING);
                        studyPlan.setContent(cell.getStringCellValue().trim());
                        break;
                    case 1:
                        if (cell.getCellType() != cell.CELL_TYPE_NUMERIC) {
                            throw new Exception("导入失败(第" + (r + 2) + "行,)" + strArray[i] + "格式错误");
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
        if (r != titleRowNum) {
            list.add(studyPlan);
        }
    }

    private void inspectNull(Cell cell, int r, int i, String str) throws Exception {
        if (null == cell || cell.toString().trim().isEmpty()) {
            if (null == str) {
                throw new Exception("导入失败：第" + (r + 1) + "行、 第" + (i + 1) + "列标题为空");
            } else {
                throw new Exception("导入失败：第" + (r + 1) + "行、 第" + (i + 1) + "列(" + str + ")为空");
            }
        }
    }
}
