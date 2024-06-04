import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/common_listview.dart';
import 'package:motelhub_flutter/presentation/components/commons/item_expansion.dart';

class MyAreaComponent extends StatelessWidget {
  const MyAreaComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyAreaBloc>(
      create: (context) => sl()..add(const GetMyAreaEvent()),
      child: BlocBuilder<MyAreaBloc, MyAreaState>(builder: (context, state) {
        if (state is MyAreaLoadingState) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is MyAreaDoneState) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-area');
                },
                child: const Icon(Icons.add),
              ),
              body: SafeArea(
                child: Column(
                  children: [owningSection(context, state.data ?? []), rentingSection(context, state.customerData ?? [])],
                ),
              ));
        }
        return const SizedBox();
      }),
    );
  }

  Widget owningSection(BuildContext context, List<AreaEntity> areas) {
    if (areas == []) {
      return const SizedBox();
    }
    var state = context.read<MyAreaBloc>().state;
    return ItemExpansion(
        title: 'Owning Areas',
        icon: Icons.holiday_village,
        itemCount: areas.length,
        children: [
          CommonListView(
              items: areas,
              builder: (context, index) {
                var workOrder = areas[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/area-detail',
                        arguments: {'areaId': state.data![index].id}),
                    child: Card(
                      child: Column(children: [
                        ListTile(
                          leading: const Icon(Icons.holiday_village),
                          title: Text(state.data![index].name.toString()),
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(state.data![index].address.toString()),
                        )
                      ]),
                    ),
                  ),
                );
              })
        ]);
  }

  Widget rentingSection(BuildContext context, List<RoomEntity> rooms) {
    if (rooms == []) {
      return const SizedBox();
    }
    var state = context.read<MyAreaBloc>().state;
    return ItemExpansion(
        title: 'Renting Rooms',
        icon: Icons.meeting_room,
        itemCount: rooms.length,
        children: [
          CommonListView(
              items: rooms,
              builder: (context, index) {
                var room = rooms[index];
                var contractFrom = room.contractFrom == null
                    ? ''
                    : DateFormat('dd, MMM yyyy')
                        .format(room.contractFrom!)
                        .toString();
                var contractTo = room.contractTo == null
                    ? ''
                    : DateFormat('dd, MMM yyyy')
                        .format(room.contractTo!)
                        .toString();

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/area-detail',
                        arguments: {'areaId': state.data![index].id}),
                    child: Card(
                      child: Column(children: [
                        ListTile(
                          leading: const Icon(Icons.meeting_room
                          ),
                          title: Text(room.name.toString()),
                        ),
                        ListTile(
                          leading: const Icon(Icons.calendar_month),
                          title: Text('$contractFrom - $contractTo'),
                        )
                      ]),
                    ),
                  ),
                );
              })
        ]);
  }
}
