package com.lk.freemarker;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;




import com.lk.freemarker.bean.Conf;
import com.lk.freemarker.bean.TableInfo;
import com.lk.freemarker.creator.FileCreator;
import com.lk.freemarker.factory.SimpleFactory;
import com.lk.freemarker.util.DbUtils;

import freemarker.template.TemplateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 代码生成执行类
 *
 * @author loukai
 */
public class App {

    /**
     *
     */
    static Logger logging = LoggerFactory.getLogger(App.class);


    /**
     * @throws SQLException
     * @throws ClassNotFoundException
     * @throws IOException
     * @throws TemplateException
     */
    public void doCreate() throws SQLException, ClassNotFoundException, IOException, TemplateException {
        //基础信息 获取配置文件conf.properties中的基础信息
        Conf conf = new Conf().getConf();
        //表集合
        List<TableInfo> tableInfos = getTableInfos(conf);
        logging.info("tableInfos ==>" + tableInfos);
        //生成文件
        createFile(conf, tableInfos);


    }

    /**
     * 需要生成代码的表
     *
     * @param conf
     * @return
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    private List<TableInfo> getTableInfos(Conf conf) throws ClassNotFoundException, SQLException {
    	boolean underline2Camel = conf.isUnderline2Camel(); //是否驼峰式命名
        Connection connection = DbUtils.getInstance().getConnection();//获取数据库连接
        DatabaseMetaData metaData = DbUtils.getInstance().getMetaData(connection);//获取元数据
        List<String> tableNames = Arrays.asList(conf.getTables().split(","));//获取表面集合
        return DbUtils.getInstance().getAllTables(metaData, tableNames,underline2Camel); // 所有表信息
    }

    /**
     * @param conf
     * @param tableInfos
     * @throws IOException
     * @throws TemplateException
     */
    private void createFile(Conf conf, List<TableInfo> tableInfos) throws IOException, TemplateException {
        List<String> modules = conf.getModules();
        FileCreator creator = null;
        for (TableInfo tableInfo : tableInfos) {
            for (String module : modules) {
                creator = SimpleFactory.create(module, conf);
                creator.createFile(tableInfo);
            }
        }
    }


    /**
     * @param args
     * @throws ClassNotFoundException
     * @throws SQLException
     * @throws TemplateException
     * @throws IOException
     */
    public static void main(String[] args) throws ClassNotFoundException, SQLException, TemplateException, IOException {

//        PropertyConfigurator.configure( "log4j.properties " );
        new App().doCreate();
    }


}
