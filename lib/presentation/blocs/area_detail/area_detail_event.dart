abstract class AreaDetailEvent {
  final int? areaId;
  const AreaDetailEvent({this.areaId});
}

class GetAreaDetailEvent  extends AreaDetailEvent{
  const GetAreaDetailEvent(int areaId) : super(areaId: areaId);
}

class DeleteAreaDetailEvent extends AreaDetailEvent{
  const DeleteAreaDetailEvent(int areaId) : super(areaId: areaId);
}