import 'package:dio/dio.dart';

abstract class BaseState {
  final String? error;
  const BaseState({this.error});
}

class ErrorState extends BaseState {
  ErrorState(String? error) : super(error: error);
} 