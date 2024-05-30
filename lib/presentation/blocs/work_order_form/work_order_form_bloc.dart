import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';
import 'package:motelhub_flutter/domain/repositories/work_order_repository_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/work_order_form/work_order_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/work_order_form/work_order_form_state.dart';

class WorkOrderFormBloc extends Bloc<WorkOrderFormEvent, WorkOrderFormState> {
  final IWorkOrderRepository _workOrderRepository;
  WorkOrderFormBloc(this._workOrderRepository)
      : super(const WorkOrderFormLoadingState()) {
    on<WorkOrderFormInitEvent>(getData);
    on<WorkOrderFormSubmitEvent>(submit);
    on<WorkOrderFormIsCustomerPayChangedEvent>(updateIsCustomerPay);
  }

  int workOrderId = 0;
  int roomId = 0;
  int contractId = 0;
  String name = '';
  String roomName = '';
  double price = 0;
  bool isCustomerPay = false;
  bool isOpen = true;
  List<PhotoEntity> photos = [];

  getData(
      WorkOrderFormInitEvent event, Emitter<WorkOrderFormState> emit) async {
    try {
      if(event.workOrderId == null) {
        emit(const WorkOrderFormDoneState(false, true));
      }
      var dataState = await _workOrderRepository.getById(event.workOrderId);
      if (dataState is DataSuccess && dataState.data != null) {
        workOrderId = dataState.data!.roomId ?? 0;
        roomId = dataState.data!.roomId ?? 0;
        price = dataState.data!.price ?? 0;
        name = dataState.data!.name ?? '';
        roomName = dataState.data!.roomName ?? '';
        isCustomerPay = dataState.data!.isCustomerPay ?? false;
        isOpen = dataState.data!.isOpen ?? false;
        photos = dataState.data!.photos ?? [];
        emit(WorkOrderFormDoneState(isCustomerPay, isOpen));
      } else {
        emit(WorkOrderFormErrorState(dataState.message));
      }
    } on Error catch (e) {
      print(e);
    }
  }

  submit(
      WorkOrderFormSubmitEvent event, Emitter<WorkOrderFormState> emit) async {
    try {
      emit(const WorkOrderFormLoadingState());
      var workOrderEntity = WorkOrderEntity(
          id: workOrderId,
          roomId: roomId,
          name: name,
          price: price,
          isCustomerPay: isCustomerPay,
          isOpen: isOpen,
          photos: photos);
      var dataState = await _workOrderRepository.save(workOrderEntity);
      if(dataState is DataSuccess){
        emit(WorkOrderFormDoneState(isCustomerPay, isOpen));
      }
      else {
        emit(WorkOrderFormErrorState(dataState.message));
      }
    } on Error catch (e) {
      print(e);
    }
  }

  updateIsCustomerPay(WorkOrderFormIsCustomerPayChangedEvent event, Emitter<WorkOrderFormState> emit) {
    isCustomerPay = event.isCustomerPay ?? false;
    emit(WorkOrderFormDoneState(isCustomerPay, isOpen));
  }

  updateIsOpen(WorkOrderFormIsOpenChangedEvent event, Emitter<WorkOrderFormState> emit) {
    isOpen = event.isOpen ?? false;
    emit(WorkOrderFormDoneState(isCustomerPay, isOpen));
  }
}
