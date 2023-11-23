import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';

abstract class MyAreaEvent extends Equatable{
  const MyAreaEvent();

  @override
  List<Object> get props => [];
}

class GetMyAreaEvent extends MyAreaEvent{
  const GetMyAreaEvent();
}

class DeleteMyBoardingHouseAreaEvent extends MyAreaEvent{
  final AreaEntity? entity;
  const DeleteMyBoardingHouseAreaEvent({this.entity});
}