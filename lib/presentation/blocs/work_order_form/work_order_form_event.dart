import 'package:motelhub_flutter/domain/entities/photo.dart';

class WorkOrderFormEvent {
  final int? workOrderId;
  final int? roomId;
  final String? name;
  final bool? isCustomerPay;
  final bool? isOpen;
  final double? price;
  final List<PhotoEntity>? photos;
  const WorkOrderFormEvent(
      {this.workOrderId,
      this.roomId,
      this.name,
      this.isCustomerPay,
      this.isOpen,
      this.price,
      this.photos});
}

class WorkOrderFormInitEvent extends WorkOrderFormEvent {
  const WorkOrderFormInitEvent(int? workOrderId, int? roomId)
      : super(workOrderId: workOrderId);
}

class WorkOrderFormSubmitEvent extends WorkOrderFormEvent {
  WorkOrderFormSubmitEvent(
    String? name,
    bool? isCustomerPay,
    bool? isOpen,
    double? price,
    List<PhotoEntity>? photos,
  ) : super(
            isCustomerPay: isCustomerPay,
            isOpen: isOpen,
            name: name,
            price: price,
            photos: photos);
}
