import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';
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
    if (event is LoginButtonEvent) {
      emit(const LoginLoadingState());
      var dataState = await _authRepository.login(username!, password!);
      await Future.delayed(const Duration(seconds: 2));
      if (dataState is DataSuccess) {
        _tokenHandler.write('username', dataState.data.toString());
        emit(const LoginSuccessState());
      } else {
        emit(LoginErrorState(dataState.error!));
      }
    }
  }
}
