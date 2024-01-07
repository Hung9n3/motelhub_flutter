import 'package:motelhub_flutter/domain/entities/bases/base.dart';

abstract class MeterReadingEntity extends BaseEntity{
  final int? id;
  final int? roomId;
  final double? value;
  final double? price;
  final double? total;

  const MeterReadingEntity({this.id, this.roomId, this.price, this.value, this.total, super.createdAt, super.isActive, super.modifiedAt}) : super();
  @override
  List<Object?> get props => [];
}