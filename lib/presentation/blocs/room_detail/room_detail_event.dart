import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

abstract class RoomDetailEvent {
  final int? roomId;
  final UserEntity? customer;
  final String? name;
  final String? acreage;
  final List<PhotoEntity>? photos;
  const RoomDetailEvent({this.roomId, this.name, this.acreage, this.photos, this.customer});
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

class ChangeOwnerEvent extends RoomDetailEvent {
  const ChangeOwnerEvent(UserEntity? owner) : super(customer: owner);
}

class SubmitFormEvent extends RoomDetailEvent {
  const SubmitFormEvent(List<PhotoEntity>? photos) 
  : super(photos: photos);
}