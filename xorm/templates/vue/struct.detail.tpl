<template>
    <div>
       {{range .Tables}}{{$table := .}}{{range .Columns}}
       <el-row>
         <el-col :span="8">
         <span>{{Mapper .Name}}:</span>
         <span>{{`{{result.`}}{{.Name }}{{`}}`}}</span>
         </el-col>
       </el-row>
    {{end}}  {{end}}
   </div>
</template>
<script>
    import marked from 'marked'
    export default {
         data () {
            return {
              result:{}
            }
        },
        created(){
            this.load()
        },
        methods: {
            load(){
            this.axios.get('/gongfa/'+this.$route.params.id,).then(res=>{
                // console.log(res)
                this.result=res.result
            })
            },
        },
         computed:{
            markedIntro:function(){
             if(this.result.intro==null) return ""
              return marked(this.result.intro)
            }
        }
    }
</script>
<style lang="less">
</style>