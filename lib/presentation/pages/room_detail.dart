import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_event.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_state.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/alert_dialog.dart';
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
            appBar: AppBar(title: const Text('Room'), actions: [
              IconButton(
                  onPressed: () {
                    var photos = context.read<PhotoSectionBloc>().state.photos;
                    context.read<RoomDetailBloc>().add(SubmitFormEvent(photos));
                  },
                  icon: const Icon(Icons.check))
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
            ),
            body: _buildBody(context),
          );
        }));
  }

  _buildBody(BuildContext context) {
      var roomDetailBloc = context.read<RoomDetailBloc>();
      var photoSectionBloc = context.read<PhotoSectionBloc>();
    return BlocBuilder<RoomDetailBloc, RoomDetailState>(
      builder: (context, state) {
        if (state is RoomDetailLoadingFormState) {
          return const CupertinoActivityIndicator();
        } else {
          photoSectionBloc.add(UpdatePhotosEvent(roomDetailBloc.photos));
          return SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                SectionWithBottomBorder(
                    child: TextFormField(
                  initialValue: roomDetailBloc.areaName,
                  decoration: const InputDecoration(
                    enabled: false,
                    prefixIcon: Icon(Icons.holiday_village),
                  ),
                )),
                SectionWithBottomBorder(
                    child: TextFormField(
                  initialValue: roomDetailBloc.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.meeting_room),
                  ),
                  onChanged: (value) =>
                      roomDetailBloc.add(ChangeNameEvent(value)),
                )),
                SectionWithBottomBorder(
                    child: TextFormField(
                  initialValue: roomDetailBloc.acreage?.toString(),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.meeting_room),
                  ),
                  onChanged: (value) =>
                      roomDetailBloc.add(ChangeAcreageEvent(value)),
                )),
                BlocConsumer<PhotoSectionBloc, PhotoSectionState>(
                    listener: (context, state) {
                  if (state is GetPhotoFailed) {
                    showAlertDialog(context, "Add photo fail");
                  }
                }, builder: (context, state) {
                  return Wrap(
                    direction: Axis.horizontal,
                    children: state.photos!.map((photo) {
                      final data = photo.data;
                      final url = photo.url;
                      if (data == null && url == null) {
                        return const SizedBox();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Image(
                            image: data != null
                                ? FileImage(data)
                                : NetworkImage(url!) as ImageProvider,
                            height: 100,
                          ),
                        );
                      }
                    }).toList(),
                  );
                }),
              ],
            )),
          );
        }
      },
    );
  }
}
