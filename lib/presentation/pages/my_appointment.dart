import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/my_appointment/my_appointment_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/my_appointment/my_appointment_event.dart';
import 'package:motelhub_flutter/presentation/blocs/my_appointment/my_appointment_state.dart';

class MyAppointment extends StatelessWidget {
  const MyAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyAppointmentBloc>(
      create: (context) => sl()..add(const MyAppointmentInitEvent()),
      child: BlocBuilder<MyAppointmentBloc, MyAppointmentState>(
        builder: (context, state) {
          if (state is MyAppointmentErrorState) {
            return Center(child: Text("${state.error}"));
          }
          if (state is MyAppointmentLoadingState) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is MyAppointmentDoneState) {
            return _buildBody(context,state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, MyAppointmentState state) {
    var bloc = context.read<MyAppointmentBloc>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: state.data!.length,
          itemBuilder: (context, index) {
            var data = state.data![index];
            var isAccepted = data.isAccepted;
            var time = data.startTime != null
                ? '${DateFormat('hh:mm - dd, MMM yyyy').format(data.startTime!)} to ${DateFormat('hh:mm - dd, MMM yyyy').format(data.startTime!.add(Duration(minutes: data.duration ?? 0)))}'
                : '';
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Slidable(
                endActionPane: ActionPane(
                    extentRatio: 0.5,
                    motion: const BehindMotion(),
                    children: [
                      Visibility(
                        visible: isAccepted == false,
                        child: SlidableAction(
                          onPressed: (context) {bloc.add(MyAppointmentAcceptEvent(data.id, data.roomId));},
                          backgroundColor: Color.fromARGB(255, 139, 254, 73),
                          foregroundColor: Colors.white,
                          icon: Icons.check,
                          label: 'Accept',
                        ),
                      ),
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.close,
                        label: 'Cancel',
                      )
                    ]),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/appointment-form',
                      arguments: {
                        'appointmentId': data.id,
                        'roomId': data.roomId
                      }),
                  child: Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              "${(data.title)} - ${data.room?.name}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(data.creator!.name.toString()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(data.participant!.name.toString()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.timelapse),
                            title: Text(time),
                          ),
                        ]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
