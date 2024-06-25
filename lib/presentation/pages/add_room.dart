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
import 'package:motelhub_flutter/presentation/components/commons/photo_section.dart';
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
        child: BlocConsumer<AddRoomBloc, AddRoomState>(
          listener: (context, state) {
            if (state is AddRoomSuccess) {
              showAlertDialog(context, 'Save successfully');
            }
            if (state is AddRoomError) {
              showAlertDialog(context, 'Save failed');
            }
          },
          builder: (context, state) {
            return _buildBody(context);
          },
        ));
  }

  Widget _buildBody(BuildContext context) {
    var bloc = context.read<AddRoomBloc>();
    var priceController = TextEditingController(text: '${bloc.price ?? 0}');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Room'),
          actions: [
            IconButton(
                onPressed: () {
                  var photos =
                      context.read<PhotoSectionBloc>().state.photos ?? [];
                  context.read<AddRoomBloc>().add(AddRoomOnSubmitButtonPressed(
                      selectedAreaId, priceController.text, photos));
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
        body: FormContainer(
          child: Column(
            children: [
              SectionWithBottomBorder(
                  child: ListTile(
                    leading: const Icon(Icons.holiday_village),
                    title: Text('${bloc.areaName}'),
                  ),
                ),
              SectionWithBottomBorder(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Room name',
                    prefixIcon: Icon(Icons.meeting_room),
                  ),
                  onChanged: (value) {
                    context.read<AddRoomBloc>().add(ChangeRoomNameEvent(value));
                  },
                ),
              ),
              SectionWithBottomBorder(
                child: TextField(
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
              ),
              SectionWithBottomBorder(
                child: TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                        hintText: 'Price',
                        prefixIcon: Icon(Icons.attach_money),
                        suffixText: 'VND')),
              ),
              const PhotoSection()
            ],
          ),
        ));
  }
}
