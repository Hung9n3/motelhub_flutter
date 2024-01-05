import 'package:dio/dio.dart';

abstract class BaseState {
  final Exception? error;
  const BaseState({this.error});
}

class ErrorState extends BaseState {
  ErrorState(Exception? error) : super(error: error);
} 