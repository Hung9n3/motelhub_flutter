import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';

abstract class AddRoomEvent{
  final String? textValue;
  const AddRoomEvent({this.textValue});
}

class LoadingFormEvent extends AddRoomEvent{
  final int? selectedAreaId;
  const LoadingFormEvent({this.selectedAreaId});
}

class ChangeRoomNameEvent extends AddRoomEvent{
  ChangeRoomNameEvent(String roomName) : super(textValue: roomName);
}

class ChangeAreaEvent extends AddRoomEvent{
  AreaEntity? selectedArea;
  ChangeAreaEvent(this.selectedArea);
}

class ChangeAcreageEvent extends AddRoomEvent{
  ChangeAcreageEvent(String acreage) : super(textValue: acreage);
}

class AddRoomOnSubmitButtonPressed extends AddRoomEvent{
  const AddRoomOnSubmitButtonPressed();
}