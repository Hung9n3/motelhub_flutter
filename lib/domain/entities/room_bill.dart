import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';

class BillEntity extends Equatable {
  final int? id;
  final int? contractId;
  final double? total;
  final String? title;
  final double? oweing;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? rentPrice;
  final double? waterPrice;
  final double? electricPrice;
  final double? electricLast;
  final double? electricCurrent;
  final double? waterLast;
  final double? waterCurrent;
  final DateTime? waterFrom;
  final DateTime? waterTo;
  final DateTime? electricFrom;
  final DateTime? electricTo;
  final RoomEntity? room;
  final List<PhotoEntity>? photos;

  const BillEntity(
      {this.id,
      this.contractId,
      this.total,
      this.title,
      this.oweing,
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
      this.room,
      this.photos})
      : super();

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        contractId,
        total,
        title,
        oweing,
        startDate,
        endDate,
        rentPrice,
        room,
      ];

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
}
