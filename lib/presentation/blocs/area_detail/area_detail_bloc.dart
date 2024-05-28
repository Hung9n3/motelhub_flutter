import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/usecases/area_detail/get_area_detail_usecases.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_state.dart';

class AreaDetailBloc extends Bloc<AreaDetailEvent, AreaDetailState> {
  final IAreaRepository _areaRepository;
  final IRoomRepository _roomRepository;
  AreaDetailBloc(this._areaRepository, this._roomRepository)
      : super(const AreaDetailLoadingState()) {
        on<GetAreaDetailEvent>(_getAreaDetail);
      }

  _getAreaDetail(AreaDetailEvent event, Emitter<AreaDetailState> emit) async {
    // var dataState = await _areaDetailUseCase(params:event.areaId);
    if(event.areaId == 0) {
      return;
    }
    var dataState = await _areaRepository.getById(event.areaId!);
    var rooms = await _roomRepository.getByArea(event.areaId!);
    if(dataState is DataSuccess){
      emit(AreaDetailDoneState(dataState.data!, rooms.data!));
    }
    else {
      emit(AreaDetailErrorState(dataState.error!));
    }
  }
}
