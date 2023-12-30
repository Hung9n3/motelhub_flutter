import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_state.dart';

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
              body: ListView.builder(
                  itemCount: state.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/area-detail',
                            arguments: {'areaId': state.data![index].id}),
                        child: Card(
                          child: Column(children: [
                            ListTile(
                              leading: const Icon(Icons.holiday_village),
                              title: Text(state.data![index].name.toString()),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on),
                              title:
                                  Text(state.data![index].address.toString()),
                            )
                          ]),
                        ),
                      ),
                    );
                  }));
        }
        return const SizedBox();
      }),
    );
  }
}
