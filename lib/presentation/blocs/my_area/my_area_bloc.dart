import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
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
    // final userId = int.tryParse(await _tokenHandler.getByKey('userId'));
    // final dataState = await _areaRepository.getByHost(userId);
    // final customerDataState = await _areaRepository.getByCustomer(userId);
    List<AreaEntity> fakeAreas = [
      AreaEntity(address: "16/3, khu phố Đông A, Đông Hòa, Dĩ An, Bình Dương", hostId: 1, name: "Nhà trọ Quốc Hùng", latitude: 10.8963602, longitude: 106.7879265),
      AreaEntity(address: "Tỉnh Lộ 743, Xã Bình Hòa, H.Thuận An, T.Bình Dương, Binh Hoà, Thuận An, Bình Dương", hostId: 1, name: "Nhà trọ Cầu Ông Bố", latitude: 10.900955, longitude: 106.7116784 ),
    ] ;

    List<RoomEntity> rentings = [
      RoomEntity(name: "S10.02.0606", contractFrom: DateTime(2023, 3, 14), contractTo: DateTime(2025, 3, 14))
    ];
    var fakedataState = DataSuccess(fakeAreas);
    if(fakedataState is DataSuccess){
      //emit(MyAreaDoneState(dataState.data!, customerDataState.data!));
      emit(MyAreaDoneState(fakeAreas, rentings));
    }
    if(fakedataState is DataFailed){
      emit(MyAreaError(fakedataState.message!));
    }
  }
}