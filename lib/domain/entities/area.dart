import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';

// ignore: must_be_immutable
class AreaEntity extends Equatable {
  final int? id;
  final int? hostId;
  final String? name;
  final String? address;
  final String? owner;
  final double? longitude;
  final double? latitude;
  List<RoomEntity> rooms;
  AreaEntity({this.id, this.hostId, this.address, this.name, this.owner, this.latitude, this.longitude, this.rooms = const []});

  @override
  List<Object?> get props => [id, name, address, owner, rooms];

  factory AreaEntity.fromJson(Map < String, dynamic > map) {
    return AreaEntity(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      address: map['address'] ?? "",
      owner: map['owner'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id ?? '0',
    'name': name ?? '',
    'hostId': hostId ?? '0',
    'address' : address ?? '',
  };

  static List<AreaEntity> getFakeData() {
    List<AreaEntity> boardingHouseAreas = [
      AreaEntity(
        id: 1,
        name: 'Boarding House A',
        address: '123 Main Street',
        owner: 'hung'
      ),
      AreaEntity(
        id: 2,
        name: 'Boarding House B',
        address: '456 Elm Street',
        owner: 'hung'
      )
    ];

    for (int i = 3; i <= 12; i++) {
      boardingHouseAreas.add(
        AreaEntity(
          id: i,
          name: 'Boarding House $i',
          address: 'Address $i',
        ),
      );
    }
    return boardingHouseAreas;
  }
}
