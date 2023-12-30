abstract class AddAreaEvent {
  final String? name;
  final String? address;
  const AddAreaEvent({this.name, this.address});
}

class AddAreaInitEvent extends AddAreaEvent{
  const AddAreaInitEvent() : super();
}

class SubmitAreaEvent extends AddAreaEvent{
  const SubmitAreaEvent() : super();
}

class ChangeAreaNameEvent extends AddAreaEvent{
  const ChangeAreaNameEvent(String name) : super(name: name);
}

class ChangeAreaAddressEvent extends AddAreaEvent{
  const ChangeAreaAddressEvent(String address) : super(address: address);
}