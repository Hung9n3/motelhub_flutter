import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

class BoardingHouseAreaEntity extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final String? owner;

  const BoardingHouseAreaEntity({this.id, this.address, this.name, this.owner});

  @override
  List<Object?> get props => [id, name, address, owner];

  static List<BoardingHouseAreaEntity> getFakeData() {
    List<BoardingHouseAreaEntity> boardingHouseAreas = [
      const BoardingHouseAreaEntity(
        id: 1,
        name: 'Boarding House A',
        address: '123 Main Street',
        owner: 'hung'
      ),
      const BoardingHouseAreaEntity(
        id: 2,
        name: 'Boarding House B',
        address: '456 Elm Street',
        owner: 'hung'
      )
    ];

    for (int i = 3; i <= 12; i++) {
      boardingHouseAreas.add(
        BoardingHouseAreaEntity(
          id: i,
          name: 'Boarding House $i',
          address: 'Address $i',
        ),
      );
    }
    return boardingHouseAreas;
  }
}
