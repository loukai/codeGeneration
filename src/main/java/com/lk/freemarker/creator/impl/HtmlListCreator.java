package com.lk.freemarker.creator.impl;

import com.lk.freemarker.bean.Conf;
import com.lk.freemarker.bean.TableInfo;
import com.lk.freemarker.creator.AbstractFileCreator;
import com.lk.freemarker.util.CommonUtil;
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
public class HtmlListCreator extends AbstractFileCreator {
    private static HtmlListCreator creator;

    private HtmlListCreator() {
        super();
    }

    private HtmlListCreator(Conf conf) {
        super();
        init(conf);
    }

    public static synchronized HtmlListCreator getInstance(Conf conf) {
        if (null == creator) {
            creator = new HtmlListCreator(conf);
        }
        return creator;
    }

    @Override
    public void createFile(TableInfo tableInfo) throws IOException, TemplateException {
        String ftl = "htmlList.ftl";
        String fileName = CommonUtil.toLowerCaseFirstOne(tableInfo.getBeanName())+ "List.vue";
        String selfPath = conf.getHtml_package();
//        String prefixName = tableInfo.getBeanName().substring(0, 3).toLowerCase();
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("table", tableInfo);
        root.put("conf", conf);
//        if (conf.isPrefix()) {//有表名类别
//            root.put("prefixName", prefixName);
//        }


        Template temp = cfg.getTemplate(ftl);
        fileName = resourcesbasePath + selfPath  + separator + fileName;
        createFile(fileName, root, temp);


    }


}
