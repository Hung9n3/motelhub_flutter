import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/boarding_house_area.dart';

abstract class MyBoadingHouseAreaEvent extends Equatable{
  const MyBoadingHouseAreaEvent();

  @override
  List<Object> get props => [];
}

class GetMyBoardingHouseAreaEvent extends MyBoadingHouseAreaEvent{
  const GetMyBoardingHouseAreaEvent();
}

class DeleteMyBoardingHouseAreaEvent extends MyBoadingHouseAreaEvent{
  final BoardingHouseAreaEntity? entity;
  const DeleteMyBoardingHouseAreaEvent({this.entity});
}