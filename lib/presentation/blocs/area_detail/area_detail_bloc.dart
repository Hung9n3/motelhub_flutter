import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/usecases/area_detail/get_area_detail_usecases.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_state.dart';

class AreaDetailBloc extends Bloc<AreaDetailEvent, AreaDetailState> {
  final GetAreaDetailUseCase _areaDetailUseCase;
  AreaDetailBloc(this._areaDetailUseCase)
      : super(const AreaDetailLoadingState()) {
        on<GetAreaDetailEvent>(getAreaDetail);
      }

  getAreaDetail(AreaDetailEvent event, Emitter<AreaDetailState> emit) async {
    var dataState = await _areaDetailUseCase(params:event.areaId);
    if(dataState is DataSuccess){
      emit(AreaDetailDoneState(dataState.data!, dataState.data!.rooms));
    }
    else {
      emit(AreaDetailErrorState(dataState.error!));
    }
  }
}
