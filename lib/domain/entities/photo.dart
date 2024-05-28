import 'dart:io';

import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final int? id;
  final String? name;
  final int? roomId;
  final int? areaId;
  final int? userId;
  final int? workOrderId;
  final int? contractId;
  final int? billId;
  final String? url;
  final File? data;

  const PhotoEntity(
      {this.id,
      this.name,
      this.data,
      this.url,
      this.areaId,
      this.roomId,
      this.userId,
      this.workOrderId, this.contractId, this.billId,});

  factory PhotoEntity.fromJson(Map<String, dynamic> map) {
    return PhotoEntity(
      id: map['id'] ?? 0,
      roomId: map['roomId'] ?? 0,
      userId: map['userId'] ?? 0,
      areaId: map['areaId'] ?? 0,
      billId: map['billId'] ?? 0,
      contractId: map['contractId'] ?? 0,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, data, url];
}
