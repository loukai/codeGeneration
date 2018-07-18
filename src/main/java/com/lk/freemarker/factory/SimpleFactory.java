package com.lk.freemarker.factory;

import com.lk.freemarker.bean.Conf;
import com.lk.freemarker.creator.FileCreator;
import com.lk.freemarker.creator.impl.*;

/**
 * 生成代码
 */
public class SimpleFactory {
    private SimpleFactory() {
        super();
    }

    public static FileCreator create(String module, Conf conf) {

        FileCreator creator = null;
        if (module.equals("bean")) {
            creator = BeanClassCreator.getInstance(conf);
        } else if (module.equals("controller")) {
            creator = ControllerClassCreator.getInstance(conf);
        } else if (module.equals("service")) {
            creator = ServiceClassCreator.getInstance(conf);
        } else if (module.equals("impl")) {
            creator = ServiceImplClassCreator.getInstance(conf);
        } else if (module.equals("mapper")) {
            creator = MapperClassCreator.getInstance(conf);
        } else if (module.equals("xml")) {
            creator = MapperXmlCreator.getInstance(conf);
        } else if (module.equals("dto")) {
            creator = DtoClassCreator.getInstance(conf);
        } else if ("htmlList".equals(module)){
            creator = HtmlListCreator.getInstance(conf);
        } else if ("htmlAdd".equals(module)) {
            creator = HtmlAddCreator.getInstance(conf);
        }
        return creator;

    }
}
