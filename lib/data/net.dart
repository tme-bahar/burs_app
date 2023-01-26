
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import '../models/predict_model.dart';
import 'local.dart';
import "package:async/async.dart";

class Net{

  static const requestUrl = "https://extraordinary-nasturtium-2e067c.netlify.app/";
  static const uploadUrl = 'http://tmebahar.ir/';
  static const uploadProgrammingPath = 'kargah/upload.php';
  static const globalFileName = 'outfile.json';

  static Future<bool> emptyRequest(String URL,) async{
    var uri = Uri.parse(URL);
    var request =  MultipartRequest("GET", uri);
    var respond = await request.send();
    print(respond.statusCode==200 ? 'successes' : 'Failed');
    return respond.statusCode==200;
  }

  static Future afterUpload(PredictModel current,VoidCallback viewEffect) async{
    await emptyRequest(requestUrl);
    String? data = await mainRequest(requestUrl + globalFileName);
    LocalData.saveLocal(data, current, viewEffect);
  }


  static Future<String?> mainRequest(String URL) async{

    var uri = Uri.parse(URL);

    var request =  MultipartRequest("GET", uri);

    var respond = await request.send();
    if(respond.statusCode==200){
      print("successes");
      List l = await respond.stream.toStringStream().toList();
      String s = '';
      for(String str in l) {
        s = s + str;
      }
      return s;
    }else{
      print("Failed");
      print(respond.toString());
      return null;
    }
  }

  static Future addProduct(File imageFile) async{
    var stream= ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length= await imageFile.length();
    var uri = Uri.parse(uploadUrl+uploadProgrammingPath);

    var request =  MultipartRequest("POST", uri);
    print(imageFile.path);

    var multipartFile =  MultipartFile("image", stream, length, filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var respond = await request.send();

    print(respond.statusCode==200?"Image Uploaded":"Upload Failed");
  }
}