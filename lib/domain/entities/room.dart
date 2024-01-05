import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';

class RoomEntity extends Equatable {
  final int? id;
  final String? name;
  final int? areaId;
  final bool isEmpty;
  final double? acreage;
  final String? areaName;
  final List<PhotoEntity>? photos;
  
  const RoomEntity(
      {this.id, this.name, this.areaId, this.isEmpty = false, this.acreage, this.photos, this.areaName});

  @override
  List<Object?> get props {
    return [id, name, areaId, isEmpty, acreage, photos, areaName];
  }

  static RoomEntity getEntity(RoomEntity entity, List<PhotoEntity>? photo){
    return RoomEntity(id: entity.id, name: entity.name, acreage: entity.acreage, areaId: entity.areaId, isEmpty: entity.isEmpty, photos: entity.photos);
  }

  static List<RoomEntity> getFakeData() {
    List<RoomEntity> roomList = [];

    // Creating 20 rooms with areaId = 1
    for (int i = 1; i <= 20; i++) {
      RoomEntity room = RoomEntity(
        id: i,
        name: 'Room $i',
        areaId: 1,
        isEmpty: i%3 == 0,
        acreage: 12.0,
      );
      roomList.add(room);
    }

    // Creating 30 rooms with areaId = 2
    for (int i = 21; i <= 50; i++) {
      RoomEntity room = RoomEntity(
        id: i,
        name: 'Room $i',
        areaId: 2,
        isEmpty: i%4 != 0,
        acreage: 15.0,
      );
      roomList.add(room);
    }

    return roomList;
  }
}
