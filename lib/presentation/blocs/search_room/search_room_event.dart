abstract class SearchRoomEvent {
  const SearchRoomEvent();
}

class SearchRoomSubmitEvent extends SearchRoomEvent {
  const SearchRoomSubmitEvent() : super();
}

class SearchRoomInitEvent extends SearchRoomEvent {
  const SearchRoomInitEvent() : super();
}
