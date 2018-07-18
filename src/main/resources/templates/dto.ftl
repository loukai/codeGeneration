<#-- bean template -->
package ${conf.base_package}.${conf.dto_package}<#if prefixName??>.${prefixName}</#if>;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;
<#list table.packages as package>
${package}
</#list>
/**
* ${table.tableDesc}Dto
* Created by loukai on ${.now}
*/
public class ${table.beanName}Dto{
<#assign propertysAndColumnInfos = table.propertysAndColumnInfos/>
<#list propertysAndColumnInfos as propertysAndColumnInfo>
    /**
    *${propertysAndColumnInfo.columnRemarks}
    */
    private ${propertysAndColumnInfo.propertyType} ${propertysAndColumnInfo.propertyName};

</#list>
    /**
    *  页数
    */
    private String page;

    /**
    *  条数
    */
    private String num;

    // 关键字查询
    private String key;

    /**
    * 上传文件
    */
    private MultipartFile uploadFile;

    private List<String> ids;

<#list propertysAndColumnInfos as propertysAndColumnInfo>
    public  ${propertysAndColumnInfo.propertyType} get${propertysAndColumnInfo.propertyName?cap_first}(){
        return this.${propertysAndColumnInfo.propertyName};
    }

    public  void set${propertysAndColumnInfo.propertyName?cap_first}(${propertysAndColumnInfo.propertyType} ${propertysAndColumnInfo.propertyName}){
        this.${propertysAndColumnInfo.propertyName} = ${propertysAndColumnInfo.propertyName};
    }

</#list>

    public String getPage() {
       return page;
    }

    public void setPage(String page) {
        this.page = page;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public MultipartFile getUploadFile() {
        return uploadFile;
    }

    public void setUploadFile(MultipartFile uploadFile) {
        this.uploadFile = uploadFile;
    }

    public List<String> getIds() {
        return ids;
    }

    public void setIds(List<String> ids) {
            this.ids = ids;
    }
}


