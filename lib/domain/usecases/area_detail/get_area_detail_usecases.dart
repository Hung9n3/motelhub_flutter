import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/core/usecases/base_usecase.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';

class GetAreaDetailUseCase implements BaseUseCase<DataState<AreaEntity>, int?>{

  final IAreaRepository _areaRepository;
  final IRoomRepository _roomRepository;

  GetAreaDetailUseCase(this._areaRepository, this._roomRepository);

  @override
  Future<DataState<AreaEntity>> call({params}) async {
    var areaDataState = await _areaRepository.getById(params!);
    if(areaDataState is DataSuccess && areaDataState.data != null){
      var roomDataState = await _roomRepository.getByArea(params);
      if(roomDataState is DataSuccess){
        areaDataState.data!.rooms = roomDataState.data!;
      }
      return areaDataState;
    }
    else {
      return DataFailed(areaDataState.error!);
    }
  }

}