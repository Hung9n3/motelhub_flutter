import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_state.dart';

class MyAreaBloc extends Bloc<MyAreaEvent, MyAreaState>{

  final IAreaRepository _areaRepository;
  final ITokenHandler _tokenHandler;

  MyAreaBloc(this._areaRepository, this._tokenHandler) : super(const MyAreaLoadingState()){
    on<GetMyAreaEvent>(getAreaList);
  }

  getAreaList(GetMyAreaEvent event, Emitter<MyAreaState> emit) async {
    final userId = int.tryParse(await _tokenHandler.getByKey('userId'));
    final dataState = await _areaRepository.getByUser(userId);

    if(dataState is DataSuccess){
      emit(MyAreaDoneState(dataState.data!));
    }
    if(dataState is DataFailed){
      emit(MyAreaError(dataState.error!));
    }
  }
}