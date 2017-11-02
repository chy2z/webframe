<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="taglib/taglibs.jsp" %>
<%@ include file="taglib/import_iview.jsp" %>
<%@ include file="taglib/import_jquery.jsp" %>
<%@ include file="taglib/import_common.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">

    <Modal v-model="show" :mask-closable="false" :styles="{top: '20px'}" :width="500">
        <p slot="header" style="text-align:center">
            <Icon size="16" type="compose"></Icon>
            <span class="modal-title">1111</span>
        </p>
        <div>
        <i-Form ref="formValidate.bindmodel" :model="formValidate.bindmodel"
                :rules="formValidate.ruleValidate" :label-width="80">
            <Form-Item label="城市" prop="city">
                <i-Select v-model="formValidate.bindmodel.city" filterable="true"  placeholder="请选择所在地">
                        <i-Option v-for="item in cityList" :value="item.id" :key="item.id">{{ item.label }}</i-Option>
                </i-Select>
            </Form-Item>
            <FormItem>
                <i-Button type="primary" @click="handleSubmit('formValidate.bindmodel')">提交</i-Button>
                <i-Button type="ghost" @click="handleReset('formValidate.bindmodel')" style="margin-left: 8px">重置</i-Button>
            </FormItem>
        </i-Form>

        </div>
        <div slot="footer">

        </div>
    </Modal>


    <%--<div class="my-layout my-box-left">
        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col span="24"></i-col>
        </Row>
        <Row class-name="my-layout-body" justify="center" align="middle" type="flex">
            <i-col span="6">
                <i-Circle :percent="80">
                    <span class="demo-Circle-inner" style="font-size:24px">80%</span>
                </i-Circle>
            </i-col>
            <i-col span="6">
                <i-Circle :percent="80">
                    <span class="demo-Circle-inner" style="font-size:24px">80%</span>
                </i-Circle>
            </i-col>
            <i-col span="6">
                <i-Circle :percent="80">
                    <span class="demo-Circle-inner" style="font-size:24px">80%</span>
                </i-Circle>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col span="1"></i-col>
            <i-col span="23">
            </i-col>
        </Row>
    </div>--%>
</div>
</body>
<script>

    new Vue({
        el: '#app',
        data: {
            show:true,
            cityList: [
                {
                    id: 1,
                    label: '北京市'
                },
                {
                    id: 2,
                    label: '上海市'
                },
                {
                    id: 3,
                    label: '深圳市'
                }
            ],
            formValidate: {
                bindmodel:{
                    city:undefined
                },
                ruleValidate: {
                    city: [
                        { type:'number', required: true, message: '请选择城市', trigger: 'change' }
                    ]
                }
            }
        },
        methods: {
            handleSubmit (name) {
                this.$refs[name].validate((valid) => {
                    if (valid) {
                        this.$Message.success('提交成功!');
                    } else {
                        this.$Message.error('表单验证失败!');
                    }
                })
            },
            handleReset (name) {
                //this.$refs[name].resetFields();

                this.$refs["formValidate.bindmodel"].resetFields();

            },
            change(value){
                 alert(typeof value);
            }
        }
    });


/*    new Vue({
        el: '#app',
        data: {
            loading: false
        }
    });*/
</script>
</html>
