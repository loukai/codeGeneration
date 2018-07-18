package ${conf.base_package}.${conf.service_package};
<#assign beanName = table.beanName/>
import ${conf.base_package}.${conf.bean_package}.${beanName};
import ${conf.base_package}.${conf.dto_package}.${beanName}Dto;
import com.gateon.wms.base.entity.ServiceResult;

/**
* ${table.tableDesc} I${beanName}Service接口
* Created by loukai on ${.now}
*/
public interface I${beanName}Service{
    /**
    * 列表显示方法
    * @param dto
    * @return
    */
    ServiceResult list (${beanName}Dto dto);

    /**
    *  根据id 查找唯一实体类
    * @param id
    * @return
    */
    ServiceResult getById (String id);

    /**
    * 新增方法
    * @param dto
    * @return
    */
    ServiceResult insert (${beanName}Dto dto);

    /**
    *  更新方法
    * @param dto
    * @return
    */
    ServiceResult update (${beanName}Dto dto);

    /**
    * 批量删除
    * @param dto
    * @return
    */
    ServiceResult delete (${beanName}Dto dto);
}