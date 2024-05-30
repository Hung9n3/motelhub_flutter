import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_event.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_state.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_event.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/alert_dialog.dart';
import 'package:motelhub_flutter/presentation/components/commons/form_container.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';

class AddRoomPage extends StatelessWidget {
  final FormMode mode;
  final int selectedAreaId;
  const AddRoomPage(
      {super.key, required this.mode, required this.selectedAreaId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AddRoomBloc>(
              create: (context) => sl()
                ..add(
                  LoadingFormEvent(selectedAreaId, mode),
                )),
          BlocProvider<PhotoSectionBloc>(create: (context) => sl())
        ],
        child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Room'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<AddRoomBloc>()
                              .add(const AddRoomOnSubmitButtonPressed());
                        },
                        icon: const Icon(Icons.check))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    context
                        .read<PhotoSectionBloc>()
                        .add(const AddPhotoEvent(ImageSource.camera));
                  },
                  child: const Icon(Icons.add_a_photo),
                ),
                body: _buildBody(context));
          },
        ));
  }

  Widget _buildBody(BuildContext context) {
    return FormContainer(
      child: Column(
        children: [
          SectionWithBottomBorder(child: TextFormField(
            initialValue: context.read<AddRoomBloc>().areaName,
            decoration: const InputDecoration(
              hintText: 'Area name',
              prefixIcon: Icon(Icons.holiday_village),
            ),
          )),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Room name',
              prefixIcon: Icon(Icons.meeting_room),
            ),
            onChanged: (value) {
              context.read<AddRoomBloc>().add(ChangeRoomNameEvent(value));
            },
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Acreage',
              suffixText: 'm2',
              prefixIcon: Icon(Icons.square_foot),
            ),
            onChanged: (value) {
              context.read<AddRoomBloc>().add(ChangeAcreageEvent(value));
            },
          ),
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
      ),
    );
  }
}
