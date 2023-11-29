import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_event.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_state.dart';

class AddRoomPage extends StatelessWidget {
  final FormMode mode;
  const AddRoomPage({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddRoomBloc>(
      create: (context) => sl()..add(const LoadingFormEvent()),
      child: Scaffold(
          appBar: AppBar(title: const Text('Room Detail')),
          body: BlocBuilder<AddRoomBloc, AddRoomState>(
            builder: (context, state) {
              if (state is LoadingFormStateDone) {
                return _addRoomForm(context, state);
              }
              if (state is LoadingFormState) {
                return const Center(child: CupertinoActivityIndicator());
              }
              return const SizedBox();
            },
          )),
    );
  }

  Widget _addRoomForm(BuildContext context, AddRoomState state) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
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
            DropdownButton(
                isExpanded: true,
                value: state.selectedAreaId,
                elevation: 16,
                items: state.areas!
                    .map((value) => DropdownMenuItem(
                          value: value.id,
                          child: Text("${value.name}"),
                        ))
                    .toList(),
                onChanged: (value) {
                  var a = value.toString();
                  context
                      .read<AddRoomBloc>()
                      .add(ChangeAreaEvent(int.tryParse(value.toString())!));
                })
          ],
        ),
      ),
    );
  }
}
