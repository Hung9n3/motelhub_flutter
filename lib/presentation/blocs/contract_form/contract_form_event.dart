import 'package:motelhub_flutter/domain/entities/user.dart';

abstract class ContractFormEvent {
  final int? contractId;
  final UserEntity? owner;
  const ContractFormEvent({this.contractId, this.owner});
}

class ContractFormInitEvent extends ContractFormEvent{
  ContractFormInitEvent(int? contractId) : super(contractId: contractId);
}

class ContractFormChangeOwnerEvent extends ContractFormEvent {
  ContractFormChangeOwnerEvent(UserEntity? user) : super(owner: user);
}
class SubmitContractFormEvent extends ContractFormEvent {
  const SubmitContractFormEvent() : super();
}