import 'package:dio/dio.dart';

class BaseBillFormState {
  final String? errorMessage;
  final DateTime? electricFrom;
  final DateTime? electricTo;
  final DateTime? waterFrom;
  final DateTime? waterTo;
  final double? total;
  final double? electricUsed;
  final double? waterUsed;
  final double? electricTotal;
  final double? waterTotal;
  final double? oweing;
  const BaseBillFormState(
      {this.errorMessage,
      this.electricFrom,
      this.electricTo,
      this.waterFrom,
      this.waterTo,
      this.oweing,
      this.electricTotal,
      this.electricUsed,
      this.total,
      this.waterTotal,
      this.waterUsed});
}

class BillFormDone extends BaseBillFormState {
  const BillFormDone() : super();
}

class BillFormLoading extends BaseBillFormState {
  const BillFormLoading() : super();
}

class BillFormError extends BaseBillFormState {
  const BillFormError(String? errorMessage) : super(errorMessage: errorMessage);
}

class BillFormChangeDateDone extends BaseBillFormState {
  BillFormChangeDateDone(DateTime? electricFrom, DateTime? electricTo,
      DateTime? waterFrom, DateTime? waterTo)
      : super(
            electricFrom: electricFrom,
            electricTo: electricTo,
            waterFrom: waterFrom,
            waterTo: waterTo);
}

class BillFormChangeTextDone extends BaseBillFormState {
  BillFormChangeTextDone(
    double? total,
    double? electricUsed,
    double? waterUsed,
    double? electricTotal,
    double? waterTotal,
  ) : super(
            total: total,
            electricUsed: electricUsed,
            waterUsed: waterUsed,
            electricTotal: electricTotal,
            waterTotal: waterTotal);
}
