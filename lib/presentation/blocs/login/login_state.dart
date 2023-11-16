import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  final String? textFieldValue;
  final DioError? error;
  const LoginState({this.textFieldValue, this.error});
  
  @override
  List<Object?> get props => [textFieldValue, error];
}

class LoginInitialState extends LoginState {
  const LoginInitialState() : super(textFieldValue: "");
}

class LoginErrorState extends LoginState {
  const LoginErrorState(DioError error):super(error: error);
}

class LoginTextFieldState extends LoginState {
  const LoginTextFieldState(String textFieldValue) : super(textFieldValue: textFieldValue);
}