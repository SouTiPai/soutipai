package com.soutipai.service;

import com.soutipai.utils.OCRUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Objects;

@RestController
public class OCR {
    @RequestMapping("/ocr")
    public String get(@RequestParam("file") MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                String[] path = Objects.requireNonNull(file.getOriginalFilename()).split("/");
                File filePath = new File(path[0] + "/" + path[1]);
                if (!filePath.exists()) {
                    //noinspection ResultOfMethodCallIgnored
                    filePath.mkdirs();
                }
                BufferedOutputStream out = new BufferedOutputStream(
                        new FileOutputStream(Objects.requireNonNull(file.getOriginalFilename())));
                out.write(file.getBytes());
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
                return "上传失败," + e.getMessage();
            }
            return OCRUtils.generalBasic(file.getOriginalFilename());
        } else {
            return "上传失败，因为文件是空的.";
        }
    }
}
