import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_state.dart';

class AddAreaPage extends StatelessWidget {
  const AddAreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddAreaBloc>(
      create: (context) => sl()..add(const AddAreaInitEvent()),
      child: BlocBuilder<AddAreaBloc, AddAreaState>(
        builder: (context, state) {
          return const SizedBox();
        },
      ),
    );
  }
}
