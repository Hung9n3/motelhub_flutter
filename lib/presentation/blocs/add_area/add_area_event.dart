abstract class AddAreaEvent {
  const AddAreaEvent();
}

class AddAreaInitEvent extends AddAreaEvent{
  const AddAreaInitEvent() : super();
}

class AddAreaSubmitEvent extends AddAreaEvent{
  final String? name;
  final String? address;
  const AddAreaSubmitEvent(this.name, this.address) : super();
}