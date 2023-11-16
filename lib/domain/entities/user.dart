import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  final int? id;
  final String? username;
  final String? password;

  const UserEntity({
    this.id,
    this.password,
    this.username
  });

  @override
  List<Object?> get props => [id, username, password];

}