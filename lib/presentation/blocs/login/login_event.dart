abstract class LoginEvent{
  final String? textValue;
  const LoginEvent({this.textValue});
}

class PasswordChangeEvent extends LoginEvent{
  const PasswordChangeEvent(String password) : super(textValue: password);
}

class UsernameChangeEvent extends LoginEvent{
  const UsernameChangeEvent(String username) : super(textValue: username);
}

class LoginButtonEvent extends LoginEvent{
  const LoginButtonEvent();
}