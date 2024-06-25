import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_event.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ITokenHandler _tokenHandler;
  final IAuthRepository _authRepository;
  LoginBloc(this._tokenHandler, this._authRepository) : super(const LoginInitialState()) {
    on<PasswordChangeEvent>(onTextFieldChange);
    on<UsernameChangeEvent>(onTextFieldChange);
    on<LoginButtonEvent>(onLoginButtonPress);
  }

  String? username = "";
  String? password = "";

  void onTextFieldChange(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is UsernameChangeEvent) {
      username = event.textValue;
    }
    if (event is PasswordChangeEvent) {
      password = event.textValue;
    }
  }

  void onLoginButtonPress(LoginEvent event, Emitter<LoginState> emit) async {
    try {
  if (event is LoginButtonEvent) {
    var dataState = await _authRepository.login('user1', 'string');
    emit(const LoginLoadingState());
    if (dataState is DataSuccess) {
      var token = _tokenHandler.decodeToken(dataState.data.toString());
      _tokenHandler.write('token', dataState.data);
      _tokenHandler.write('userId', token['UserId']);
      emit(const LoginSuccessState());
    } else {
      emit(LoginErrorState(dataState.message));
    }
  }
} on Exception catch (e) {
  print(e.toString());
  emit(const LoginInitialState());
}
  }
}
