import 'package:motelhub_flutter/domain/entities/user.dart';

abstract class ContractFormEvent {
  final int? contractId;
  final int? roomId;
  final UserEntity? owner;
  final DateTime? selectedDate;
  final String? price;
  const ContractFormEvent({this.contractId, this.owner, this.selectedDate, this.price, this.roomId});
}

class ContractFormInitEvent extends ContractFormEvent{
  ContractFormInitEvent(int? contractId, int? roomId) : super(contractId: contractId, roomId: roomId);
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
  const SubmitContractFormEvent(String? price) : super(price: price);
}

class DeleteSignatureEvent extends ContractFormEvent {
  const DeleteSignatureEvent(): super();
}