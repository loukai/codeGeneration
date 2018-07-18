<#import "base/date.ftl" as dt>
package ${conf.base_package}.${conf.service_package}.impl;
<#-- beanName: supplier -->
<#assign beanName = table.beanName/>
<#-- beanName首字母大小:Supplier -->
<#assign beanNameUncap_first = beanName?uncap_first/>
<#assign propertysAndColumnInfos = table.propertysAndColumnInfos/>
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import ${conf.base_package}.${conf.bean_package}.${beanName};
import ${conf.base_package}.${conf.service_package}.I${beanName}Service;
import ${conf.base_package}.${conf.mapper_package}.${beanName}Mapper;
import ${conf.base_package}.${conf.dto_package}.${beanName}Dto;
import java.util.List;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.gateon.wms.base.common.util.CommonUtil;
import com.gateon.wms.base.common.util.RespUtil;
import com.gateon.wms.base.entity.ServiceResult;
import com.gateon.wms.base.enums.ServiceResultEnum;
/**
* ${table.tableDesc} ${beanName}ServiceImpl
* Created by loukai on ${.now}
*/
@Service
public class ${beanName}ServiceImpl implements I${beanName}Service{
    @Autowired
    private ${beanName}Mapper ${beanNameUncap_first}Mapper;

    @Override
    public ServiceResult list(${beanName}Dto dto) {
        String page = dto.getPage();
        if (null == page) {
            page = "1";
        }
        String num = dto.getNum();
        if ( null == num ) {
            num = "20";
        }
        PageHelper.startPage(Integer.valueOf(page), Integer.valueOf(num));
        List<${beanName}> ${beanNameUncap_first}s = ${beanNameUncap_first}Mapper.list(dto);
        PageInfo<${beanName}> pageInfo = new PageInfo<${beanName}>(${beanNameUncap_first}s);
        return RespUtil.respSuccessMsgWithData(pageInfo);
    }

    @Override
    public ServiceResult getById(String id) {
        ${beanName} ${beanNameUncap_first} = ${beanNameUncap_first}Mapper.getById(id);
        return RespUtil.respSuccessMsgWithData(${beanNameUncap_first});
    }

    @Override
    public ServiceResult insert(${beanName}Dto dto) {
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
<#if code_flag == 1>
        if ( ${beanNameUncap_first}Mapper.getByCode(dto.getCode()<#if companyId_flag == 1>,dto.getCompanyId()</#if>) != null){
            return  RespUtil.respFailMsg(ServiceResultEnum.CODE_2222.getKey(),"代码重复");
        }
</#if>


        int row = ${beanNameUncap_first}Mapper.insert(dto);
        if (row > 0) {
            return  RespUtil.respSuccessMsg("数据新增成功");
        }else {
            return  RespUtil.respFailMsg(ServiceResultEnum.CODE_3002.getKey(),ServiceResultEnum.CODE_3002.getDesc());
        }
    }

    @Override
    public ServiceResult update(${beanName}Dto dto) {
        ${beanNameUncap_first}Mapper.update(dto);
        return  RespUtil.respSuccessMsg("数据更新成功");
    }

    @Override
    public ServiceResult delete(${beanName}Dto dto) {
        ${beanNameUncap_first}Mapper.delete(dto);
        return  RespUtil.respSuccessMsg("数据删除成功");
    }
}