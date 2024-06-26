import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

class ContractEntity  {
   int? id;
   int? customerId;
   String? name;
   int? roomId;
   int? hostId;
   double? roomPrice;
   DateTime? startDate;
   DateTime? endDate;
   DateTime? cancelDate;
   UserEntity? owner;
   RoomEntity? roomEntity;
   List<BillEntity>? bills;
   Uint8List? signature;
  ContractEntity(
      {this.id,
      this.hostId,
      this.customerId,
      this.roomId,
      this.name,
      this.roomPrice,
      this.bills = const [],
      this.owner,
      this.roomEntity,
      this.startDate,
      this.endDate,
      this.cancelDate,
      this.signature});
  
  factory ContractEntity.fromJson(Map<String, dynamic> map) {
    return ContractEntity(
      id: map['id'] ?? 0,
      roomId: map['roomId'],
      customerId: map['customerId'] ?? 0,
      roomPrice: map['price'] ?? 0.0,
      name: map['title'] ?? '',
      startDate: DateTime.parse(map['startDate'] ?? '').toLocal(),
      endDate: DateTime.parse(map['endDate'] ?? '').toLocal(),
      cancelDate: map['cancelDate'] == null ? null : DateTime.parse(map['cancelDate']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id ?? '0',
      'roomId': roomId,
      'customerId': customerId == 0 ? null : customerId,
      'price': roomPrice ?? '0.0',
      'title': name ?? '',
      'startDate': startDate != null ? DateFormat("yyyy-MM-dd").format(startDate!.toUtc()).toString() : null,
      'endDate': endDate != null ? DateFormat("yyyy-MM-dd").format(endDate!.toUtc()).toString() : null,
      'cancelDate': cancelDate != null ? DateFormat("yyyy-MM-dd").format(cancelDate!.toUtc()).toString() : null,
  };

  static List<ContractEntity> getFakeData() {
    var result = <ContractEntity>[];
    for (int i = 1; i <= 5; i++) {
      result.add(ContractEntity(
          id: i,
          roomId: i,
          customerId: i,
          owner: UserEntity.getFakeData()
              .where((element) => element.id == i)
              .firstOrNull,
          startDate: DateTime.now().add(const Duration(days: 2)),
          endDate: DateTime.now().add(const Duration(days: 365)),
          cancelDate: DateTime.now().add(const Duration(days: 200))
          ));
    }
    return result;
  }

  static List<ContractEntity> contracts = [];
}
