import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';

// ignore: must_be_immutable
class AreaEntity {
   int? id;
   int? hostId;
   String? name;
   String? address;
   String? owner;
   double? longitude;
   double? latitude;
  List<RoomEntity> rooms;
  AreaEntity({this.id, this.hostId, this.address, this.name, this.owner, this.latitude, this.longitude, this.rooms = const []});

  factory AreaEntity.fromJson(Map < String, dynamic > map) {
    return AreaEntity(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      address: map['address'] ?? "",
      hostId: map['hostId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id ?? '0',
    'name': name ?? '',
    'hostId': hostId,
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
