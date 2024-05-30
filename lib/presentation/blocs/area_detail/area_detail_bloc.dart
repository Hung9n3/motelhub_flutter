import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_state.dart';

class AreaDetailBloc extends Bloc<AreaDetailEvent, AreaDetailState> {
  final IAreaRepository _areaRepository;
  final IRoomRepository _roomRepository;
  final ITokenHandler _tokenHandler;
  AreaDetailBloc(this._areaRepository, this._roomRepository, this._tokenHandler)
      : super(const AreaDetailLoadingState()) {
    on<GetAreaDetailEvent>(_getAreaDetail);
  }

  List<RoomEntity> rentingRooms = [];
  List<RoomEntity> emptyRooms = [];
  bool isEditable = false;
  _getAreaDetail(AreaDetailEvent event, Emitter<AreaDetailState> emit) async {
    // var dataState = await _areaDetailUseCase(params:event.areaId);
    if (event.areaId == 0) {
      return;
    }
    var dataState = await _areaRepository.getById(event.areaId!);
    if (dataState is DataSuccess) {
      var userId = int.tryParse(await _tokenHandler.getByKey(currentUserIdKey));
      var rooms = await _roomRepository.getByArea(event.areaId!);
      if (userId != dataState.data?.hostId) {
        isEditable = false;
        rentingRooms =
            rooms.where((element) => element.customerId == userId).toList();
      }
      else{
        isEditable = true;
      }
      emptyRooms = rooms
          .where((element) =>
              element.customerId == 0 || element.customerId == null)
          .toList();
      emit(AreaDetailDoneState(dataState.data!));
    } else {
      emit(AreaDetailErrorState(dataState.error!));
    }
  }
}
