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
  }

  List<RoomEntity> rentingRooms = [];
  List<RoomEntity> emptyRooms = [];
  bool isEditable = false;
  String? hostName = '';
  String? hostPhone = '';
  _getAreaDetail(AreaDetailEvent event, Emitter<AreaDetailState> emit) async {
    if (event.areaId == 0) {
      return;
    }
    //var dataState = await _areaRepository.getById(event.areaId!);
    var dataState = DataSuccess(AreaEntity(address: "16/3, khu phố Đông A, Đông Hòa, Dĩ An, Bình Dương", hostId: 1, name: "Nhà trọ Quốc Hùng", latitude: 10.8963602, longitude: 106.7879265));
    if (dataState is DataSuccess) {
      //var user = await _authRepository.getById(dataState.data?.hostId ?? 0);
      //hostName = user?.name;
      hostName = 'Đỗ Quốc Hùng';
      //hostPhone = user?.phoneNumber;
      hostPhone = '0393556841';
      //var userId = int.tryParse(await _tokenHandler.getByKey(currentUserIdKey));
      //dvar rooms = await _roomRepository.getByArea(event.areaId!);
      // if (userId != dataState.data?.hostId) {
      //   isEditable = false;
      //   rentingRooms =
      //       rooms.where((element) => element.customerId == userId).toList();
      // } else {
      //   isEditable = true;
      // }
      isEditable = true;
      rentingRooms = [
      ];
      for(int i = 0; i < 20; i ++) {
        rentingRooms.add(RoomEntity(
          name: 'room ${i+1}',
          acreage: 15,
          price: 1400000
        ));
      }
      emptyRooms = [];
      // emptyRooms = rooms
      //     .where((element) =>
      //         element.customerId == 0 || element.customerId == null)
      //     .toList();
      emit(AreaDetailDoneState(dataState.data!));
    } else {
      emit(AreaDetailErrorState(dataState.message!));
    }
  }
}
