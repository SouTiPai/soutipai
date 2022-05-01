package com.soutipai.common;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

public class GetJSONFromData {

    static public <E> String getJSONFromData(int code ,List<E> data){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", code);
        switch (code) {
            case 100 -> jsonObject.put("message", "等待中");
            case 101 -> jsonObject.put("message", "切换协议");
            case 200 -> jsonObject.put("message", "操作成功");
            case 201 -> jsonObject.put("message", "创建成功");
            case 202 -> jsonObject.put("message", "已接收");
            case 203 -> jsonObject.put("message", "未授权信息");
            case 204 -> jsonObject.put("message", "无内容");
            case 205 -> jsonObject.put("message", "重复内容");
            case 206 -> jsonObject.put("message", "部分内容");
            case 300 -> jsonObject.put("message", "多种选择");
            case 301 -> jsonObject.put("message", "永久移动");
            case 302 -> jsonObject.put("message", "临时移动");
            case 303 -> jsonObject.put("message", "查看其他位置");
            case 304 -> jsonObject.put("message", "未修改");
            case 305 -> jsonObject.put("message", "使用代理");
            case 307 -> jsonObject.put("message", "临时重定向");
            case 400 -> jsonObject.put("message", "错误请求");
            case 401 -> jsonObject.put("message", "未授权");
            case 402 -> jsonObject.put("message", "授权失败");
            case 403 -> jsonObject.put("message", "禁止");
            case 404 -> jsonObject.put("message", "未找到");
            case 405 -> jsonObject.put("message", "方法禁用");
            case 406 -> jsonObject.put("message", "不接受");
            case 407 -> jsonObject.put("message", "需要代理授权");
            case 408 -> jsonObject.put("message", "请求超时");
            case 409 -> jsonObject.put("message", "冲突");
            case 410 -> jsonObject.put("message", "已删除");
            case 411 -> jsonObject.put("message", "需要有效长度");
            case 412 -> jsonObject.put("message", "前提条件不满足");
            case 413 -> jsonObject.put("message", "请求实体过大");
            case 414 -> jsonObject.put("message", "请求URI过长");
            case 415 -> jsonObject.put("message", "不支持的媒体类型");
            case 416 -> jsonObject.put("message", "请求范围不符合要求");
            case 417 -> jsonObject.put("message", "未满足期望值");
            case 500 -> jsonObject.put("message", "服务器内部错误");
            case 501 -> jsonObject.put("message", "尚未实施");
            case 502 -> jsonObject.put("message", "错误网关");
            case 503 -> jsonObject.put("message", "服务不可用");
            case 504 -> jsonObject.put("message", "网关超时");
            case 505 -> jsonObject.put("message", "HTTP版本不受支持");
            default -> jsonObject.put("message", "未知错误");
        }
        if(data != null) {
            jsonObject.put("data", data);
        }
        if(code == 200) {
            jsonObject.put("success", "success");
        }else {
            jsonObject.put("success", "fail");
        }
        return jsonObject.toJSONString();
    }
}
