import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

class WorkOrderEntity {
   int? id;
   int? customerId;
   int? roomId;
   String? customerName;
   String? name;
   String? roomName;
   bool? isCustomerPay;
   double? price;
   bool? isOpen;
   DateTime? createdOn;
   List<PhotoEntity>? photos;

  WorkOrderEntity(
      {this.id,
      this.roomId,
      this.name,
      this.roomName,
      this.isCustomerPay,
      this.isOpen,
      this.price,
      this.customerId,
      this.customerName,
      this.createdOn,
      this.photos});

  factory WorkOrderEntity.fromJson(Map<String, dynamic> map) {
    return WorkOrderEntity(
      id: map['id'] ?? 0,
      roomId: map['roomId'] ?? 0,
      customerId: map['customerId'] ?? 0,
      isCustomerPay: map['isCustomerPay'] ?? false,
      price: double.tryParse(map['price'].toString()) ?? 0.0,
      name: map['name'] ?? '',
      isOpen: map['isOpen'] ?? false,
      createdOn: map['createdOn'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id ?? 0,
        'roomId': roomId == 0 ? null : roomId,
        'customerId': customerId == 0 ? null : customerId,
        'isCustomerPay': isCustomerPay ?? false,
        'price': price ?? 0.0,
        'title': name ?? '',
        'isOpen': isOpen ?? false,
        'createdOn': createdOn?.toUtc().toString(),
      };

  static List<WorkOrderEntity> getFakeData() {
    List<WorkOrderEntity> workOrders = [];
    for (int i = 1; i < 10; i++) {
      var workOrder = WorkOrderEntity(
          id: i,
          roomId: i,
          name: 'Work Order $i',
          roomName: RoomEntity.getFakeData()
              .where((room) => room.id == i)
              .firstOrNull
              ?.name,
          customerId: i,
          customerName: UserEntity.getFakeData()
              .where((room) => room.id == i)
              .firstOrNull
              ?.name,
          isOpen: i % 2 == 0,
          isCustomerPay: i % 2 == 0,
          createdOn: DateTime.now());
      workOrders.add(workOrder);
    }
    return workOrders;
  }
  static List<WorkOrderEntity> contracs = [];
}
