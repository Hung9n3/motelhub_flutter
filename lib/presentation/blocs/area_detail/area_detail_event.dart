abstract class AreaDetailEvent {
  final int? areaId;
  final String? address;
  final String? name;
  const AreaDetailEvent({this.address, this.name, this.areaId});
}

class GetAreaDetailEvent  extends AreaDetailEvent{
  const GetAreaDetailEvent(int areaId) : super(areaId: areaId);
}

class SubmitAreaEvent extends AreaDetailEvent{
  const SubmitAreaEvent(String? address, String? name) : super(address: address, name: name);
}