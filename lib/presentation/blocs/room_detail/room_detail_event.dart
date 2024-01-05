import 'package:motelhub_flutter/domain/entities/photo.dart';

abstract class RoomDetailEvent {
  final int? roomId;
  final String? name;
  final String? acreage;
  final List<PhotoEntity>? photos;
  const RoomDetailEvent({this.roomId, this.name, this.acreage, this.photos});
}

class LoadFormDataEvent extends RoomDetailEvent {
  //Get room by Id including photos
  const LoadFormDataEvent(int roomId) : super(roomId: roomId);
}

class ChangeAcreageEvent extends RoomDetailEvent {
  const ChangeAcreageEvent(String acreage) : super(acreage: acreage);
}

class ChangeNameEvent extends RoomDetailEvent {
  const ChangeNameEvent(String name) : super(name: name);
}

class SubmitFormEvent extends RoomDetailEvent {
  const SubmitFormEvent(List<PhotoEntity> photos) 
  : super(photos: photos);
}