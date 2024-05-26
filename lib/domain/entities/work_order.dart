import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

class WorkOrderEntity extends Equatable {
  final int? id;
  final int? customerId;
  final int? roomId;
  final String? customerName;
  final String? name;
  final String? roomName;
  final bool? isCustomerPay;
  final double? price;
  final bool? isOpen;
  final DateTime? createdOn;
  final List<PhotoEntity>? photos;

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

  @override
  List<Object?> get props => [id,
      roomId,
      name,
      roomName,
      isCustomerPay,
      isOpen,
      price,
      customerId,
      customerName,
      createdOn,
      photos];

  static List<WorkOrderEntity> getFakeData() {
    List<WorkOrderEntity> workOrders = [];
    for(int i = 1; i < 10; i++) {
      var workOrder = WorkOrderEntity(
        id: i, 
        roomId: i,
        name: 'Work Order $i',
        roomName: RoomEntity.getFakeData().where((room) => room.id == i).firstOrNull?.name,
        customerId: i,
        customerName: UserEntity.getFakeData().where((room) => room.id == i).firstOrNull?.name,
        isOpen: i%2 == 0,
        isCustomerPay: i%2 == 0,
        createdOn: DateTime.now()
      );
      workOrders.add(workOrder);
    }
    return workOrders;
  }
}
