import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/data/repositories/auth_repository.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_event.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitialState()) {
    on<PasswordChangeEvent>(onTextFieldChange);
    on<UsernameChangeEvent>(onTextFieldChange);
    on<LoginButtonEvent>(onLoginButtonPress);
  }

  String? username = "";
  String? password = "";
  var authRepo = AuthRepository();
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
      print("username: $username: password: $password");
      emit(const LoginLoadingState());
      var data = await authRepo.login(username!, password!);
      await Future.delayed(const Duration(seconds: 5));
      if (data is DataSuccess) {
        emit(const LoginSuccessState());
      } else {
        emit(LoginErrorState(data.error!));
      }
    }
  }
}
