import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';

class AddRoomState extends Equatable{
  final List<AreaEntity>? areas;
  final String? areaName;
  final int? selectedAreaId;
  const AddRoomState({this.areas, this.areaName, this.selectedAreaId});
  
  @override
  List<Object?> get props => [areas, areaName];
}

class LoadingFormState extends AddRoomState {
  const LoadingFormState();
}

class LoadingFormStateDone extends AddRoomState{
  const LoadingFormStateDone(List<AreaEntity>? areas, String? areaName, int? selectedAreaId) 
  : super(areas: areas, areaName: areaName, selectedAreaId: selectedAreaId);
}