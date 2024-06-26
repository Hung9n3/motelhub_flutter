import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';

class UserEntity {
   int? id;
   String? username;
   String? password;
   String? email;
   String? name;
   String? phoneNumber;
   int? roomId;
   List<ContractEntity> contracts;

 UserEntity(
      {this.id,
      this.password,
      this.username,
      this.email,
      this.name,
      this.phoneNumber,
      this.roomId,
      this.contracts = const []});

  factory UserEntity.fromJson(Map < String, dynamic > map) {
    return UserEntity(
      id: map['id'] ?? "",
      username: map['username'] ?? "",
      password: map['password'] ?? "",
      email: map['email'] ?? "",
      name: map['fullname'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      roomId: map['roomId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id ?? '0',
    'username': username ?? '',
    'password': password ?? '',
    'name': name ?? '',
    'phoneNumber': phoneNumber ?? '',
    'roomId': roomId ?? '0'
  };

  static List<UserEntity> getFakeData() {
    List<UserEntity> result = [];
    for (int i = 1; i <= 20; i++) {
      result.add(UserEntity(
          id: i,
          password: 'string',
          username: 'hung$i',
          name: 'Trần Tiến Đạt',
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
