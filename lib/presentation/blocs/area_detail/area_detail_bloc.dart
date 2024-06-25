import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_state.dart';

class AreaDetailBloc extends Bloc<AreaDetailEvent, AreaDetailState> {
  final IAreaRepository _areaRepository;
  final IRoomRepository _roomRepository;
  final IAuthRepository _authRepository;
  final ITokenHandler _tokenHandler;
  AreaDetailBloc(this._areaRepository, this._roomRepository, this._tokenHandler,
      this._authRepository)
      : super(const AreaDetailLoadingState()) {
    on<GetAreaDetailEvent>(_getAreaDetail);
    on<SubmitAreaEvent>(_submit);
  }

  List<RoomEntity> rentingRooms = [];
  List<RoomEntity> emptyRooms = [];
  AreaEntity? entity;
  bool isEditable = false;
  String? hostName = '';
  String? hostPhone = '';
  _getAreaDetail(AreaDetailEvent event, Emitter<AreaDetailState> emit) async {
    if (event.areaId == 0) {
      return;
    }
    var dataState = await _areaRepository.getById(event.areaId!);
    if (dataState is DataSuccess) {
      entity = dataState.data;
      var user = await _authRepository.getById(dataState.data?.hostId ?? 0);
      hostName = user?.name;
      hostPhone = user?.phoneNumber;
      var userId = int.tryParse(await _tokenHandler.getByKey(currentUserIdKey));
      var rooms = await _roomRepository.getByArea(event.areaId!);
      if (userId != dataState.data?.hostId) {
        isEditable = false;
        rentingRooms =
            rooms.where((element) => element.customerId == userId).toList();
      } else {
        isEditable = true;
      }
      emptyRooms = rooms
          .where((element) =>
              element.customerId == 0 || element.customerId == null)
          .toList();
      emit(AreaDetailDoneState(dataState.data!));
    } else {
      emit(AreaDetailErrorState(dataState.message!));
    }
  }

  _submit(SubmitAreaEvent event, Emitter<AreaDetailState> emit) async {
    entity?.address = event.address;
    entity?.name = event.name;
    var result = await _areaRepository.save(entity!);
    emit( AreaDetailSubmitDone(entity));
  }
}
