import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/appointment.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';

var baseUrl = 'https://10.0.2.2:7128/api';

class Api {
  static Uri createUrl(String endpoint) {
    var url = Uri.parse('$base64Url/$endpoint');
    return url;
  }

  static Future post(Object body, String url) async {
    var destination = createUrl(url);
    final response = await http.post(destination,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    return response;
  }

  static Future get(String url) async {
    var destination = createUrl(url);
    final response = await http.get(destination);
    return response;
  }

  static Future update(Object body, String url) async {
    var destination = createUrl(url);
    final response = await http.put(destination,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    return response;
  }

  static Future delete(String url) async {
    var destination = createUrl(url);
    final response = await http.delete(destination);
    return response;
  }

  static Future login(String? username, String? password) async {
    final response = post(
        jsonEncode(<String, String>{
          'username': username ?? '',
          'password': password ?? ''
        }),
        'Auth/login');
    return response;
  }

  static Future register(Map<String, dynamic> jsonData) async {
    final response = await post(jsonEncode(jsonData), 'Auth/register');
    return response;
  }

  static Future<List<AreaEntity>> getAreas() async {
    final response = await get('Area');
    var data = jsonDecode(response.body);
    List<AreaEntity> areas = [];
    for (var a in data) {
      AreaEntity entity = AreaEntity.fromJson(a);
      areas.add(entity);
    }
    return areas;
  }

  static Future<List<RoomEntity>> getRooms() async {
    final response = await get('Room');
    var data = jsonDecode(response.body);
    List<RoomEntity> result = [];
    for (var item in data) {
      RoomEntity entity = RoomEntity.fromJson(item);
      result.add(entity);
    }
    return result;
  }

  static Future<List<WorkOrderEntity>> getWorkOrders() async {
    final response = await get('WorkOrder');
    var data = jsonDecode(response.body);
    List<WorkOrderEntity> result = [];
    for (var item in data) {
      WorkOrderEntity entity = WorkOrderEntity.fromJson(item);
      result.add(entity);
    }
    return result;
  }
  
  static Future<List<ContractEntity>> getContracts() async {
    final response = await get('Contract');
    var data = jsonDecode(response.body);
    List<ContractEntity> result = [];
    for (var item in data) {
      ContractEntity entity = ContractEntity.fromJson(item);
      result.add(entity);
    }
    return result;
  }
  
  static Future<List<BillEntity>> getBills() async {
    final response = await get('Bill');
    var data = jsonDecode(response.body);
    List<BillEntity> result = [];
    for (var item in data) {
      BillEntity entity = BillEntity.fromJson(item);
      result.add(entity);
    }
    return result;
  }
  
  static Future<List<PhotoEntity>> getPhotos() async {
    final response = await get('Photo');
    var data = jsonDecode(response.body);
    List<PhotoEntity> result = [];
    for (var item in data) {
      PhotoEntity entity = PhotoEntity.fromJson(item);
      result.add(entity);
    }
    return result;
  }
  
  static Future<List<AppointmentEntity>> getAppointments() async {
    final response = await get('Appointment');
    var data = jsonDecode(response.body);
    List<AppointmentEntity> result = [];
    for (var item in data) {
      AppointmentEntity entity = AppointmentEntity.fromJson(item);
      result.add(entity);
    }
    return result;
  }
  
  static DataState<T> getResult<T>(dynamic httpResponse) {
    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataSuccess(httpResponse.data);
    } else {
      final response = Response(
        statusCode: httpResponse.response.statusCode,
        data: {'message': httpResponse.data},
        requestOptions: RequestOptions(path: '/api/endpoint'),
      );

      final error = DioError(
        response: response,
        requestOptions: RequestOptions(path: '/api/endpoint'),
      );

      return DataFailed.onEx(error.message);
    }
  }
}
