import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';

class RoomEntity extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final int? areaId;
  final int? ownerId;
  final bool isEmpty;
  final double? acreage;
  final String? areaName;
  final String? ownerName;
  final String? ownerPhone;
  final String? ownerEmail;
  final UserEntity? owner;
  final List<UserEntity>? members;
  final List<PhotoEntity>? photos;
  final List<ContractEntity>? contracts;
  final List<WorkOrderEntity>? workOrders;
  final double? price;

  const RoomEntity(
      {this.id,
      this.name,
      this.address,
      this.areaId,
      this.price,
      this.isEmpty = false,
      this.acreage,
      this.photos = const [],
      this.members = const [],
      this.contracts = const [],
      this.workOrders = const [],
      this.areaName,
      this.owner,
      this.ownerId,
      this.ownerEmail,
      this.ownerName,
      this.ownerPhone});

  @override
  List<Object?> get props {
    return [id, name, areaId, isEmpty, acreage, photos, workOrders, areaName, members, ownerName, ownerId];
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
        price: 1000000,
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
        price: 2500000,
        acreage: 15.0,
      );
      roomList.add(room);
    }

    return roomList;
  }
}
