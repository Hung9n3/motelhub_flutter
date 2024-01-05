import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';

abstract class AddRoomEvent{
  final String? textValue;
  final FormMode? mode;
  final int? selectedAreaId;
  const AddRoomEvent({this.textValue, this.mode, this.selectedAreaId});
}

class LoadingFormEvent extends AddRoomEvent{
  const LoadingFormEvent(int selectedAreaId, FormMode mode) : super(selectedAreaId: selectedAreaId, mode: mode);
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