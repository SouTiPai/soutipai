package com.soutipai.service;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.soutipai.utils.OCRTemplate;
import javax.servlet.http.HttpServletRequest;
@RestController
public class OCR {
    @RequestMapping("/ocr")
    public String ocr(HttpServletRequest request){
        //System.out.println("connected");
        String filepath = request.getParameter("filepath");
        //System.out.println(question);
        return OCRTemplate.generalBasic(filepath);
    }
}
