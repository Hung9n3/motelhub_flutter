import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';

class RoomEntity{
   int? id;
   int? areaId;
   int? customerId;
   String? name;
   double? acreage;
   bool isEmpty;
   String? address;
   String? areaName;
   String? ownerName;
   String? ownerPhone;
   String? ownerEmail;
   DateTime? contractFrom;
   DateTime? contractTo;
   UserEntity? owner;
   List<UserEntity>? members;
   List<PhotoEntity>? photos;
   List<ContractEntity>? contracts;
   List<WorkOrderEntity>? workOrders;
   double? price;

  RoomEntity(
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
      this.customerId,
      this.ownerEmail,
      this.ownerName,
      this.ownerPhone,
      this.contractFrom, this.contractTo, });

  factory RoomEntity.fromJson(Map<String, dynamic> map) {
    return RoomEntity(
      id: map['id'] ?? 0,
      areaId: map['areaId'] ?? 0,
      customerId: map['customerId'],
      name: map['name'] ?? 0,
      acreage: double.tryParse(map['acreage'].toString()) ?? 0.0,
      price: map['price'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id ?? '0',
        'areaId': areaId == 0 ? null : areaId,
        'customerId':customerId == 0 ? null : customerId,
        //'photos': photos ?? [],
        'name': name ?? '',
        'acreage': acreage ?? 0.0,
        'price': price ?? 0.0,
      };

  static List<RoomEntity> getFakeData() {
    List<RoomEntity> roomList = [];

    // Creating 20 rooms with areaId = 1
    for (int i = 1; i <= 20; i++) {
      RoomEntity room = RoomEntity(
        id: i,
        name: 'Room $i',
        areaId: 1,
        isEmpty: false,
        customerId: i,
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
