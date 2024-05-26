import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:motelhub_flutter/domain/entities/area.dart';

var url = 'https://10.0.2.2:7128/api/';
class Api {
  static Uri createUrl(String controller){
    var _url = Uri.parse(url + controller);
    return _url;
  }
  static Future post(Object body, Uri url) async {
    final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    body: body);
    return response;
  }
  static Future get(Uri url) async {
    final response = await http.get(url);
    return response;
}
static Future update(Object body,Uri url) async {
    final response = await http.put(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: body
    );
    return response;
}
static Future delete(Uri url) async {
    final response = await http.delete(url);
    return response;
}

static Future login(String? username, String? password) async {
  var _url = Uri.parse(url + 'Auth');
    final response = await http.post(
      (_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': username ?? '',
        'password': password ?? '',
      }),);
    return response;
} 

static Future<List<AreaEntity>> getAreas() async{
    var _url = createUrl('Area');
    final response = await get(_url);
    var data = jsonDecode(response.body);
    List<AreaEntity> areas = [];
    for(var a in data)
      {
        AreaEntity classGet = AreaEntity.fromJson(a);
        areas.add(classGet);
      }
    return areas;
  }
}