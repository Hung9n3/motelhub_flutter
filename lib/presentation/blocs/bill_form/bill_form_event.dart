class BaseBillFormEvent {
  final int? billId;
  final int? contractId;
  final String? roomPrice;
  final String? electricPrice;
  final String? electricLast;
  final String? electricCurrent;
  final String? waterPrice;
  final String? waterLast;
  final String? waterCurrent;
  final DateTime? waterFrom;
  final DateTime? waterTo;
  final DateTime? electricFrom;
  final DateTime? electricTo;
  final String? oweing;

  const BaseBillFormEvent(
      {this.billId,
      this.contractId,
      this.oweing,
      this.roomPrice,
      this.electricPrice,
      this.waterPrice,
      this.electricCurrent,
      this.electricLast,
      this.waterCurrent,
      this.waterLast,
      this.electricFrom,
      this.electricTo,
      this.waterFrom,
      this.waterTo});
}

class BillFormInitEvent extends BaseBillFormEvent {
  BillFormInitEvent(int? billId, int? contractId)
      : super(billId: billId, contractId: contractId);
}

class BillFormSubmitEvent extends BaseBillFormEvent {
  BillFormSubmitEvent(
      int? billId,
      int? contractId,
      String? oweing,
      String? roomPrice,
      String? electricPrice,
      String? electricLast,
      String? electricCurrent,
      String? waterPrice,
      String? waterLast,
      String? waterCurrent,
      DateTime? waterFrom,
      DateTime? waterTo,
      DateTime? electricFrom,
      DateTime? electricTo)
      : super(
            billId: billId,
            contractId: contractId,
            oweing: oweing,
            roomPrice: roomPrice,
            electricCurrent: electricCurrent,
            electricFrom: electricFrom,
            electricTo: electricTo,
            electricLast: electricLast,
            electricPrice: electricPrice,
            waterCurrent: waterCurrent,
            waterFrom: waterFrom,
            waterLast: waterLast,
            waterPrice: waterPrice,
            waterTo: waterTo);
}

class BillFormChangeDateEvent extends BaseBillFormEvent {
  BillFormChangeDateEvent(DateTime? electricFrom, DateTime? electricTo,
      DateTime? waterFrom, DateTime? waterTo)
      : super(
            electricFrom: electricFrom,
            electricTo: electricTo,
            waterFrom: waterFrom,
            waterTo: waterTo);
}

class BillFormChangeTextEvent extends BaseBillFormEvent {
  BillFormChangeTextEvent(
      String? roomPrice,
      String? electricPrice,
      String? electricCurrent,
      String? electricLast,
      String? waterPrice,
      String? waterCurrent,
      String? waterLast)
      : super(
            roomPrice: roomPrice,
            electricPrice: electricPrice,
            electricCurrent: electricCurrent,
            electricLast: electricLast,
            waterPrice: waterPrice,
            waterCurrent: waterCurrent,
            waterLast: waterLast);
}
