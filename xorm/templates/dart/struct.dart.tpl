
{{range .Tables}}
import 'package:loading_more_list/loading_more_list.dart';
import '../config/application.dart';

class {{Mapper .Name}} {
{{$table := .}}
{{range .Columns}} {{DartType .}} {{Mapper .Name|UnTitle }};
{{end}}
{{Mapper .Name}}({ {{range .Columns}} this.{{Mapper .Name|UnTitle}},{{end}} });

factory {{Mapper .Name}}.fromJson(Map<String, dynamic> json) {
    return {{Mapper .Name}}(
    	{{range .Columns}} {{Mapper .Name|UnTitle}}: json['{{.Name}}'],
        {{end}});
  }

}

Future<{{Mapper .Name}}> getDetail(int id) async {
  {{Mapper .Name}} data;
  await application.dio.get<String>('/faction/$id').then((res) {
    var rmodel = parseJson(res.data);

    data = {{Mapper .Name}}.fromJson(rmodel.data);
  });
  return data;
}

class {{Mapper .Name}}Repository extends LoadingMoreBase<{{Mapper .Name}}> {
  int pageIndex = 1;

  bool _hasMore = true;

  bool get hasMore => _hasMore;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    pageIndex = 1;
    _hasMore = true;
    var result = await super.refresh(true);

    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    bool _isSuccess = false;

    await application.dio.post<String>("/{{Mapper .Name}}", data: {
      "page_size": defaultPageSize,
      "page_index": pageIndex
    }).then((res) {
      var rmodel = parseJson(res.data);

      if (pageIndex == 1) this.clear();
      if (rmodel.success) {
        rmodel.data['data'].forEach((item) {
          this.add({{Mapper .Name}}.fromJson(item));
        });
        if (this.length < rmodel.data['total']) {
          _hasMore = true;
          pageIndex++;
        } else {
          _hasMore = false;
        }

        _isSuccess = true;
      }
    });
    return _isSuccess;
  }
}

{{end}}

