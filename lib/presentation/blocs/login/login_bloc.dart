import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_event.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {
  LoginBloc() : super(LoginInitialState()){
    on<PasswordChangeEvent>(onTextFieldChange);
    on<UsernameChangeEvent>(onTextFieldChange);
    on<LoginButtonEvent>(onLoginButtonPress);
  }

  void onTextFieldChange(LoginEvent event, Emitter <LoginState> emit) async {
    if(event is PasswordChangeEvent || event is UsernameChangeEvent){
      emit(
        LoginTextFieldState(event.textValue!)
      );
    }
  }

  void onLoginButtonPress(LoginEvent event, Emitter<LoginState> emit) async {
  }
}