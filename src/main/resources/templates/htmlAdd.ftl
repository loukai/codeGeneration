<#assign beanName = table.beanName/>  <#--实体类名-->
<#assign firstBeanName = table.beanName?uncap_first/> <#--  首字母小写 -->
<#assign upcaseBeanName = table.beanName?upper_case/>  <#-- 全部转为大写 -->
<#assign tableDesc = table.tableDesc/>  <#-- 表描述 -->
<#assign propertysAndColumnInfos=table.propertysAndColumnInfos> <#-- 里面包含propertyName   columnRemarks 等 -->
<template>
    <el-form  ref="${firstBeanName}Info" :model="${firstBeanName}Info" label-width="100px"
              style="min-width:600px;" :rules="${firstBeanName}Rules">

        <el-form-item :class="{form_item:true}">
            <el-button type="primary" @click="onSubmit('${firstBeanName}Info')" :class="{save:true}"><span class="shiIcon"><img src="../../../assets/img/shi_button_save.png" alt=""></span>保存</el-button>
            <router-link :to="{path:'/${firstBeanName}List'}">
                <el-button type="primary" :class="{save:true}"><span class="shiIcon"><img src="../../../assets/img/shi_button_return.png" alt=""></span>返回</el-button>
            </router-link>
        </el-form-item>

        <h1 class="contract">基本信息</h1>
    <#assign i = 0/>
    <#list propertysAndColumnInfos as propertysAndColumnInfo>
        <#if propertysAndColumnInfo.propertyName!="delFlag" && propertysAndColumnInfo.propertyName !="createTime"
        && propertysAndColumnInfo.propertyName !="id" && propertysAndColumnInfo.propertyName != "companyId"
        && propertysAndColumnInfo.propertyName != "ims" && propertysAndColumnInfo.propertyName != "imgName"
       && propertysAndColumnInfo.propertyName != "shfdaFlag"
        && propertysAndColumnInfo.propertyName != "updateTime" && propertysAndColumnInfo.propertyName != "operator"
        >

     <#if i%3 == 0>
     <el-row  class="row-bg" justify="space-between">
     </#if>
            <#assign i++/>
        <#if propertysAndColumnInfo.propertyName == "status" >
            <el-col  :xs="24" :sm="12" :md="12" :lg="6">
                <el-form-item label="状态:" prop="status">
                    <template>
                        <el-select v-model="${firstBeanName}Info.status" placeholder="请选择">
                            <el-option
                                    v-for="item in statusOptions"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                            </el-option>
                        </el-select>
                    </template>
                </el-form-item>
            </el-col>
        <#else>
            <el-col :xs="24" :sm="12" :md="12" :lg="6">
                <el-form-item label="${propertysAndColumnInfo.columnRemarks}:" prop="${propertysAndColumnInfo.propertyName}">
                    <el-input v-model="${firstBeanName}Info.${propertysAndColumnInfo.propertyName}" clearable></el-input>
                </el-form-item>
            </el-col>
        </#if>

     <#if  i%3 == 0>
     </el-row>
     </#if>

   </#if>
   <#if  i%3 != 0 &&!propertysAndColumnInfo_has_next>
       </el-row>
   </#if>
</#list>

    </el-form>
</template>
<style>


</style>
<script>
    ${r'import'} API from '../../../api';
    ${r'import'} {Message} from 'element-ui';
    ${r'export '} default {
        data(){
        ${r'let '} phone = (rule, value, callback)  ${r'=>'} {
                if(value){
                    if (!/^1(3|4|5|7|8)\d{9}$/i.test(value)) {
                    ${r'return '}  callback(new Error('电话格式不正确!'));
                    } else {
                    ${r'return '} callback();
                    }
                }else{
                ${r'return '} callback();
                }
            };
        ${r'let '}  number = (rule, value, callback) ${r'=>'} {
                if (value) {
                    if (!/^(?!0(\d|\.0+$|$))\d+(\.\d{1,2})?$/i.test(value)) {
                        r'return ' callback(new Error('请输入大于0的数字并最多两位小数!'));
                    } else {
                        r'return ' callback();
                    }
                }
            };

            ${r'return '}{
                isEdit:false,
                ${firstBeanName}Info:{
            <#list propertysAndColumnInfos as propertysAndColumnInfo>
                <#if propertysAndColumnInfo.propertyName!="delFlag" && propertysAndColumnInfo.propertyName !="createTime"
                && propertysAndColumnInfo.propertyName != "shfdaFlag"
                && propertysAndColumnInfo.propertyName != "updateTime" && propertysAndColumnInfo.propertyName != "operator">
                <#if propertysAndColumnInfo.propertyName == "status">
                    status:0,//是否禁用
                    <#else>
                    ${propertysAndColumnInfo.propertyName}:'', // ${propertysAndColumnInfo.columnRemarks}
                </#if>
                </#if>
            </#list>
                },
                ${firstBeanName}Rules:{
                    <#list propertysAndColumnInfos as propertysAndColumnInfo>

                        <#if propertysAndColumnInfo.propertyName!="delFlag" && propertysAndColumnInfo.propertyName !="createTime"
                        && propertysAndColumnInfo.propertyName !="id" && propertysAndColumnInfo.propertyName != "companyId"
                        && propertysAndColumnInfo.propertyName != "ims" && propertysAndColumnInfo.propertyName != "imgName"
                        && propertysAndColumnInfo.propertyName != "shfdaFlag"
                        && propertysAndColumnInfo.propertyName != "updateTime" && propertysAndColumnInfo.propertyName != "operator"
                        && propertysAndColumnInfo.propertyName != "updateUser" && propertysAndColumnInfo.propertyName != "delUser"
                        && propertysAndColumnInfo.propertyName != "delTime" && propertysAndColumnInfo.propertyName != "createUser"
                        && propertysAndColumnInfo.propertyType!="Integer"
                        >
                        ${propertysAndColumnInfo.propertyName}: [
                            {max: ${propertysAndColumnInfo.columnSize}, message: '最大长度为${propertysAndColumnInfo.columnSize}', trigger: 'change'},
                                <#if propertysAndColumnInfo.isNullable == 0>
                             {required: true, message: '请输入${propertysAndColumnInfo.columnRemarks}', trigger: 'change'},
                                </#if>
                        ],
                        </#if>
                    </#list>
                },

                statusOptions: [{
                    value: 0,
                    label: '启用'
                }, {
                    value: 1,
                    label: '禁用'
                }]

            }
        },
        created(){
        },
        methods:{
            init(){
            ${r'let '} id = this.$route.query.id;
                if(!id){
                    ${r'return '};
                }
                this.isEdit=true;
                this.$http.get(API.${upcaseBeanName}_DETAIL+'/'+id)
                        .then(res ${r'=>'} {
                    this.${firstBeanName}Info = res.data;
            })
            },
            onSubmit(${firstBeanName}Info){
                this.$refs[${firstBeanName}Info].validate((valid)${r'=>'}{
                    if(valid){
                        if(this.isEdit){
                            this.$http.post(API.UPDATE_${upcaseBeanName},this.${firstBeanName}Info)
                                    .then(res${r'=>'}{
                                this.$router.push({path:'/${firstBeanName}List'});
                            Message({
                                message:res.msg,
                                type:'success'
                            });

                        })

                        }else{
                            this.$http.post(API.ADD_${upcaseBeanName},this.${firstBeanName}Info)
                                    .then(res${r'=>'}{
                                this.$router.push({path:'/${firstBeanName}List'});
                            Message({
                                message:res.msg,
                                type:'success'
                            });

                        })
                        }
                    }
                })
            }


        },
        mounted:function() {
            this.$nextTick(function () {
                this.init();
            });
        }

    }


</script>
