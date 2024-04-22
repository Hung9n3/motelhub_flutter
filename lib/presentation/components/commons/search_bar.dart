import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchBar extends StatelessWidget {
  final Widget? filterDialog;
  final Bloc? bloc;
  final Object? event;
  const CustomSearchBar({super.key, this.filterDialog, this.bloc, this.event});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      if (bloc != null) {
                        bloc!.add(event);
                      }
                    },
                    icon: const Icon(Icons.search))),
            controller: controller,
          ),
        ),
        Visibility(
            visible: filterDialog != null,
            child: IconButton(
                onPressed: () async {
                  if (filterDialog != null) {
                    var dialog = await showDialog(
                        context: context,
                        builder: (context) {
                          return filterDialog!;
                        });
                  }
                },
                icon: const Icon(Icons.filter_alt_outlined)))
      ],
    );
  }
}
