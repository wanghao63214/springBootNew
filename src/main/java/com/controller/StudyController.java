package com.controller;

import com.utils.FileUtils;
import com.common.exception.manage.Message;
import com.common.utils.DateUtils;
import com.dao.beans.Account;
import com.dao.beans.StudyPlan;
import com.dao.beans.StudyPlanDetail;
import com.service.StudyService;
import com.utils.ShiroUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/study/")
public class StudyController extends BaseController {

    @Autowired
    private StudyService studyService;

    @RequestMapping("dialPage")
    public String dialPage(Model model) {
        Account user = ShiroUtils.getLoginUser();
        model.addAttribute("userName", user.getUsername());
        return "study/dial";
    }

    @RequestMapping("studyPlan")
    public String studyPlan(Model model) {
        Account user = ShiroUtils.getLoginUser();
        model.addAttribute("userName", user.getUsername());
        return "study/studyPlan";
    }

    @RequestMapping("uploadPage")
    public String uploadPage(Model model, String id) {
        model.addAttribute("id", id);
        return "study/upload";
    }

    @RequestMapping("uploadExcelPage")
    public String uploadExcelPage(Model model) {
        return "study/uploadExcel";
    }

    @RequestMapping("studyPlanAdd")
    public String studyPlanAdd(Model model) {
        return "study/studyPlanAdd";
    }

    @RequestMapping(value = "studyPlanQuery" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, Object> studyPlanQuery(StudyPlan studyPlan, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            map = studyService.studyPlanQuery(studyPlan, limit, offset);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "subStudyPlanQuery" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, Object> subStudyPlanQuery(StudyPlanDetail studyPlanDetail, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            map = studyService.subStudyPlanQuery(studyPlanDetail, limit, offset);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "insert" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public Message insert(StudyPlan studyPlan) {
        Message ms = new Message();
        try {
            studyService.insert(studyPlan);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ms;
    }

    @RequestMapping(value = "dialResultRedisSave", produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, String> dialResultRedisSave(String choosenName) {
        //Message ms = new Message();
        Map<String, String> result = new HashMap();
        try {
            choosenName = DateUtils.getDateTime() + "  " + choosenName;
            studyService.dialResultRedisSave(choosenName);
            result.put("msg", studyService.dialResultRedisQuery("choosenName"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "dialResultRedisQuery", produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, String> dialResultRedisQuery(String choosenName) {
        //Message ms = new Message();
        Map<String, String> result = new HashMap();
        try {
            result.put("msg", studyService.dialResultRedisQuery("choosenName"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "downloadFile", produces = JSON + CHARSET)
    public Map<String, String> downloadFile(StudyPlan studyplan) {
        // 设置文件名，根据业务需要替换成要下载的文件名
        String fileName = studyplan.getAttachmentUrl();//
        String realPath = realPath = "/root/download/" + studyplan.getId() + "/";//默认linux系统
        if (fileName != null) {
            String operateSystem = System.getProperty("os.name");
            // 设置文件路径
            if (operateSystem.toLowerCase().startsWith("win")) {
                realPath = "D:\\testFolder\\" + studyplan.getId() + "\\";
            }
            File file = new File(realPath, fileName);
            System.out.println(realPath + fileName);
            if (file.exists()) {
                System.out.println("123file address exist 123");
                response.setContentType("application/force-download");
                // 设置强制下载不打开
                try {
                    fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                response.addHeader("Content-Disposition", "attachment;fileName=" + fileName);
                // 设置文件名
                byte[] buffer = new byte[1024];
                FileInputStream fis = null;
                BufferedInputStream bis = null;
                try {
                    fis = new FileInputStream(file);
                    bis = new BufferedInputStream(fis);
                    OutputStream os = response.getOutputStream();
                    int i = bis.read(buffer);
                    while (i != -1) {
                        os.write(buffer, 0, i);
                        i = bis.read(buffer);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (bis != null) {
                        try {
                            bis.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    if (fis != null) {
                        try {
                            fis.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            } else {
                System.out.print("file address no exist");
            }
        }
        return null;

    }

    @RequestMapping(value = "uploadFile", produces = JSON + CHARSET)
    @ResponseBody
    public Message uploadFile(@RequestParam("file") MultipartFile file, StudyPlan studyPlan) {
        Message ms = new Message();
        try {
            studyService.uplaodFile(file, studyPlan);
        } catch (Exception e) {
            ms.setCode(2);
            e.printStackTrace();
        }
        return ms;
    }
    @RequestMapping(value = "uploadExcel", produces = JSON + CHARSET)
    @ResponseBody
    public Message uploadExcel(@RequestParam("file") MultipartFile file) {
        Message ms = new Message();
        try {
            studyService.batchImport(file);
        } catch (Exception e) {
            ms.setCode(2);
            e.printStackTrace();
        }
        return ms;
    }
}
