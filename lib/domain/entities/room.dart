import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/electric.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/water.dart';

class RoomEntity extends Equatable {
  final int? id;
  final String? name;
  final int? areaId;
  final int? ownerId;
  final bool isEmpty;
  final double? acreage;
  final String? areaName;
  final String? ownerName;
  final String? ownerPhone;
  final String? ownerEmail;
  final UserEntity? owner;
  final List<ElectricEntity>? electrics;
  final List<WaterEntity>? waters;
  final List<UserEntity>? members;
  final List<PhotoEntity>? photos;
  final List<ContractEntity>? contracts;
  final double? price;

  const RoomEntity(
      {this.id,
      this.name,
      this.areaId,
      this.price,
      this.isEmpty = false,
      this.acreage,
      this.waters = const [],
      this.electrics = const [],
      this.photos = const [],
      this.members = const [],
      this.contracts = const [],
      this.areaName,
      this.owner,
      this.ownerId,
      this.ownerEmail,
      this.ownerName,
      this.ownerPhone});

  @override
  List<Object?> get props {
    return [id, name, areaId, isEmpty, acreage, electrics, photos, areaName, members, ownerName, ownerId];
  }

  static List<RoomEntity> getFakeData() {
    List<RoomEntity> roomList = [];

    // Creating 20 rooms with areaId = 1
    for (int i = 1; i <= 20; i++) {
      RoomEntity room = RoomEntity(
        id: i,
        name: 'Room $i',
        areaId: 1,
        isEmpty: false,
        ownerId: i,
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
        isEmpty: true,
        acreage: 15.0,
      );
      roomList.add(room);
    }

    return roomList;
  }
}
