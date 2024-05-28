import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_state.dart';

class RoomDetailBloc extends Bloc<RoomDetailEvent, RoomDetailState> {
  final IRoomRepository _roomRepository;
  final ITokenHandler _tokenHandler;

  RoomDetailBloc(this._roomRepository, this._tokenHandler)
      : super(const RoomDetailLoadingFormState()) {
    on<LoadFormDataEvent>(_loadForm);
    on<SubmitFormEvent>(_submitForm);
    on<ChangeNameEvent>(_changeName);
    on<ChangeAcreageEvent>(_changeAcreage);
    on<ChangeOwnerEvent>(_changeOwner);
  }

  int? id;
  int? ownerId;
  String? name;
  String? areaName;
  double? acreage;
  int? areaId;
  bool isEmpty = false;
  List<UserEntity> users = [];
  List<UserEntity>? members = [];
  List<PhotoEntity>? photos = [];
  List<ContractEntity>? contracts = [];
  List<WorkOrderEntity>? workOrders = [];
  int? role;

  _loadForm(LoadFormDataEvent event, Emitter<BaseState> emit) async {
    var dataState = await _roomRepository.getById(event.roomId!);
    if (dataState is DataSuccess && dataState.data != null) {
      var room = dataState.data!;
      id = room.id;
      acreage = room.acreage;
      areaId = room.areaId;
      isEmpty = room.isEmpty;
      photos = room.photos;
      name = room.name;
      areaName = room.areaName;
      members = room.members;
      ownerId = room.ownerId;
      contracts = room.contracts;
      workOrders = room.workOrders;

      users = UserEntity.getFakeData();
      users.add(const UserEntity(id: 0, name: 'None'));
      users.sort((a, b) => a.id!.compareTo(b.id!));
      emit(RoomDetailLoadFormStateDone(
          ownerId, room.ownerName, members));
    } else {
      emit(ErrorState(dataState.error));
    }
  }

  _changeOwner(ChangeOwnerEvent event, Emitter<BaseState> emit) async {
    var owner =
        users.where((element) => element.id == event.owner?.id).firstOrNull;
    ownerId = owner?.id;
    emit(RoomDetailLoadFormStateDone(
        ownerId, owner?.name, members));
  }

  _submitForm(SubmitFormEvent event, Emitter<BaseState> emit) async {
    //Todo: implement submit logic
    try {
      var room = RoomEntity(
          id: id,
          name: name,
          acreage: acreage,
          photos: event.photos,
          ownerId: ownerId,
          isEmpty: isEmpty,
          areaId: areaId);
      emit(const SubmitFormSuccess());
    } on Exception catch (err) {
      emit(ErrorState(err));
    }
  }

  _changeName(ChangeNameEvent event, Emitter<BaseState> emit) async {
    name = event.name;
  }

  _changeAcreage(ChangeAcreageEvent event, Emitter<BaseState> emit) async {
    if (event.acreage != null) {
      var doubleValue = double.tryParse(event.acreage!) ?? 0;
      acreage = doubleValue;
    }
  }
}
