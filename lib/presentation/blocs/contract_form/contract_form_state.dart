import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class ContractFormState extends BaseState {
  final UserEntity? selectedCustomer;
  const ContractFormState({this.selectedCustomer});
}

class ContractFormLoading extends ContractFormState {
  const ContractFormLoading();
}

class ContractFormLoadDone extends ContractFormState {
  ContractFormLoadDone(UserEntity? selectedOwner) : super(selectedCustomer: selectedOwner);
}

class ContractFormNotFound extends ContractFormState {
  const ContractFormNotFound() : super();
}

class ContractFormChangeOwnerDone extends ContractFormState {
  ContractFormChangeOwnerDone(UserEntity? selectedOwner) : super(selectedCustomer: selectedOwner);
}

class ContractFormChangeDateDone extends ContractFormState {
  ContractFormChangeDateDone(UserEntity? selectedOwner) : super();
}

class SubmitContractFormDone extends ContractFormState {
  const SubmitContractFormDone() : super();
}

class SubmitContractFormFail extends ContractFormState {
  const SubmitContractFormFail() : super();
}

class DeleteSignatureDone extends ContractFormState {
  const DeleteSignatureDone(UserEntity? selectedOwner ) : super(selectedCustomer: selectedOwner);
}