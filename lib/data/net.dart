///file name
//delete
///bound name
///pishbini baraye rooze ...
///Ayandeh app name
///?univercity

import 'dart:convert';
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import '../models/predict_model.dart';
import 'local.dart';
import "package:async/async.dart";

class Net{

  static const requestUrl = "https://30547eb9d0d2469291944c39816d4323.app.posit.cloud/echo";
  static const uploadUrl = 'http://tmebahar.ir/';
  static const uploadProgrammingPath = 'kargah/upload.php';
  static const globalFileName = 'outfile.json';
  static const cookie = 'http://tmebahar.ir/kargah/txt.txt';

  static Future parseHtml(String url,List<Cookie> cookies,BuildContext context,Function(String data) onData) async {
    print('body');
    HttpClient client = HttpClient();
    HttpClientRequest clientRequest =
    await client.getUrl(Uri.parse(url));
    for(Cookie c in cookies) {
      clientRequest.cookies.add(c);
    }
    showSnack('در حال ارسال درخواست ...', context);
    HttpClientResponse clientResponse = await clientRequest.close().catchError((e,r)=>
        showSnack('خطا در پاسخ', context));
    showSnack('پاسخ دریافت شد', context);
    final contents = StringBuffer();
    clientResponse.transform(utf8.decoder).listen((event)=> contents.write(event),onDone: ()=>onData(contents.toString()));
  }

  static Future getCookies (String url,Function(String data) onData) async{
    HttpClient client = HttpClient();
    HttpClientRequest clientRequest = await client.getUrl(Uri.parse(url));
    HttpClientResponse clientResponse = await clientRequest.close();
    final contents = StringBuffer();
    clientResponse.transform(utf8.decoder).listen((event)=> contents.write(event),onDone: ()=>onData(contents.toString()));
  }

  static List<Cookie> toCookie(String text){
    List<String> tag = ["session","therealshinyapps"];
    List<String> coo = text.split(';');
    return List.generate(2, (index) =>Cookie(tag[index], coo[index]));
  }

  static Future afterUpload(PredictModel current,VoidCallback viewEffect,BuildContext context) async =>
    await getCookies(cookie, (data) => parseHtml(requestUrl,  toCookie(data),context, (data) =>
        LocalData.saveLocal(data, current, viewEffect,context)));

  static String betterData(String str){
    StringBuffer sb = StringBuffer();
    for(int i = 1; i < str.length-1; i++) {
      if(str[i] != '\\') {
        sb.write(str[i]);
      }
    }
    return sb.toString();
  }


  static Future addProduct(File imageFile,BuildContext context) async{
    var stream= ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length= await imageFile.length();
    var uri = Uri.parse(uploadUrl+uploadProgrammingPath);

    var request =  MultipartRequest("POST", uri);
    print(imageFile.path);

    var multipartFile =  MultipartFile("image", stream, length, filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var respond = (await request.send().catchError((error, stackTrace)=>
      showSnack('خطا در افزودن!', context)
    ));
    showSnack('فایل ارسال شد', context);
    print(respond.statusCode==200?"Image Uploaded":"Upload Failed");
  }

  static void showSnack(String text,BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}