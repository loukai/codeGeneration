package ${conf.base_package}.${conf.mapper_package}<#if prefixName??>.${prefixName}</#if>;
import ${conf.base_package}.${conf.bean_package}<#if prefixName??>.${prefixName}</#if>.${table.beanName};
import ${conf.base_package}.${conf.dto_package}<#if prefixName??>.${prefixName}</#if>.${table.beanName}Dto;
import org.apache.ibatis.annotations.Param;
import java.util.List;
<#assign propertysAndColumnInfos = table.propertysAndColumnInfos/>

/**
* ${table.tableDesc}mapper
* Created by loukai on ${.now}
*/
public interface ${table.beanName}Mapper{
    /**
    * 列表显示方法
    * @param dto
    * @return
    */
    List<${table.beanName}> list (${table.beanName}Dto dto);

    /**
    *  根据id获取唯一实体
    */
    ${table.beanName} getById (@Param("id") String id);
<#assign code_flag = 0>
<#assign companyId_flag = 0>
<#list propertysAndColumnInfos as propertysAndColumnInfo>
    <#if propertysAndColumnInfo.propertyName == 'code' >
        <#assign code_flag = 1>
    </#if>
    <#if propertysAndColumnInfo.propertyName == 'companyId' >
        <#assign companyId_flag = 1>
    </#if>
</#list>
<#if code_flag == 1 >
    /**
    *  根据code <#if companyId_flag == 1>和companyId</#if>获取唯一实体
    */
    ${table.beanName} getByCode (@Param("code") String code <#if companyId_flag == 1>, @Param("companyId") String companyId</#if>);
</#if>

    /**
    * 新增方法
    * @param dto
    * @return
    */
    int insert (${table.beanName}Dto dto);

    /**
    *  更新方法
    * @param dto
    * @return
    */
    int update (${table.beanName}Dto dto);

    /**
    * 批量删除
    * @param dto
    * @return
    */
    int delete (${table.beanName}Dto dto);

    /**
    * 批量插入
    * @param dtos
    * @return
    */
    int batchInsert(@Param("dtos") List<${table.beanName}Dto> dtos);

}