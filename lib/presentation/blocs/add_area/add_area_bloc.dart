import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_state.dart';

class AddAreaBloc extends Bloc<AddAreaEvent, AddAreaState>{
  final ITokenHandler _tokenHandler;
  final IAreaRepository _areaRepository;
  AddAreaBloc(this._tokenHandler, this._areaRepository):super(const AddAreaInitState()){
    on<AddAreaInitEvent>(_loadingForm);
  }
  
  _loadingForm(AddAreaInitEvent event, Emitter<AddAreaState> emit) async {
    emit(const AddAreaStateDone());
  }

  _submit(AddAreaSubmitEvent event, Emitter<AddAreaState> state) async {
    var username = await _tokenHandler.getByKey('username');
    var area = AreaEntity(id: 999, address: event.address, name: event.name, owner: username);
    print(area);
  }
}