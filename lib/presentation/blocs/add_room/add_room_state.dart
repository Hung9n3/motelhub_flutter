import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';

class AddRoomState extends Equatable{
  final String? areaName;
  final String? message;
  const AddRoomState({ this.areaName, this.message});
  
  @override
  List<Object?> get props => [areaName];
}

class LoadingFormState extends AddRoomState {
  const LoadingFormState();
}

class LoadingFormStateDone extends AddRoomState{
  const LoadingFormStateDone(String? areaName) 
  : super(areaName: areaName);
}

class AddRoomError extends AddRoomState {
  const AddRoomError(String? message) : super(message: message);
}

class AddRoomSuccess extends AddRoomState {
  const AddRoomSuccess() : super();
}