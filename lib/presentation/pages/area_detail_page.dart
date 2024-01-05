import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';

class AreaDetailPage extends StatelessWidget {
  final int areaId;
  const AreaDetailPage({super.key, required this.areaId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AreaDetailBloc>(
      create: (context) => sl()..add(GetAreaDetailEvent(areaId)),
      child: BlocBuilder<AreaDetailBloc, AreaDetailState>(
        builder: (context, state) {
          if (state is AreaDetailLoadingState) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is AreaDetailDoneState) {
            return _buildAreaDetail(state.area!, context);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildAreaDetail(AreaEntity data, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Area Detail',
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-room',
              arguments: {'mode': FormMode.add, 'selectedAreaId': data.id});
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  SectionWithBottomBorder(
                    child: ListTile(
                      leading: const Icon(Icons.holiday_village),
                      title: Text('${data.name}'),
                    ),
                  ),
                  SectionWithBottomBorder(
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text('${data.name}'),
                    ),
                  ),
                  SectionWithBottomBorder(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text('${data.owner}'),
                    ),
                  ),
                ],
              ),
              _buildExpansion(data.rooms)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansion(List<RoomEntity> rooms) {
    return ExpansionTile(
      title: const Text('Rooms'),
      leading: const Icon(Icons.meeting_room),
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/room-detail',arguments: {'mode': FormMode.update, 'roomId': rooms[index].id}),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${rooms[index].name}'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Acreage: ${rooms[index].acreage}'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Availabel: ${rooms[index].isEmpty}')
                      ],
                    ),
                  ),
                ),
              );
            })
      ],
    );
  }
}
