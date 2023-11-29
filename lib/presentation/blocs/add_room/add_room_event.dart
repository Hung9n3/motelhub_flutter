import 'package:equatable/equatable.dart';

abstract class AddRoomEvent{
  final String? textValue;
  const AddRoomEvent({this.textValue});
}

class LoadingFormEvent extends AddRoomEvent{
  const LoadingFormEvent();
}

class ChangeRoomNameEvent extends AddRoomEvent{
  ChangeRoomNameEvent(String roomName) : super(textValue: roomName);
}

class ChangeAreaEvent extends AddRoomEvent{
  int? selectedAreaId;
  ChangeAreaEvent(this.selectedAreaId);
}

class ChangeAcreageEvent extends AddRoomEvent{
  ChangeAcreageEvent(String acreage) : super(textValue: acreage);
}

class SubmitButtonPressed extends AddRoomEvent{

}