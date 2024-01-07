import 'package:flutter/widgets.dart';

class CommonListView<T> extends StatelessWidget {
  final List<T>? items;
  final Widget? Function(BuildContext, int) builder;
  const CommonListView(
      {super.key,
      required this.items,
      required this.builder,
      });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items?.length,
        itemBuilder: builder);
  }
}
