import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';

abstract class AddRoomEvent{
  final String? textValue;
  final FormMode? mode;
  final int? selectedAreaId;
  final String? price;
  final List<PhotoEntity>? photos;
  const AddRoomEvent({this.textValue, this.mode, this.selectedAreaId, this.price, this.photos});
}

class LoadingFormEvent extends AddRoomEvent{
  const LoadingFormEvent(int selectedAreaId, FormMode mode) : super(selectedAreaId: selectedAreaId, mode: mode);
}

class ChangeRoomNameEvent extends AddRoomEvent{
  ChangeRoomNameEvent(String roomName) : super(textValue: roomName);
}

class ChangeAcreageEvent extends AddRoomEvent{
  ChangeAcreageEvent(String acreage) : super(textValue: acreage);
}

class AddRoomOnSubmitButtonPressed extends AddRoomEvent{
  AddRoomOnSubmitButtonPressed(String? price, List<PhotoEntity> photos) : super(price: price, photos: photos);
}