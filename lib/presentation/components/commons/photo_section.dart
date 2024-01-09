import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/alert_dialog.dart';
import 'package:motelhub_flutter/presentation/components/commons/item_expansion.dart';

class PhotoSection extends StatelessWidget {
  const PhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoSectionBloc, PhotoSectionState>(
        listener: (context, state) {
      if (state is GetPhotoFailed) {
        showAlertDialog(context, "Add photo fail");
      }
    }, builder: (context, state) {
      return ItemExpansion(
        itemCount: state.photos?.length,
        icon: Icons.photo,
        title: 'Photo',
        children: [
          Wrap(
            direction: Axis.horizontal,
            children: state.photos!.map((photo) {
              final data = photo.data;
              final url = photo.url;
              if (data == null && url == null) {
                return const SizedBox();
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Image(
                    image: data != null
                        ? FileImage(data)
                        : NetworkImage(url!) as ImageProvider,
                    height: 100,
                  ),
                );
              }
            }).toList(),
          ),
        ],
      );
    });
  }
}