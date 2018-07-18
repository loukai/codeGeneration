package com.lk.freemarker.bean;

/**
 * bean和column的信息
 * Created by
 */
public class PropertyAndColumnInfo {
    /**
     * 列名
     */
    private String columnName;

    /**
     * 列类型（VARCHAR、INTEGER等）
     */
    private String columnType;

    /**
     * 列的注释
     */
    private String columnRemarks;

    /**
     *  属性名
     */
    private String propertyName;

    /**
     * 属性类型（String 、Integer等）
     */
    private String propertyType;

    /**
     * 是否可为空 0:不可为空 1 ：可为空
     */
    private int isNullable;

    /**
     * 列的大小
     */
    private int columnSize;

    /**
     * 小数的位数
     */
    private int decimalDigits;

    public int getColumnSize() {
        return columnSize;
    }

    public void setColumnSize(int columnSize) {
        this.columnSize = columnSize;
    }

    public int getDecimalDigits() {
        return decimalDigits;
    }

    public void setDecimalDigits(int decimalDigits) {
        this.decimalDigits = decimalDigits;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnType() {
        return columnType;
    }

    public void setColumnType(String columnType) {
        this.columnType = columnType;
    }

    public String getColumnRemarks() {
        return columnRemarks;
    }

    public void setColumnRemarks(String columnRemarks) {
        this.columnRemarks = columnRemarks;
    }

    public String getPropertyName() {
        return propertyName;
    }

    public void setPropertyName(String propertyName) {
        this.propertyName = propertyName;
    }

    public String getPropertyType() {
        return propertyType;
    }

    public void setPropertyType(String propertyType) {
        this.propertyType = propertyType;
    }

    public int getIsNullable() {
        return isNullable;
    }

    public void setIsNullable(int isNullable) {
        this.isNullable = isNullable;
    }
}
