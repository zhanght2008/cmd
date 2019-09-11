
{{range .Tables}}
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import '../components/basepage.dart';

import '../model/app_model.dart';
import '{{Mapper .Name|UnTitle}}_model.dart';

class {{Mapper .Name}}Page extends StatefulWidget {
  {{Mapper .Name}}Page({this.key}) : super(key: key);
  final Key key;
  @override
  State<StatefulWidget> createState() =>_{{Mapper .Name}}PageState();
}

class _{{Mapper .Name}}PageState extends BasePage<{{Mapper .Name}}Page> {
  {{Mapper .Name}}Repository repo;
  // @override
  Widget appbar([AppModel model]) {
    return AppBar(title: Text("我的徒弟"));
  }

  Widget body() {
    return LoadingMoreList(ListConfig<{{Mapper .Name}}>(
        itemBuilder: (BuildContext context, {{Mapper .Name}} item, int index) {
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.id.toString()),
            onTap: () {
              print(item.id);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Text('dd');
                },
              ));
            },
          );
        },
        sourceList: repo,
        padding: EdgeInsets.all(0.0)));
  }

  @override
  void initState() {
    repo = {{Mapper .Name}}Repository();
    super.initState();
  }

  @override
  void dispose() {
    repo?.dispose();
    super.dispose();
  }
}
{{end}}

