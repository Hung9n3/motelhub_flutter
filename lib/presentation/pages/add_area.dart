import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_event.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/alert_dialog.dart';
import 'package:motelhub_flutter/presentation/components/commons/form_container.dart';

class AddAreaPage extends StatelessWidget {
  const AddAreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AddAreaBloc>(create: (context) => sl()),
          BlocProvider<PhotoSectionBloc>(create: (context) => sl()),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Area'),
                actions: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<AddAreaBloc>()
                            .add(const SubmitAreaEvent());
                      },
                      icon: const Icon(Icons.check))
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context
                      .read<PhotoSectionBloc>()
                      .add(const AddPhotoEvent(ImageSource.gallery));
                },
                child: const Icon(Icons.add_a_photo),
              ),
              body: _buildBody(context),
            );
          },
        ));
  }

  _buildBody(BuildContext context) {
    return FormContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Room Name',
            prefixIcon: Icon(Icons.meeting_room),
          ),
          onChanged: (value) {
            context.read<AddAreaBloc>().add(ChangeAreaNameEvent(value));
          },
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Address',
            prefixIcon: Icon(Icons.location_on),
          ),
          onChanged: (value) {
            context.read<AddAreaBloc>().add(ChangeAreaAddressEvent(value));
          },
        ),
        BlocConsumer<PhotoSectionBloc, PhotoSectionState>(
            listener: (context, state) {
          if (state is GetPhotoFailed) {
            showAlertDialog(context, "Add photo failed");
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
      ]),
    );
  }
}
