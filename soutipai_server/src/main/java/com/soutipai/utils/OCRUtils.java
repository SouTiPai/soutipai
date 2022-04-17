package com.soutipai.utils;

import com.soutipai.SoutipaiServerApplication;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 通用文字识别
 */
public class OCRUtils {

    public static String generalBasic(String filePath) {//接收来自截图完成的图片参数
        // 请求url
        String url = "https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic";
        try {

            byte[] imgData = FileUtil.readFileByBytes(filePath);
            String imgStr = Base64Util.encode(imgData);
            String imgParam = URLEncoder.encode(imgStr, StandardCharsets.UTF_8);

            String param = "image=" + imgParam;

            String accessToken = SoutipaiServerApplication.token;
            //获取识别结果
            String result = HttpUtil.post(url, accessToken, param);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

        //调用方式 -> OCRUtils.generalBasic();
}