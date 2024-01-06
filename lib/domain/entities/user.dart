import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? username;
  final String? password;
  final String? name;
  final String? phoneNumber;
  final int? roomId;

  const UserEntity(
      {this.id,
      this.password,
      this.username,
      this.name,
      this.phoneNumber,
      this.roomId});

  @override
  List<Object?> get props =>
      [id, username, password, name, phoneNumber, roomId];

  static List<UserEntity> getFakeData() {
    List<UserEntity> result = [];
    for (int i = 1; i <= 20; i++) {
      result.add(UserEntity(
          id: i,
          password: 'string',
          username: 'hung$i',
          name: 'hung$i',
          phoneNumber: '0987654321',
          roomId: i));
    }
    for (int i = 21; i <= 50; i++) {
      result.add(UserEntity(
          id: i,
          password: 'string',
          username: 'hung$i',
          name: 'hung$i',
          phoneNumber: '0987654321'));
    }
    return result;
  }
}
