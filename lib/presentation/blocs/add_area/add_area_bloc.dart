import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_state.dart';

class AddAreaBloc extends Bloc<AddAreaEvent, AddAreaState>{
  final ITokenHandler _tokenHandler;
  final IAreaRepository _areaRepository;
  AddAreaBloc(this._tokenHandler, this._areaRepository):super(AddAreaInitState()){
    on<AddAreaInitEvent>(_loadingForm);
    on<ChangeAreaNameEvent>(_changeAreaName);
    on<ChangeAreaAddressEvent>(_changeAreaAddress);
    on<SubmitAreaEvent>(_submit);
  }
  
  _loadingForm(AddAreaInitEvent event, Emitter<AddAreaState> emit) async {
    emit(AddAreaLoadFormDoneState());
  }

  _changeAreaName(ChangeAreaNameEvent event, Emitter<AddAreaState> emit) async {
    state.name = event.name;
  }

  _changeAreaAddress(ChangeAreaAddressEvent event, Emitter<AddAreaState> emit) async {
    state.address = event.address;
  }
  
  _submit(SubmitAreaEvent event, Emitter<AddAreaState> emit) async {
    var username = await _tokenHandler.getByKey('username');
    var area = AreaEntity(id: 999, address: state.address, name: state.name, owner: username);
    print(area);
  }
}