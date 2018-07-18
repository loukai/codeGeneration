package com.lk.freemarker.creator;

import com.lk.freemarker.bean.Conf;
import com.lk.freemarker.bean.TableInfo;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.IOException;

/**
 * 创建文件接口
 */
public interface FileCreator {
    String separator = File.separator;
    void createFile(TableInfo tableInfo) throws IOException, TemplateException;

}
