import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:dio/dio.dart';

abstract class MyAreaState extends Equatable{
  final List<AreaEntity>? data;
  final DioError? error;

  const MyAreaState({this.data, this.error});

  @override
  List<Object> get props => [data!, error!];
}

class MyAreaLoadingState extends MyAreaState{
  const MyAreaLoadingState();
}

class MyAreaDoneState extends MyAreaState{
  const MyAreaDoneState(List<AreaEntity> data) : super(data: data);
}

class MyAreaError extends MyAreaState {
  const MyAreaError(DioError error) : super(error: error);
}