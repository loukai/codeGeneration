package com.lk.freemarker.util;

/**
 * Created by loukai on 2018/6/1.
 */
public class CommonUtil {
    //首字母转小写
    public static String toLowerCaseFirstOne(String s){
        if(Character.isLowerCase(s.charAt(0))){
            return s;
        } else {
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
        }
    }

    //首字母转大写
    public static String toUpperCaseFirstOne(String s){
        if(Character.isUpperCase(s.charAt(0))) {
            return s;
        } else {
            return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
        }
    }

    /**
     * 通过表名设置中文注释
     * @param tableName
     * @return
     */
    public static String setTableCommentByTableName(String tableName){
        String tableDesc = "";
        if ("dealer".equals(tableName)) {
            tableDesc = "经销商";
        } else if ("product".equals(tableName)) {
            tableDesc = "产品";
        } else if ("raw_material".equals(tableName)) {
            tableDesc = "原物料";
        } else if ("store".equals(tableName)) {
            tableDesc = "门店";
        } else if ("supplier".equals(tableName)) {
            tableDesc = "供应商";
        } else if ("type".equals(tableName)) {
            tableDesc = "类别管理";
        } else if ("warehouse".equals(tableName)) {
            tableDesc = "仓库";
        } else if ("customer".equals(tableName)) {
            tableDesc = "客户";
        } else if ("production_process".equals(tableName)) {
            tableDesc = "生产流程";
        } else if ("production_craft".equals(tableName)) {
            tableDesc = "生产工艺";
        } else if ("type".equals(tableName)) {
            tableDesc = "类别";
        }else if ("purchase_order".equals(tableName)) {
            tableDesc = "采购订单";
        }else if ("pruchase_material_order".equals(tableName)) {
            tableDesc = "采购订单—原辅料";
        }else if ("purchase_material_in_warehouse_order".equals(tableName)) {
            tableDesc = "采购入库单";
        }else if ("other_material_in_warehouse_order".equals(tableName)) {
            tableDesc = "其他入库单";
        }else if ("return_material_in_warehouse_order".equals(tableName)) {
            tableDesc = "退料入库单";
        }else if ("material_in_warehouse_order".equals(tableName)) {
            tableDesc = "原辅料入库单";
        }else{
            tableDesc = tableName;
        }
        return tableDesc;
    }
}
