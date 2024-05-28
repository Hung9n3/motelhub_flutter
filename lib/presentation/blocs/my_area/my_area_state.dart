import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:dio/dio.dart';

abstract class MyAreaState extends Equatable{
  final List<AreaEntity>? data;
  final List<AreaEntity>? customerData;
  final DioError? error;

  const MyAreaState({this.data, this.error, this.customerData});

  @override
  List<Object> get props => [data!, error!];
}

class MyAreaLoadingState extends MyAreaState{
  const MyAreaLoadingState();
}

class MyAreaDoneState extends MyAreaState{
  const MyAreaDoneState(List<AreaEntity> data, List<AreaEntity> customerData) : super(data: data, customerData: customerData);
}

class MyAreaError extends MyAreaState {
  const MyAreaError(DioError error) : super(error: error);
}