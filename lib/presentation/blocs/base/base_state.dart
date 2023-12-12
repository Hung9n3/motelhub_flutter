import 'package:dio/dio.dart';

abstract class BaseState {
  final DioError? error;
  const BaseState({this.error});
}

class ErrorState extends BaseState {
  ErrorState(DioError? error) : super(error: error);
} 