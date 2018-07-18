package com.lk.freemarker.creator.impl;

import com.lk.freemarker.bean.Conf;
import com.lk.freemarker.bean.TableInfo;
import com.lk.freemarker.creator.AbstractFileCreator;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 创建bean
 *
 * @author loukai
 */
public class DtoClassCreator extends AbstractFileCreator {
    private static DtoClassCreator creator;

    private DtoClassCreator() {
        super();
    }

    private DtoClassCreator(Conf conf) {
        super();
        init(conf);
    }

    public static synchronized DtoClassCreator getInstance(Conf conf) {
        if (null == creator) {
            creator = new DtoClassCreator(conf);
        }
        return creator;
    }

    @Override
    public void createFile(TableInfo tableInfo) throws IOException, TemplateException {
        String ftl = "dto.ftl";
        String fileName = tableInfo.getBeanName() + "Dto.java";
        String selfPath = conf.getDto_package();
        String prefixName = tableInfo.getBeanName().substring(0, 3).toLowerCase();
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("table", tableInfo);
        root.put("conf", conf);
//        if (conf.isPrefix()) {//有表名类别
//            root.put("prefixName", prefixName);
//        }


        Template temp = cfg.getTemplate(ftl);
        fileName = javaPath + selfPath  + separator + fileName;
        createFile(fileName, root, temp);


    }


}
