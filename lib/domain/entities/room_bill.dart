import 'package:equatable/equatable.dart';

class RoomBillEntity extends Equatable {
  final int? id;
  final int? ownerId;
  final int? roomId;
  final int? waterId;
  final int? electricId;
  final double? total;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? rentPrice;

  const RoomBillEntity(
      {this.id,
      this.ownerId,
      this.roomId,
      this.waterId,
      this.electricId,
      this.total,
      this.startDate,
      this.endDate,
      this.rentPrice})
      : super();

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, ownerId, roomId, waterId, electricId, total, startDate, endDate];

  static List<RoomBillEntity> getGakeData() {
    var result = <RoomBillEntity>[];
    for (int i = 1; i <= 5; i++) {
      result.add(RoomBillEntity(
          id: i,
          ownerId: i,
          roomId: i,
          waterId: i,
          electricId: i,
          total: 0,
          startDate: DateTime.now().subtract(const Duration(days: 31)),
          endDate: DateTime.now()));
    }
    return result;
  }
}
