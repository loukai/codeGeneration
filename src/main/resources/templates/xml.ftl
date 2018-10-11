<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<#-- 获取beanName:Supplier-->
<#assign beanName = table.beanName/>
<#-- 表名 -->
<#assign tableName = table.tableName/>
<#-- 插入变量用的比如#{id} 因为#{}和freemarker的#{}冲突就用${r""}输入字符串 -->
<#macro mapperEl value>${r"#{"}${value}}</#macro>
<#-- 批次插入用的 -->
<#macro batchMapperEl value>${r"#{"}item.${value}}</#macro>
<#-- bean的全路径：com.gateon.product.wasteRecycle.entity.Supplier -->
<#assign bean = conf.base_package+"."+conf.bean_package+"."+beanName/>
<#-- mapper的全路径：com.gateon.product.wasteRecycle.mapper.SupplierMapper -->
<#assign mapper = conf.base_package+"."+conf.mapper_package+"."+beanName+"Mapper"/>
<#-- 所有信息 -->
<#assign propertysAndColumnInfos = table.propertysAndColumnInfos/>
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
<mapper namespace="${mapper}">
    <#--<sql id="searchInfoSql">-->
        <#--`id` AS id,-->
        <#--<#list keys as key>-->
        <#--`${propertiesAnColumns["${key}"]}` AS  ${key}<#if key_has_next>,</#if>-->
        <#--</#list>-->
    <#--</sql>-->
        <resultMap type="${bean}" id="${beanName}Map">
            <#list propertysAndColumnInfos as propertysAndColumnInfo>
                <result column="${propertysAndColumnInfo.columnName}" property="${propertysAndColumnInfo.propertyName}" jdbcType="${propertysAndColumnInfo.columnType}"/>
            </#list>
        </resultMap>

        <sql id="Base_Column_List">
            <#list propertysAndColumnInfos as propertysAndColumnInfo>
                a.${propertysAndColumnInfo.columnName} <#if propertysAndColumnInfo_has_next>,</#if>
            </#list>
        </sql>


    <select id="getById" parameterType="java.lang.String" resultMap="${beanName}Map">
        select
        <include refid="Base_Column_List" />
        FROM    ${tableName}  a
        WHERE
        a.id = ${r'#{id}'}
        and a.del_flag = 0
        limit 1
    </select>
        <#if code_flag == 1>
    <select id="getByCode" parameterType="java.lang.String" resultMap="${beanName}Map">
        select
        <include refid="Base_Column_List" />
        FROM    ${tableName} a
        WHERE
        a.code = ${r'#{code}'}
            <#if companyId_flag == 1 >
        <if test="companyId !=null and companyId != ''">
            and a.company_id = ${r'#{companyId}'}
        </if>
            </#if>
        and a.del_flag = 0
        limit 1
    </select>
        </#if>

    <select id="list" resultMap="${beanName}Map">
        SELECT   <include refid="Base_Column_List" />
        FROM  ${tableName} a
        WHERE a.del_flag=0
        <#--<if test="key !=null and key != ''">-->
            <#--and  (code like  CONCAT('%',${r'#{key,jdbcType=VARCHAR}'},'%') OR  name like  CONCAT('%',${r'#{key,jdbcType=VARCHAR}'},'%')  OR remark like  CONCAT('%',${r'#{key,jdbcType=VARCHAR}'},'%')  )-->
        <#--</if>-->
        <#list propertysAndColumnInfos as propertysAndColumnInfo>
            <#if propertysAndColumnInfo.propertyName !="delFlag" >
        <if test="${propertysAndColumnInfo.propertyName} !=null <#if propertysAndColumnInfo.propertyType!="Integer">and ${propertysAndColumnInfo.propertyName} != ''</#if>">
            and  a.`${propertysAndColumnInfo.columnName}`  =<@mapperEl propertysAndColumnInfo.propertyName/>
        </if>
            </#if>
        </#list>
        ORDER BY  a.create_time desc
    </select>

    <update id="update">
        update
            ${tableName}
        <set>
        <#list propertysAndColumnInfos as propertysAndColumnInfo>
            <#if propertysAndColumnInfo.propertyName !="delFlag"  && propertysAndColumnInfo.propertyName !="createTime"
            && propertysAndColumnInfo.propertyName !="id" && propertysAndColumnInfo.propertyName != "companyId"
            && propertysAndColumnInfo.propertyName != "createUser" && propertysAndColumnInfo.propertyName != "delUser"
            && propertysAndColumnInfo.propertyName != "delTime"
            >
        <if test="${propertysAndColumnInfo.propertyName} !=null ">
            `${propertysAndColumnInfo.columnName }` = <@mapperEl propertysAndColumnInfo.propertyName/> <#if propertysAndColumnInfo_has_next>,</#if>
        </if>
            </#if>
        </#list>

        </set>
        WHERE
        `id` = ${r'#{id}'}
        and `del_flag` = 0
        <#--<#list keys2 as key>-->
            <#--`${key}` = <@mapperEl primaryKey["${key}"]/>-->
        <#--</#list>-->
    </update>

    <insert id="insert">
        insert into ${tableName}
        (
        <trim prefix="" suffixOverrides=",">

        <#list propertysAndColumnInfos as propertysAndColumnInfo>
            <#if propertysAndColumnInfo.propertyName !="delFlag" && propertysAndColumnInfo.propertyName !="updateTime"
            && propertysAndColumnInfo.propertyName !="delUser" && propertysAndColumnInfo.propertyName !="updateUser"
            && propertysAndColumnInfo.propertyName !="delTime"
            >
        <if test="${propertysAndColumnInfo.propertyName} !=null <#if propertysAndColumnInfo.propertyType!="Integer">and ${propertysAndColumnInfo.propertyName} != ''</#if>">
            `${propertysAndColumnInfo.columnName }`<#if propertysAndColumnInfo_has_next>,</#if>
        </if>
            </#if>
        </#list>
        </trim>
        )
        values
        (
        <trim prefix="" suffixOverrides=",">
<#list propertysAndColumnInfos as propertysAndColumnInfo>
    <#if propertysAndColumnInfo.propertyName !="delFlag" && propertysAndColumnInfo.propertyName !="updateTime"
    && propertysAndColumnInfo.propertyName !="delUser" && propertysAndColumnInfo.propertyName !="updateUser"
    && propertysAndColumnInfo.propertyName !="delTime"
    >
        <if test="${propertysAndColumnInfo.propertyName} !=null <#if propertysAndColumnInfo.propertyType!="Integer">and ${propertysAndColumnInfo.propertyName} != ''</#if>">
            <@mapperEl propertysAndColumnInfo.propertyName/> <#if propertysAndColumnInfo_has_next>,</#if>
        </if>
        </#if>
</#list>
        </trim>
        )
    </insert>

    <insert id="batchInsert">
            insert into
            ${tableName}
            (
        <trim prefix="" suffixOverrides=",">
    <#list propertysAndColumnInfos as propertysAndColumnInfo>
        <#if propertysAndColumnInfo.propertyName !="delFlag" && propertysAndColumnInfo.propertyName !="updateTime"
        && propertysAndColumnInfo.propertyName !="delUser" && propertysAndColumnInfo.propertyName !="updateUser"
        && propertysAndColumnInfo.propertyName !="delTime"
        >
                    `${propertysAndColumnInfo.columnName}`  <#if propertysAndColumnInfo_has_next>,</#if>
                </#if>
                 </#list>
        </trim>
            )
            values
            <foreach collection="dtos" item="item" index="index" separator="," >
               (
                <trim prefix="" suffixOverrides=",">
            <#list propertysAndColumnInfos as propertysAndColumnInfo >
                <#if propertysAndColumnInfo.propertyName !="delFlag" && propertysAndColumnInfo.propertyName !="updateTime"
                && propertysAndColumnInfo.propertyName !="delUser" && propertysAndColumnInfo.propertyName !="updateUser"
                && propertysAndColumnInfo.propertyName !="delTime"
                >
                       <@batchMapperEl propertysAndColumnInfo.propertyName/><#if propertysAndColumnInfo_has_next>,</#if>
                   </#if>
                    </#list>
                </trim>
                )
            </foreach>
    </insert>

    <update id="delete">
        update  ${tableName} a
        set
<#list propertysAndColumnInfos as propertysAndColumnInfo>
    <#if propertysAndColumnInfo.columnName=='del_user'>
       `del_user`= ${r'#{delUser}'},
    </#if>
    <#if propertysAndColumnInfo.columnName=='del_time'>
        `del_time`= ${r'#{delTime}'},
    </#if>
</#list>
        `del_flag`=1
        WHERE id in
        <foreach item="item" index="index" collection="ids" open="(" separator="," close=")">
        ${r'#{item}'}
        </foreach>
        and del_flag = 0
    </update>

</mapper>