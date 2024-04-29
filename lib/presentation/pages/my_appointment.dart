import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return _buildBody(state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBody(MyAppointmentState state) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: state.data!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/area-detail',
                    arguments: {'areaId': state.data![index].id}),
                child: Card(
<<<<<<< HEAD
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            "${(state.data![index].title)} - ${state.data![index].room?.name}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title:
                              Text(state.data![index].creator!.name.toString()),
                        ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                              state.data![index].participant!.name.toString()),
                        ),
                        ListTile(
                          leading: const Icon(Icons.timelapse),
                          title: Text(
                              "${state.data![index].startTime ?? ""} - ${state.data![index].endTime ?? ""}"),
                        ),
                      ]),
=======
                  child: Column(children: [
                    Text(
                        "${(state.data![index].title.toString())} - ${state.data![index].room!.name}"),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(state.data![index].creator!.name.toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title:
                          Text(state.data![index].participant!.name.toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.timelapse),
                      title: Text(
                          "${state.data![index].startTime.toString()} - ${state.data![index].endTime.toString()}"),
                    ),
                  ]),
>>>>>>> 00034b943fa1a3e6021e4a9404b14a58779d7d03
                ),
              ),
            );
          }),
    );
  }
}
