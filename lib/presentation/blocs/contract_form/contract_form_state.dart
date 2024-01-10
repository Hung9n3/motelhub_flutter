import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class ContractFormState extends BaseState {
  final UserEntity? selectedOwner;
  const ContractFormState({this.selectedOwner});
}

class ContractFormLoading extends ContractFormState {
  const ContractFormLoading();
}

class ContractFormLoadDone extends ContractFormState {
  ContractFormLoadDone(UserEntity? selectedOwner) : super(selectedOwner: selectedOwner);
}

class ContractFormNotFound extends ContractFormState {
  const ContractFormNotFound() : super();
}

class ContractFormChangeOwnerDone extends ContractFormState {
  ContractFormChangeOwnerDone(UserEntity? selectedOwner) : super(selectedOwner: selectedOwner);
}

class SubmitContractFormDone extends ContractFormState {
  const SubmitContractFormDone() : super();
}