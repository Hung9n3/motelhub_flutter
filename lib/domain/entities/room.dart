import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  final int? id;
  final String? name;
  final int? areaId;
  final bool? isEmpty;
  final double? acreage;
  const RoomEntity(
      {this.id, this.name, this.areaId, this.isEmpty, this.acreage});

  @override
  List<Object?> get props {
    return [id, name, areaId, isEmpty];
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
