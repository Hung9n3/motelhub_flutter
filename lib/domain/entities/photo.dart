import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;

import 'package:equatable/equatable.dart';

class PhotoEntity {
   int? id;
   String? name;
   int? roomId;
   int? areaId;
   int? userId;
   int? workOrderId;
   int? contractId;
   int? billId;
   String? url;
   File? file;
   String? photoData;

  PhotoEntity({
    this.id,
    this.name,
    this.file,
    this.url,
    this.areaId,
    this.roomId,
    this.userId,
    this.workOrderId,
    this.contractId,
    this.billId,
    this.photoData
  });

  factory PhotoEntity.fromJson(Map<String, dynamic> map) {
    return PhotoEntity(
      id: map['id'] ?? 0,
      roomId: map['roomId'] ?? 0,
      userId: map['userId'] ?? 0,
      billId: map['billId'] ?? 0,
      photoData: map['data'],
      workOrderId: map['workOrderId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id ?? '0',
        'roomId': roomId == 0 ? null : roomId,
        'userId': userId == 0 ? null : userId,
        'billId': billId == 0 ? null : billId,
        'data': photoData,
        'workOrderId': workOrderId == 0 ? null : workOrderId,
      };

  static List<PhotoEntity> photos = [];
}
