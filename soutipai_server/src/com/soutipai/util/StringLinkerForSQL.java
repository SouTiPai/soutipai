//字符串连接，自动补充空格
package com.soutipai.util;

import com.soutipai.common.Exceptions.LinkerException;

public class StringLinkerForSQL {
    public static StringBuilder Link(String[] strings) throws LinkerException {
        StringBuilder str = new StringBuilder();
        if (strings == null) {
            throw new LinkerException("字符串不能为空");
        } else {
            for (int i = 0; i < strings.length; i++) {
                str.append(strings[i]).append(i == strings.length - 1 ? "" : " ");
            }
        }
        return str;
    }
}
