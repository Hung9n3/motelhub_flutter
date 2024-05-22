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
      this.electricFrom,
      this.electricLast,
      this.electricTo,
      this.waterCurrent,
      this.waterFrom,
      this.waterLast,
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
