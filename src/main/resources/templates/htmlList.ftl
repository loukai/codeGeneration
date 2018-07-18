<#assign beanName = table.beanName/>  <#--实体类名-->
<#assign firstBeanName = table.beanName?uncap_first/> <#--  首字母小写 -->
<#assign upcaseBeanName = table.beanName?upper_case/>  <#-- 全部转为大写 -->
<#assign tableDesc = table.tableDesc/>  <#-- 表描述 -->
<#assign propertysAndColumnInfos=table.propertysAndColumnInfos> <#-- 里面包含propertyName   columnRemarks 等 -->
    <template>
        <section>
            <!--工具条-->
            <!--操作按钮-->
            <el-row type="flex" class="row-bg" justify="start">
                <el-col :xs="24" :sm="24" :md="24" :lg="24" :class="{bottom_:true}">
                    <router-link :to="{path:'/add${beanName}',query: { id: ''}}">
                        <el-button :class="{right_:true}" class="el-button-base"><span class="shiIcon"><img src="../../../assets/img/1x/function1.png" alt=""  style="margin-top: -1px;"></span> 新增</el-button>
                    </router-link>
                    <el-button :class="{right_:true}" class="el-button-base" @click="batchRemove" ><span class="shiIcon"><img src="../../../assets/img/1x/close_icon3.png" alt=""></span>删除</el-button>
                    <el-button :class="{right_:true}" class="el-button-base">
                        <a :href="fileUrl" download="${tableDesc}信息" style="text-decoration: none;color: #029bea;">
                            <span class="shiIcon"><img src="../../../assets/img/1x/function7_1.png" alt=""></span>获取模板
                        </a>
                    </el-button>
                    <el-button :class="{right_:true}" class="el-button-base"  @click="dialogTableVisible${beanName}Upload = true"><span class="shiIcon"><img src="../../../assets/img//1x/function4.png" alt=""  style="margin-top: -2px;"></span>导入</el-button>
                    <el-button v-if="!IsSearch" :class="{right_:true}" class="el-button-base" @click="showList"><span class="shiIcon"><img style="margin-top: 3px;" src="../../../assets/img//1x/icon1.png" alt=""></span>展开</el-button>
                    <el-button v-if="IsSearch" :class="{right_:true}" class="el-button-base" @click="UP"><span class="shiIcon el-icon-arrow-up"></span>收起</el-button>

                    <span v-if="IsSearch">
                    <span class="commenStyle">
                    <span class="title_1">关键字：</span>
                    <span><el-input :class="{right_:true,width_1:true}" v-model="key" placeholder="${tableDesc}编码,名称,备注关键字"></el-input></span>
                    <el-button v-if="IsSearch" :class="{right_:true}" class="el-button-base" @click="init"><span class="shiIcon"><img src="../../../assets/img/1x/icon4.png" alt=""></span>搜索</el-button>
                    <el-button v-if="IsSearch" :class="{right_:true}" class="el-button-base" @click="resets"><span class="shiIcon"><img src="../../../assets/img/1x/icon8.png" alt=""></span>重置</el-button>
                    <el-button v-if="IsSearch" :class="{right_:true}" type="primary" @click="toggle"><span class="shiIcon"><img src="../../../assets/img/1x/icon5.png" alt=""></span>筛选</el-button>
                    </span>
                        <el-checkbox v-model="status" true-label="1" false-label="0">显示禁用${tableDesc}</el-checkbox>
                    </span>
                </el-col>
            </el-row>

         <!--   <el-dialog title="导入文件" -->
              <!--         :visible.sync="dialogTableVisible${beanName}Upload"> -->
            <!--    <tableCom${beanName}Upload v-on:childEvent${beanName}Upload="showChildMsg${beanName}Upload"/> -->
         <!--   </el-dialog> -->


            <!--列表-->
            <template>
                <el-table :data="${firstBeanName}List" highlight-current-row v-loading="listLoading" @selection-change="selsChange" stripe
                          style="width: 100%;">
                    <el-table-column type="selection" width="55"></el-table-column>
                    <el-table-column label="操作" width="150" :show-overflow-tooltip="true">
                        <template slot-scope="scope">
                            <router-link :to="{path:'/add${beanName}',query: { id: scope.row.id}}">
                                <a href="#" style="color:#E1670B">编辑</a>
                            </router-link>
                        </template>
                    </el-table-column>
                    <#list propertysAndColumnInfos as propertysAndColumnInfo>
                      <#if propertysAndColumnInfo.propertyName!="delFlag" && propertysAndColumnInfo.propertyName !="createTime"
                          && propertysAndColumnInfo.propertyName !="id" && propertysAndColumnInfo.propertyName != "companyId"
                          && propertysAndColumnInfo.propertyName != "ims" && propertysAndColumnInfo.propertyName != "imgName"
                          && propertysAndColumnInfo.propertyName != "status" && propertysAndColumnInfo.propertyName != "shfdaFlag"
                          && propertysAndColumnInfo.propertyName != "updateTime" && propertysAndColumnInfo.propertyName != "operator"
                      && propertysAndColumnInfo.propertyName != "updateUser" && propertysAndColumnInfo.propertyName != "delUser"
                      && propertysAndColumnInfo.propertyName != "delTime" && propertysAndColumnInfo.propertyName != "createUser"
                      >
                          <el-table-column prop="${propertysAndColumnInfo.propertyName}" label="${propertysAndColumnInfo.columnRemarks}" min-width="100" :show-overflow-tooltip="true">
                          </el-table-column>
                      </#if>
                    </#list>

                </el-table>
                <!--工具条／-->
                <el-col :span="24" class="toolbar">
                    <el-pagination
                            @size-change="handleSizeChange"
                            @current-change="handleCurrentChange"
                            :current-page="1"
                            :page-sizes="[15, 30, 60, 100]"
                            :page-size="pageSize"
                            layout="total, sizes, prev, pager, next, jumper"
                            :total="total"
                            style="float:right;">
                    </el-pagination>
                </el-col>
            </template>
        </section>
    </template>
    <script>
        ${r'import'}  API from '../../../api';
        ${r'import'}  {Message} from 'element-ui';
        ${r'export '} ${r'default '}  {
            data() {
            ${r'return '}   {
                    dialogTableVisible${beanName}Upload:false,
                    IsSearch:true,
                    fileUrl: API.ROOT + API.DOWNLOAD_${upcaseBeanName}, // 获取模板
                    total: 0,
                    key: '',
                    status:0, // 是否禁用
                    loading: false,
                    page: 1,
                    pageSize: 15,
                    listLoading: '',
                    ${firstBeanName}List: [],
                    sels: [],//列表选中列
                }
            },
            created(){

            },
            methods: {
                showList:function(){
                    this.IsSearch = true;
                },
                UP:function(){
                    this.IsSearch = false;
                },
                resets(){
                    this.key = '';
                    this.status = 0;
                    this.init();
                },
                //  当前页的条数
                handleSizeChange(val) {
                    this.pageSize = val;
                    this.init();
                },
                //  当前的页数改变
                handleCurrentChange(val) {
                    this.page = val;
                    this.init();
                },
                // 选择的数量
                selsChange: function (sels) {
                    this.sels = sels;
                },
                init(){
                    this.listLoading = true;
                ${r'let '}  param = {
                        key:this.key,
                        page: this.page,
                        num: this.pageSize,
                        status:this.status
                    };
                    this.$http.post(API.${upcaseBeanName}_LIST, param,).then(
                        res ${r' => '} {
                        this.total = res.data.total;
                        this.${firstBeanName}List = res.data.list;
                        this.listLoading = false;

                        }
                        )
                },
                //批量删除
                batchRemove: function () {
                    if(this.sels.length == 0){
                        this.$message({
                            message: '请先选择要删除的记录！',
                            type: 'warning'
                        });
                    }else{
                        this.$confirm('确认删除选中记录吗？', '提示', {
                            type: 'warning'
                        }).then(()${r' => '} {
                            this.listLoading = true;
                        var a=new Array();
                        this.sels.map(item => {
                            a.push(item.id)
                    });
                        this.$http.delete(API.DELETE_${upcaseBeanName} + "/" + a)
                                .then(res ${r' => '} {
                            this.$message({
                            message: '删除成功',
                            type: 'success'
                        });
                        this.handleCurrentChange();
                        this.listLoading = false;
                    })

                    });
                    }
                },
                //关闭上传页面
                showChildMsg${beanName}Upload(){
                    this.handleCurrentChange();
                    this.dialogTableVisible${beanName}Upload = false;

                },

            },
            mounted:function() {
                this.$nextTick(function () {
                    this.init();
                });
            },
        }
    </script>
    <style scoped="scoped">
        .el-dropdown {
            padding: 0!important;
        }
        .underline {
            text-decoration: none!important;
            color: #3C5B88;
        }
    </style>
