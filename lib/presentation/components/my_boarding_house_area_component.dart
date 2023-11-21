import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/my_boarding_house_area/my_boarding_house_area_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/my_boarding_house_area/my_boarding_house_area_state.dart';

class MyBoadingHouseAreaComponent extends StatelessWidget {
  const MyBoadingHouseAreaComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyBoadingHouseAreaBloc, MyBoardingHouseAreaState>(
        builder: (context, state) {
          if(state is MyBoardingHouseAreaLoadingState){
            return const Center(child: CupertinoActivityIndicator());
          }
          if(state is MyBoardingHouseAreaDoneState){
            return ListView.builder(
              itemBuilder: (context, index){
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.holiday_village),
                        title: Text(state.data![index].name.toString()),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(state.data![index].address.toString()),
                      )
                    ]),
                );
            });
          }
          return const SizedBox();
      },),
    );
  }
}