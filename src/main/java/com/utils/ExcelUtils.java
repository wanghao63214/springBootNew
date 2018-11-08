package com.utils;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import java.io.InputStream;
import java.util.List;

public class ExcelUtils<T> {

    public void batchImport(MultipartFile file, List<T> list, T t, Inspector inspector) throws Exception {

        String fileName = null;
        try {
            fileName = file.getOriginalFilename();
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
            int columnNum = sheet.getRow(0).getLastCellNum();
            String[] strArray = new String[columnNum];
            //跳过表头标题，循环sheet中数据
            for (int r = 0; r <= sheet.getLastRowNum(); r++) {
                Row row = sheet.getRow(r);
                if (row.getLastCellNum() > columnNum) {
                    throw new Exception("最后一列标题为空");
                }
                if (row == null) continue;
                inspector.inspectorAndAdd(r, row, columnNum, t, strArray, list);
            }
        } catch (Exception e) {
            throw new Exception(e);
        }
    }

    public interface Inspector<T> {
        void inspectorAndAdd(int r, Row row, int columnNum, T t, String[] strArray, List<T> list) throws Exception;
    }
}
