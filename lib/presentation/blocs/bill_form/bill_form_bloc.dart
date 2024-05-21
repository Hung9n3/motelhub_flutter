import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/bill_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/bill_form/bill_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/bill_form/bill_form_state.dart';
import 'package:dio/dio.dart';

class BillFormBloc extends Bloc<BaseBillFormEvent, BaseBillFormState> {
  final IBillRepository _billRepository;
  final IContractRepository _contractRepository;
  final IRoomRepository _roomRepository;
  BillFormBloc(this._billRepository, this._contractRepository, this._roomRepository)
      : super(const BillFormLoading()) {
  }

  int? billId = 0;
  int? contractId = 0;
  String? roomName = '';
  double? oweing = 0;
  double? roomPrice = 0;
  double? electricPrice = 0;
  double? electricLast = 0;
  double? electricCurrent = 0;
  double? waterPrice = 0;
  double? waterLast = 0;
  double? waterCurrent = 0;
  DateTime? waterFrom;
  DateTime? waterTo;
  DateTime? electricFrom;
  DateTime? electricTo;

  _getData(BaseBillFormEvent event, Emitter<BaseBillFormState> emit) async{
    try {
      var contract = await _contractRepository.getById(event.contractId);
      var room =  await _roomRepository.getById(contract.data!.roomId!);
      contractId = contractId;
      roomName = room.data?.name;

      if(event.billId == null) {
        emit(const BillFormDone());
        return;
      }
      var dataState = await _billRepository.getById(billId);
      if(dataState is DataSuccess && dataState.data != null) {
        billId = billId;
        roomPrice = dataState.data!.rentPrice;
        waterPrice = dataState.data!.waterPrice;
        electricPrice = dataState.data!.electricPrice;
        oweing = dataState.data!.oweing;
        waterFrom = dataState.data!.waterFrom;
        waterCurrent = dataState.data!.waterCurrent;
        electricCurrent = dataState.data!.rentePrice;
        roomPrice = dataState.data!.rentPrice;
      }
    } on DioError catch (e) {
      emit(BillFormError(e.message));
    }
  }
}
