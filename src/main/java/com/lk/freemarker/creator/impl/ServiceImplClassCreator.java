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
 * 创建业务接口实例类
 *
 * @author zhangjh
 */
public class ServiceImplClassCreator extends AbstractFileCreator {
    private static ServiceImplClassCreator creator;

    private ServiceImplClassCreator() {
        super();
    }

    private ServiceImplClassCreator(Conf conf) {
        super();
        init(conf);
    }

    public static synchronized ServiceImplClassCreator getInstance(Conf conf) {
        if (null == creator) {
            creator = new ServiceImplClassCreator(conf);
        }
        return creator;
    }

    @Override
    public void createFile(TableInfo tableInfo) throws IOException, TemplateException {
        String ftl = "impl.ftl";
        String fileName = tableInfo.getBeanName() + "ServiceImpl.java";
        String selfPath = conf.getService_package();
        String prefixName = tableInfo.getBeanName().substring(0, 3).toLowerCase();
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("table", tableInfo);
        root.put("conf", conf);
        if (conf.isPrefix()) {//有表名类别
            root.put("prefixName", prefixName);
        }
        Template temp = cfg.getTemplate(ftl);
        fileName = javaPath + selfPath  + separator + "impl" + separator + fileName;
        createFile(fileName, root, temp);
    }

}
