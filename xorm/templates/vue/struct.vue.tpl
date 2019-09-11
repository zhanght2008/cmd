<template>
  <div>
   <el-table :data="result.data">
    {{range .Tables}}{{$table := .}}{{range .Columns}} 
     <el-table-column label="{{Mapper .Name|UnTitle }}"  prop="{{.Name }}" />
    {{end}}{{end}}   
    </el-table>
   <el-pagination
      :hide-on-single-page=true
      :total="result.total"
      :page-size="result.page_size"
      @current-change="handlePage"
    />
  </div>  
</template>
<script>
export default {
  data() {
    return {
     result: {total:0,page_size:20,page_index:1}
    };
  },
  computed: {
  },
  created() {
    this.load();
  },
  methods: {
    load() {
       this.axios.post("/", {        
            page_index: this.result.page_index,
            page_size: this.result.page_size,           
        }).then(res => {
         if (res.status == 200) {
            this.result = res.result;
          }
        });
    },

    handlePage(_index) {
      this.result.page_index=_index
      this.load()
    }
  }
};
</script>
<style lang="less">
</style>







