import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/data_day_model.dart';
import '../models/predict_day_model.dart';
import '../models/predict_model.dart';

class LocalData {
  static const List<String> L1 = ['80','75','70'];
  static const List<String> L2 = ['95','90','85'];
  static const localFileName = 'database.json';
  static String getPatternFileName (String str) => 'file$str.json';
  static String getFileName (int i) => getPatternFileName(i.toString());

  static Future<List<PredictModel>> getLocalData() async{
    FileStorage data = FileStorage(name:localFileName);
    String? ss = await data.read();

    Map dataMap = ss == null || ss.trim().isEmpty ? emptyMap :json.decode(ss);
    List<PredictModel> result = List.empty(growable: true);
    for(String v in (dataMap['data'] as Map<dynamic,dynamic>).keys)
    {
      List<DataDayModel> models = List.empty(growable: true);
      FileStorage fs = FileStorage(name: getFileName(dataMap['data'][v]['index']));

      Map all;
      String? s = await fs.read();
      if(s == null || s.isEmpty) {
        continue;
      }
      all = json.decode(await fs.read()??'{}');
      for(Map da in all['data']){
        models.add(DataDayModel(index : da['index'],main: double.parse(da['main'].toString()), name: da['name']));
      }
      for(Map pr in all['predicts']){
        models.add(PredictDayModel(index : pr['index'],main: pr['main'], name: pr['name'],
            min95: pr['l1_lower'],min80: pr['l2_lower'],max80: pr['l1_upper'],max95: pr['l2_upper']));
      }
      Map thisMap = dataMap['data'][v];
      result.add(PredictModel(models.reversed.toList(), name: v,
          index: thisMap['index'],t: int.parse(thisMap['type'].toString()),c: thisMap['c'],p: thisMap['p'],
          L2i: findL2(thisMap['L2'].toString()),L1i:findL1( thisMap['L1'].toString()),
          filePath: thisMap['path']
      ));
    }
    //print('length2 : ${result.length}');
    return result;
  }

  static Future saveLocal(String? data,PredictModel current,VoidCallback viewEffect,BuildContext context) async{
    data = betterData(data??'""');
    FileStorage dataBase = FileStorage(name:LocalData.localFileName);
    print('database');
    String? s = await dataBase.read();
    Map dataMap;
    dataMap = s == null || s.trim().isEmpty ? {"info":{"count" : 0},"data" : {}} :json.decode(s);
    print(await dataBase.read());
    int index = dataMap['info']['count'];
    dataMap['info']['count'] = ++dataMap['info']['count'];
    dataMap['data'][current.name] = {'index':index,'p':current.p,'c':current.c,'type':current.t,'L1':current.L1i,'L2':current.L2i,'path':current.filePath};
    dataBase.write(json.encode(dataMap));
    try{
      jsonDecode(data);
      FileStorage self = FileStorage(name: 'file$index.json');
      self.write(data);
      viewEffect();
      print(await dataBase.read());
      print(data);
    }catch(x){
      showSnack('سرور با خطا مواجه شده است', context);
    }

  }

  static String betterData(String str){
    StringBuffer sb = StringBuffer();
    for(int i = 1; i < str.length-1; i++) {
      if(str[i] != '\\') {
        sb.write(str[i]);
      }
    }
    return sb.toString();
  }

  static const Map emptyMap = {"info":{"count" : 0},"data" : {}};

  static int findL1(String i)=> L1.indexWhere((element) => element == i);
  static int findL2(String i)=> L2.indexWhere((element) => element == i);

  static void clearAll(int n){
    clearFile(localFileName);
    FileStorage fs = FileStorage(name: localFileName);
    fs.write('');
    for(int i = 0; i < n ;i++) {
      clearFile(getFileName(i));
    }

  }
  static void clearFile(String name){
    FileStorage fs = FileStorage(name: name);
    fs.write('');
  }

  static Future deletePr(String name,BuildContext context)async{
    FileStorage data = FileStorage(name:localFileName);
    String? ss = await data.read();

    Map dataMap = ss == null || ss.trim().isEmpty ? emptyMap :json.decode(ss);
    dataMap['data'].removeWhere((key, value) => key == name);
    data.write(json.encode(dataMap));
    showSnack('$name حذف شد', context);
    print('$name deleted');
  }
  static void showSnack(String text,BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
class FileStorage {
  final String name;

  FileStorage({required this.name});

  Future<String> get _localPath async => (await getApplicationDocumentsDirectory()).path;

  Future<File> get _localFile async => File('${await _localPath}/$name');


  Future<File> write(String text) async => (await _localFile).writeAsString(text);

  Future<String?> read() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future rename(String newName) async{
    File f = await _localFile;
    print('Original path: ${f.path}');
    String dir = dirname(f.path);
    String newPath = join(dir, newName);
    print('NewPath: ${newPath}');
    f.renameSync(newPath);
  }

}