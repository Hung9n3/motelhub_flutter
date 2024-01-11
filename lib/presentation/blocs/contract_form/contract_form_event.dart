import 'package:motelhub_flutter/domain/entities/user.dart';

abstract class ContractFormEvent {
  final int? contractId;
  final UserEntity? owner;
  final DateTime? selectedDate;
  const ContractFormEvent({this.contractId, this.owner, this.selectedDate});
}

class ContractFormInitEvent extends ContractFormEvent{
  ContractFormInitEvent(int? contractId) : super(contractId: contractId);
}

class ContractFormChangeOwnerEvent extends ContractFormEvent {
  ContractFormChangeOwnerEvent(UserEntity? user) : super(owner: user);
}

class ContractFormChangeStartDateEvent extends ContractFormEvent {
  ContractFormChangeStartDateEvent(DateTime? selectedDate) : super(selectedDate: selectedDate);
}

class ContractFormChangeEndDateEvent extends ContractFormEvent {
  ContractFormChangeEndDateEvent(DateTime? selectedDate) : super(selectedDate: selectedDate);
}

class ContractFormChangeCancelDateEvent extends ContractFormEvent {
  ContractFormChangeCancelDateEvent(DateTime? selectedDate) : super(selectedDate: selectedDate);
}

class SubmitContractFormEvent extends ContractFormEvent {
  const SubmitContractFormEvent() : super();
}