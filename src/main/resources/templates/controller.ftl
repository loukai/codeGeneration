package ${conf.base_package}.${conf.controller_package};
<#-- 实体类的名称大写：Supplier -->
<#assign beanName = table.beanName/>
<#-- beanName 小写: supplier -->
<#assign beanNameUncap_first = beanName?uncap_first/>
<#-- 所有信息 -->
<#assign propertysAndColumnInfos = table.propertysAndColumnInfos/>
<#--<#assign implName = beanNameUncap_first+"Service"/>-->
import ${conf.base_package}.${conf.service_package}.I${beanName}Service;
import ${conf.base_package}.${conf.dto_package}.${beanName}Dto;
import com.gateon.wms.base.common.util.*;
import com.gateon.wms.base.controller.BaseController;
import com.gateon.wms.base.entity.ServiceResult;
import com.gateon.wms.base.enums.ServiceResultEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.InputStream;
import com.gateon.wms.base.common.util.FileUtil;
import org.apache.commons.lang3.StringUtils;
import java.util.List;
/**
*  ${table.tableDesc} Controller层
* Created by loukai on ${.now}
*/
@RestController
@RequestMapping(value = "/inWarehouse/${beanNameUncap_first}")
public class ${beanName}Controller extends BaseController{

    @Autowired
    private I${beanName}Service ${beanNameUncap_first}Service;

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    public ServiceResult list(@RequestBody ${beanName}Dto dto, HttpServletRequest request) {
        dto.setCompanyId(super.getCompanyId(request));
        return ${beanNameUncap_first}Service.list(dto);
    }

    @RequestMapping(value = "/getById/{id}", method = RequestMethod.GET)
    public ServiceResult getById(@PathVariable("id") String id, HttpServletRequest request) {
        return ${beanNameUncap_first}Service.getById(id);
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    public ServiceResult insert(@RequestBody ${beanName}Dto dto, HttpServletRequest request) {
        dto.setId(UuidGenerator.uuid());
       <#list propertysAndColumnInfos  as  propertyAndColumnInfo >
           <#if propertyAndColumnInfo.propertyName == 'companyId'>
        dto.setCompanyId(super.getCompanyId(request));
           </#if>
           <#if propertyAndColumnInfo.propertyName == 'operator'>
        dto.setOperator(super.getUserId(request));
           </#if>
           <#if propertyAndColumnInfo.propertyName == 'createUser'>
        dto.setCreateUser(super.getUserId(request));
           </#if>
           <#if propertyAndColumnInfo.propertyName == 'createTime'>
        dto.setCreateTime(DateUtil.getDate(DateUtil.DATE_PATTERN));
           </#if>
           <#if propertyAndColumnInfo.isNullable == 0 && propertyAndColumnInfo.propertyName!='id'&& propertyAndColumnInfo.propertyType!='Integer'>
        if (StringUtils.isBlank(dto.get${propertyAndColumnInfo.propertyName?cap_first}())) {
            return  RespUtil.respFailMsg(ServiceResultEnum.CODE_1111.getKey(),"${propertyAndColumnInfo.columnRemarks}不能为空");
        }
           </#if>
       </#list>
        return ${beanNameUncap_first}Service.insert(dto );
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ServiceResult update(@RequestBody ${beanName}Dto dto, HttpServletRequest request) {
<#list propertysAndColumnInfos  as  propertyAndColumnInfo >
    <#if propertyAndColumnInfo.propertyName == 'companyId'>
        dto.setCompanyId(super.getCompanyId(request));
    </#if>
    <#if propertyAndColumnInfo.propertyName == 'operator'>
        dto.setOperator(super.getUserId(request));
    </#if>
    <#if propertyAndColumnInfo.propertyName == 'updateTime'>
        dto.setUpdateTime(DateUtil.getDate(DateUtil.DATE_PATTERN));
    </#if>
    <#if propertyAndColumnInfo.propertyName == 'updateUser'>
        dto.setUpdateUser(super.getUserId(request));
    </#if>
    <#if propertyAndColumnInfo.isNullable == 0 && propertyAndColumnInfo.propertyType!='Integer' >
        if (StringUtils.isBlank(dto.get${propertyAndColumnInfo.propertyName?cap_first}())) {
            return  RespUtil.respFailMsg(ServiceResultEnum.CODE_1111.getKey(),"${propertyAndColumnInfo.columnRemarks}不能为空");
        }
    </#if>
</#list>
        return ${beanNameUncap_first}Service.update(dto );
    }

    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.DELETE)
    public ServiceResult delete(@PathVariable("ids") String ids, HttpServletRequest request) {
        ${beanName}Dto dto = new ${beanName}Dto();
        List<String> list= CommonUtil.getIds(ids);
<#list propertysAndColumnInfos  as  propertyAndColumnInfo >
    <#if propertyAndColumnInfo.propertyName == 'delUser'>
        dto.setDelUser(super.getUserId(request));
    </#if>
    <#if propertyAndColumnInfo.propertyName == 'delTime'>
        dto.setDelTime(DateUtil.getTime(DateUtil.DATE_PATTERN));
    </#if>
</#list>
        dto.setIds(list);
        return ${beanNameUncap_first}Service.delete(dto);
    }

    @RequestMapping(value = "/download")
    public void download(HttpServletRequest request,HttpServletResponse response) {
        String fileName = "模板.xls";
        InputStream inputStream = FileUtil.getClassInputStream("template"+ File.separator+fileName);
        FileUtil.download(inputStream,fileName,response);
    }
}
