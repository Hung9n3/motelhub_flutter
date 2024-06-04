import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:dio/dio.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';

abstract class MyAreaState extends Equatable{
  final List<AreaEntity>? data;
  final List<RoomEntity>? customerData;
  final String? error;

  const MyAreaState({this.data, this.error, this.customerData});

  @override
  List<Object> get props => [data!, error!];
}

class MyAreaLoadingState extends MyAreaState{
  const MyAreaLoadingState();
}

class MyAreaDoneState extends MyAreaState{
  const MyAreaDoneState(List<AreaEntity> data, List<RoomEntity> customerData) : super(data: data, customerData: customerData);
}

class MyAreaError extends MyAreaState {
  const MyAreaError(String? error) : super(error: error);
}