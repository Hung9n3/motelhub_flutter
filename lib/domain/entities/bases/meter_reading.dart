import 'package:motelhub_flutter/domain/entities/bases/base.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';

class MeterReadingEntity extends BaseEntity {
  final int? id;
  final int? roomId;
  final String? name;
  final double? value;
  final double? price;
  final double? total;
  final double? lastMonth;
  final double? thisMonth;
  final List<PhotoEntity>? photos;

  const MeterReadingEntity(
      {this.id,
      this.roomId,
      this.name,
      this.price,
      this.value,
      this.total,
      this.lastMonth,
      this.thisMonth,
      this.photos = const [],
      super.createdAt,
      super.isActive,
      super.modifiedAt})
      : super();
  @override
  List<Object?> get props => [
        id,
        roomId,
        name,
        price,
        value,
        total,
        lastMonth,
        thisMonth,
        photos,
      ];
}
