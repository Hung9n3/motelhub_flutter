import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/boarding_house_area_repository_interface.dart';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/my_boarding_house_area/my_boarding_house_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/my_boarding_house_area/my_boarding_house_area_state.dart';

class MyBoadingHouseAreaBloc extends Bloc<MyBoadingHouseAreaEvent, MyBoardingHouseAreaState>{

  final IBoardingHouseAreaRepository _boardingHouseAreaRepository;
  final ITokenHandler _tokenHandler;

  MyBoadingHouseAreaBloc(this._boardingHouseAreaRepository, this._tokenHandler) : super(const MyBoardingHouseAreaLoadingState()){
    on<GetMyBoardingHouseAreaEvent>(getBoardingHouseAreaList);
  }

  getBoardingHouseAreaList(GetMyBoardingHouseAreaEvent event, Emitter<MyBoardingHouseAreaState> emit) async {
    final username = await _tokenHandler.getByKey('username');
    final dataState = await _boardingHouseAreaRepository.getByUser('hung');

    if(dataState is DataSuccess){
      emit(MyBoardingHouseAreaDoneState(dataState.data!));
    }
    if(dataState is DataFailed){
      emit(MyBoardingHouseAreaError(dataState.error!));
    }
  }
}