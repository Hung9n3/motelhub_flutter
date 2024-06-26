import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/bill_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_state.dart';

class ContractFormBloc extends Bloc<ContractFormEvent, ContractFormState> {
  final IContractRepository _contractRepository;
  final IBillRepository _billRepository;
  final IAuthRepository _authRepository;
  final ITokenHandler _tokenHandler;
  ContractFormBloc(this._contractRepository, this._tokenHandler, this._authRepository, this._billRepository)
      : super(const ContractFormLoading()) {
    on<ContractFormInitEvent>(_loadForm);
    on<SubmitContractFormEvent>(_submit);
    on<ContractFormChangeOwnerEvent>(_changeOwner);
    on<ContractFormChangeStartDateEvent>(_changeDate);
    on<ContractFormChangeEndDateEvent>(_changeDate);
    on<ContractFormChangeCancelDateEvent>(_changeDate);
    on<DeleteSignatureEvent>(_deleteSignature);
  }

  List<BillEntity> bills = [];
  int? contractId;
  int? roomId;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? cancelDate;
  double? priceRoom;
  int? customerId;
  int? currentUserId;
  int? isCustomerAccept;
  int? selectOwnerId;
  bool isOver = false;
  List<UserEntity> users = [];
  Uint8List? signature;

  _loadForm(ContractFormEvent event, Emitter<ContractFormState> emit) async {
    currentUserId = int.tryParse(await _tokenHandler.getByKey(currentUserIdKey));
    roomId = event.roomId;
    users = (await _authRepository.getAll());
    users.remove(users.where((element) => element.id == currentUserId).first);
    contractId = event.contractId ?? 0;
    if (event.contractId == null) {
      emit(ContractFormLoadDone(null));
    }
    var dataState = await _contractRepository.getById(event.contractId);
    if (dataState is DataSuccess) {
      var data = dataState.data;
      if (data != null) {
        bills = _billRepository.getAll().where((element) => element.contractId == contractId).toList();
        startDate = data.startDate;
        endDate = data.endDate;
        cancelDate = data.cancelDate;
        selectOwnerId = data.customerId;
        priceRoom = data.roomPrice;
        signature = ContractEntity.contracts.where((element) => element.id == contractId).firstOrNull?.signature;
        }
        var selectedOwner =
            users.where((element) => element.id == selectOwnerId).firstOrNull;
        emit(ContractFormLoadDone(selectedOwner));
      } else {
        emit(const ContractFormNotFound());
      }
    }

  _changeOwner(ContractFormChangeOwnerEvent event, Emitter<ContractFormState> emit) {
    selectOwnerId = event.owner?.id;
  }

  _changeDate(ContractFormEvent event, Emitter<ContractFormState> emit) {
    if (event.selectedDate != null) {
      if (event is ContractFormChangeStartDateEvent) {
        startDate = event.selectedDate;
        if( startDate != null && endDate != null && startDate!.isAfter(endDate!)) {
          endDate = null;
          cancelDate = null;
        }
      }
      if (event is ContractFormChangeEndDateEvent) {
        endDate = event.selectedDate;
        if( cancelDate != null && endDate != null && endDate!.isAfter(cancelDate!)) {
          cancelDate = null;
        }
      }
      if (event is ContractFormChangeCancelDateEvent) {
        cancelDate = event.selectedDate;
      }
      emit(ContractFormChangeDateDone(state.selectedCustomer));
    }
  }

  _deleteSignature(DeleteSignatureEvent event, Emitter<ContractFormState> emit) async {
    signature = null;
    emit(DeleteSignatureDone(users.where((element) => element.id == selectOwnerId).first));
  }

  _submit(SubmitContractFormEvent event, Emitter<ContractFormState> emit) async {
    var entity = ContractEntity(
      id: contractId,
      name: users.where((element) => element.id == selectOwnerId).first.name,
      customerId: selectOwnerId,
      startDate: startDate,
      endDate: endDate,
      roomPrice: priceRoom,
      cancelDate: cancelDate,
      signature: signature,
      roomId: roomId
    );
    var result = await _contractRepository.save(entity);
    if(result is DataSuccess) {
      emit(const SubmitContractFormDone());
    }
    else {
      emit(const SubmitContractFormFail());
    }
  }
}
