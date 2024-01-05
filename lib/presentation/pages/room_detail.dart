import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';

class RoomDetailPage extends StatelessWidget {
  final int roomId;
  const RoomDetailPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RoomDetailBloc>(
              create: (context) => sl()..add(LoadFormDataEvent(roomId))),
          BlocProvider<PhotoSectionBloc>(create: (context) => sl()),
        ],
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Room'), actions: const []),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
            ),
            body: SizedBox(),
          );
        }));
  }

  _buildBody(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is RoomDetailLoadingFormState) {
          return const CupertinoActivityIndicator();
        } else {
          return SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                SectionWithBottomBorder(
                    child: TextFormField(
                      initialValue: context.read<RoomDetailBloc>().areaName,
                      decoration: const InputDecoration(
                        enabled: false,
                        prefixIcon: Icon(Icons.holiday_village),
                      ),
                )),
                SectionWithBottomBorder(
                    child: TextFormField(
                      initialValue: context.read<RoomDetailBloc>().name,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.meeting_room),
                      ),
                      onChanged: (value) => context.read<RoomDetailBloc>().add(ChangeNameEvent(value)),
                )),
                SectionWithBottomBorder(
                    child: TextFormField(
                      initialValue: context.read<RoomDetailBloc>().name,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.meeting_room),
                      ),
                      onChanged: (value) => context.read<RoomDetailBloc>().add(ChangeAcreageEvent(value)),
                )),
              ],
            )),
          );
        }
      },
    );
  }
}
