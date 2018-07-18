<#-- bean template -->
package ${conf.base_package}.${conf.bean_package}<#if prefixName??>.${prefixName}</#if>;
<#-- 需要导入到包 -->
<#list table.packages as package>
${package}
</#list>
/**
*  ${table.tableDesc}实体bean
* Created by loukai on ${.now}
*/
public class ${table.beanName}{
<#assign propertysAndColumnInfos = table.propertysAndColumnInfos/>
<#list propertysAndColumnInfos as propertysAndColumnInfo>
    /**
    *${propertysAndColumnInfo.columnRemarks}
    */
    private ${propertysAndColumnInfo.propertyType} ${propertysAndColumnInfo.propertyName};

</#list>

<#list propertysAndColumnInfos as propertysAndColumnInfo>
    public  ${propertysAndColumnInfo.propertyType} get${propertysAndColumnInfo.propertyName?cap_first}(){
        return this.${propertysAndColumnInfo.propertyName};
    }

    public  void set${propertysAndColumnInfo.propertyName?cap_first}(${propertysAndColumnInfo.propertyType} ${propertysAndColumnInfo.propertyName}){
        this.${propertysAndColumnInfo.propertyName} = ${propertysAndColumnInfo.propertyName};
    }

</#list>
}
