package com.lk.freemarker.bean;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 表对象
 *
 * @author lk
 */
public class TableInfo {
    /**
     * 表名
     */
    private String tableName;

    /**
     * bean
     */
    private String beanName;

    /**
     * 表名 注释
     */
    private String tableDesc;

    /**
     * 主键映射
     */
    private Map<String, String> primaryKey;

    /**
     * bean和column的所有信息
     */
    private List<PropertyAndColumnInfo> propertysAndColumnInfos;

    /**
     * bean类导入的包
     */
    private Set<String> packages;

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getBeanName() {
        return beanName;
    }

    public void setBeanName(String beanName) {
        this.beanName = beanName;
    }

    public String getTableDesc() {
        return tableDesc;
    }

    public void setTableDesc(String tableDesc) {
        this.tableDesc = tableDesc;
    }

    public Map<String, String> getPrimaryKey() {
        return primaryKey;
    }

    public void setPrimaryKey(Map<String, String> primaryKey) {
        this.primaryKey = primaryKey;
    }

    public Set<String> getPackages() {
        return packages;
    }

    public void setPackages(Set<String> packages) {
        this.packages = packages;
    }

    public List<PropertyAndColumnInfo> getPropertysAndColumnInfos() {
        return propertysAndColumnInfos;
    }

    public void setPropertysAndColumnInfos(List<PropertyAndColumnInfo> propertysAndColumnInfos) {
        this.propertysAndColumnInfos = propertysAndColumnInfos;
    }
}
