abstract class SearchRoomEvent {
  final String? roomName;
  final String? address;
  final String? priceFrom;
  final String? priceTo;
  final String? acreageFrom;
  final String? acreageTo;
  final bool? isAirConditioned;

  const SearchRoomEvent(
      {this.acreageFrom,
      this.acreageTo,
      this.address,
      this.isAirConditioned,
      this.priceFrom,
      this.priceTo,
      this.roomName});
}

class SearchRoomSubmitEvent extends SearchRoomEvent {
  const SearchRoomSubmitEvent(
    {String? roomName,
    String? address,
    String? priceFrom,
    String? priceTo,
    String? acreageFrom,
    String? acreageTo,
    bool? isAirConditioned,}
  ) : super(
            roomName: roomName,
            address: address,
            priceFrom: priceFrom,
            priceTo: priceTo,
            acreageFrom: acreageFrom,
            acreageTo: acreageTo,
            isAirConditioned: isAirConditioned);
}

class SearchRoomCloseDialogEvent extends SearchRoomEvent {
  const SearchRoomCloseDialogEvent(
    {String? roomName,
    String? address,
    String? priceFrom,
    String? priceTo,
    String? acreageFrom,
    String? acreageTo,
    bool? isAirConditioned,}
  ) : super(
            roomName: roomName,
            address: address,
            priceFrom: priceFrom,
            priceTo: priceTo,
            acreageFrom: acreageFrom,
            acreageTo: acreageTo,
            isAirConditioned: isAirConditioned);
}

class SearchRoomInitEvent extends SearchRoomEvent {
  const SearchRoomInitEvent() : super();
}

class SearchRoomChangeAirConditionCheckBoxEvent extends SearchRoomEvent {
  const SearchRoomChangeAirConditionCheckBoxEvent(bool? isAirConditioned) : super(isAirConditioned: isAirConditioned);
}

class SearchRoomFindButtonPressed extends SearchRoomEvent {
  const SearchRoomFindButtonPressed(String searchText) : super(roomName: searchText);
}
