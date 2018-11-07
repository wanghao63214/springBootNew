package com.utils;
import java.io.File;
import java.io.FileOutputStream;

public class FileUtils {
    public static void uploadFile(byte[] file, String filePath, String fileName) throws Exception {
        File targetFile = new File(filePath);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        //FileOutputStream（String name，boolean append）为末尾添加
        FileOutputStream out = new FileOutputStream(filePath + fileName);
        out.write(file);
        out.flush();
        out.close();
    }
}
