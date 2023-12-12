import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_event.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_state.dart';

class AddRoomPage extends StatelessWidget {
  final FormMode mode;
  final int? selectedAreaId;
  const AddRoomPage({super.key, required this.mode, this.selectedAreaId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddRoomBloc>(
      create: (context) => sl()..add(const LoadingFormEvent()),
      child: BlocBuilder<AddRoomBloc, AddRoomState>(builder: (context, state) {
        if (state is LoadingFormStateDone) {
          return _addRoomForm(context, state);
        }
        if (state is LoadingFormState) {
          print(selectedAreaId);
          return const Center(child: CupertinoActivityIndicator());
        }
        return const SizedBox();
      }),
    );
  }

  Widget _addRoomForm(BuildContext context, AddRoomState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Detail'),
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              ButtonTheme(
                alignedDropdown: true,
                child: DropdownMenu<AreaEntity>(
                    leadingIcon: const Icon(Icons.holiday_village),
                    initialSelection: selectedAreaId != null ? state.areas!.where((element) => element.id == selectedAreaId).firstOrNull
                                                             : state.areas!.firstOrNull,
                    requestFocusOnTap: true,
                    label: const Text('Select area'),
                    dropdownMenuEntries: state.areas!
                        .map((value) => DropdownMenuEntry<AreaEntity>(
                              value: value,
                              label: "${value.name} - ${value.address}",
                            ))
                        .toList(),
                    onSelected: (value) {
                      context.read<AddRoomBloc>().add(ChangeAreaEvent(value));
                    }),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Room Name',
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
            ],
          ),
        ),
      ),
    );
  }
}
