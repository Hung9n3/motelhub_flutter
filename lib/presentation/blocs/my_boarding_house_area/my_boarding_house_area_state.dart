import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/boarding_house_area.dart';
import 'package:dio/dio.dart';

abstract class MyBoardingHouseAreaState extends Equatable{
  final List<BoardingHouseAreaEntity>? data;
  final DioError? error;

  const MyBoardingHouseAreaState({this.data, this.error});

  @override
  List<Object> get props => [data!, error!];
}

class MyBoardingHouseAreaLoadingState extends MyBoardingHouseAreaState{
  const MyBoardingHouseAreaLoadingState();
}

class MyBoardingHouseAreaDoneState extends MyBoardingHouseAreaState{
  const MyBoardingHouseAreaDoneState(List<BoardingHouseAreaEntity> data) : super(data: data);
}

class MyBoardingHouseAreaError extends MyBoardingHouseAreaState {
  const MyBoardingHouseAreaError(DioError error) : super(error: error);
}