import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  final String? error;
  const LoginState({this.error});
  
  @override
  List<Object?> get props => [error];
}

class LoginInitialState extends LoginState {
  const LoginInitialState() : super();
}

class LoginErrorState extends LoginState {
  const LoginErrorState(String? error):super(error: error);
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}