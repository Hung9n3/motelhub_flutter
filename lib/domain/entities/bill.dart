import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';

class BillEntity {
   int? id;
   int? contractId;
   double? total;
   String? title;
   double? oweing;
   DateTime? startDate;
   DateTime? endDate;
   double? rentPrice;
   double? waterPrice;
   double? electricPrice;
   double? electricLast;
   double? electricCurrent;
   double? waterLast;
   double? waterCurrent;
   DateTime? waterFrom;
   DateTime? waterTo;
   DateTime? electricFrom;
   DateTime? electricTo;
   RoomEntity? room;
   List<PhotoEntity>? photos;

  BillEntity(
      {this.id,
      this.contractId,
      this.title,
      this.startDate,
      this.endDate,
      this.rentPrice,
      this.electricPrice,
      this.waterPrice,
      this.electricCurrent,
      this.electricFrom,
      this.electricLast,
      this.electricTo,
      this.waterCurrent,
      this.waterFrom,
      this.waterLast,
      this.waterTo,
      this.total,
      this.oweing,
      this.room,
      this.photos})
      : super();

  BillEntity copyWith(
      {id,
      hostId,
      contractId,
      waterId,
      electricId,
      total,
      title,
      owneing,
      startDate,
      endDate,
      rentPrice,
      room,
      water,
      electric}) {
    return BillEntity(
        id: id ?? this.id,
        contractId: contractId ?? this.contractId,
        total: total ?? this.total,
        title: title ?? this.title,
        oweing: owneing ?? this.oweing,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        rentPrice: rentPrice ?? this.rentPrice,
        room: room ?? this.room);
  }

  factory BillEntity.fromJson(Map<String, dynamic> map) {
    return BillEntity(
      id: map['id'] ?? 0,
      contractId: map['contractId'] ?? 0,
      title: map['title'] ?? '',
      rentPrice: map['rentPrice'] ?? 0.0,
      electricPrice: map['electricPrice'] ?? 0.0,
      waterPrice: map['waterPrice'] ?? 0.0,
      electricCurrent: map['electricCurrent'] ?? 0,
      electricLast: map['electricLast'] ?? 0,
      electricFrom: DateTime.parse(map['electricFrom']).toLocal(),
      electricTo: DateTime.parse(map['electricTo']).toLocal(),
      waterCurrent: map['waterCurrent'] ?? 0,
      waterLast: map['waterLast'] ?? 0,
      waterFrom: DateTime.parse(map['waterFrom']).toLocal(),
      waterTo: DateTime.parse(map['waterTo']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id ?? '0',
      'contractId': contractId,
      'title': title ?? '',
      'startDate': startDate?.toUtc(),
      'endDate': endDate?.toUtc(),
      'rentPrice': rentPrice ?? '0.0',
      'electricPrice': electricPrice ?? '0.0',
      'waterPrice': waterPrice ?? '0.0',
      'electricCurrent': electricCurrent ?? '0',
      'electricLast': electricLast ?? '0',
      'electricFrom': electricFrom?.toUtc(),
      'electricTo': electricTo?.toUtc(),
      'waterCurrent': waterCurrent ?? '0',
      'waterLast': waterLast ?? '0',
      'waterFrom': waterFrom?.toUtc(),
      'waterTo': waterTo?.toUtc(),
  };

  static List<BillEntity> getFakeData() {
    var result = <BillEntity>[];
    for (int i = 1; i <= 5; i++) {
      result.add(BillEntity(
          id: i,
          title:
              '${DateFormat('MMM y').format(DateTime.now().subtract(const Duration(days: 30)))} Bill',
          oweing: 240000,
          contractId: i,
          rentPrice: 1000,
          waterCurrent: 2300,
          waterLast: 1000,
          electricCurrent: 2300,
          electricLast: 2100,
          waterPrice: 1000,
          electricPrice: 4000,
          startDate: DateTime.now().subtract(const Duration(days: 31)),
          endDate: DateTime.now()));
    }
    return result;
  }
  static List<BillEntity> bills = [];
}
