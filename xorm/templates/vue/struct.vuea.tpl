<template>
    <el-form ref="form" :model="form" :rules="ruleform" >
       {{range .Tables}}{{$table := .}}{{range .Columns}}
        {{if (Mapper .Name) ne "Version"}}
        <el-form-item label="{{Mapper .Name}}" prop="{{Mapper .Name|UnTitle }}">
            <el-input type="text" v-model="form.{{Mapper .Name|UnTitle }}"  placeholder="请输入"/>
        </el-form-item>{{end}}{{end}}
        <el-form-item>
            <el-button type="primary" @click="handleSubmit('form')">保存</el-button>
            <el-button @click="handleReset('form')" style="margin-left: 8px">清空</el-button>
        </el-form-item>
        {{end}}
    </el-form>
</template>
<script>
    export default {
        data () {
            return {
                form: { {{range .Tables}}{{$table := .}}{{range .Columns}}
                    {{Mapper .Name|UnTitle }}:"",{{end}}{{end}}
                },
                ruleform: { {{range .Tables}}{{$table := .}}{{range .Columns}}
                    {{Mapper .Name|UnTitle }}: [
                        { required: true, message: "{{Mapper .Name}}不能为空", trigger: 'blur' }
                    ],{{end}}{{end}}                    
                }
            }
        },
        methods: {
            handleSubmit (name) {
                this.$refs[name].validate((valid) => {
                    if (valid) {
                    	
                    } else {
                       
                    }
                })
            },
            handleReset (name) {
                this.$refs[name].resetFields();
            }
        }
    }
</script>
<style lang="less">
</style>