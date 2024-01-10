import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/bases/meter_reading.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/meter_reading_form/meter_reading_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/meter_reading_form/meter_reading_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/meter_reading_form/meter_reading_form_state.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_event.dart';
import 'package:motelhub_flutter/presentation/components/commons/form_container.dart';
import 'package:motelhub_flutter/presentation/components/commons/photo_section.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';

class MeterReadingForm<T extends MeterReadingEntity> extends StatelessWidget {
  final int roomId;
  final int? meterReadingId;
  final MeterReadingType meterReadingType;
  const MeterReadingForm(
      {super.key,
      required this.roomId,
      required this.meterReadingType,
      this.meterReadingId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MeterReadingFormBloc<T>>(
              create: (context) =>
                  sl()..add(InitFormEvent(meterReadingId, meterReadingType))),
          BlocProvider<PhotoSectionBloc>(create: (context) => sl()),
        ],
        child: BlocConsumer<MeterReadingFormBloc<T>, MeterReadingFormState>(
          listener: (context, state) {
            if (state is MeterReadingFormLoadDone) {
              context.read<PhotoSectionBloc>().add(UpdatePhotosEvent(
                  context.read<MeterReadingFormBloc<T>>().photos));
            }
          },
          builder: (context, state) {
            if (state is MeterReadingFormLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: meterReadingType == MeterReadingType.water
                      ? const Text('Water')
                      : const Text('Electric'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          var photos =
                              context.read<PhotoSectionBloc>().state.photos;
                          context
                              .read<MeterReadingFormBloc<T>>()
                              .add(SubmitFormEvent(meterReadingType, photos));
                        },
                        icon: const Icon(Icons.check))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    context
                        .read<PhotoSectionBloc>()
                        .add(const AddPhotoEvent(ImageSource.gallery));
                  },
                  child: const Icon(Icons.add_a_photo),
                ),
                body: _buildBody(context),
              );
            }
          },
        ));
  }

  _buildBody(BuildContext context) {
    var meterReadingFormbloc = context.read<MeterReadingFormBloc<T>>();
    var valueController =
        TextEditingController(text: '${meterReadingFormbloc.value}');
    var totalController =
        TextEditingController(text: '${meterReadingFormbloc.total}');
    return FormContainer(
        child: Column(
      children: [
        SectionWithBottomBorder(
            child: TextFormField(
          initialValue: meterReadingFormbloc.name,
          decoration: InputDecoration(
            hintText: 'Input title, shoul be relating to time',
            enabled: true,
            prefixIcon: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Icon(Icons.title),
            ),
          ),
          onChanged: (value) =>
              meterReadingFormbloc.add(ChangeNameEvent(value)),
        )),
        SectionWithBottomBorder(
            child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.number,
          initialValue: meterReadingFormbloc.lastMonth?.toString(),
          decoration: InputDecoration(
            suffixText: 'Last month value',
            enabled: true,
            prefixIcon: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Icon(Icons.pin),
            ),
          ),
          onChanged: (value) =>
              meterReadingFormbloc.add(ChangeLastMonthEvent(value)),
        )),
        SectionWithBottomBorder(
            child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.number,
          initialValue: meterReadingFormbloc.thisMonth?.toString(),
          decoration: InputDecoration(
            suffixText: 'This month value',
            enabled: true,
            prefixIcon: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Icon(Icons.pin),
            ),
          ),
          onChanged: (value) =>
              meterReadingFormbloc.add(ChangeThisMonthEvent(value)),
        )),
        SectionWithBottomBorder(
            child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.number,
          initialValue: meterReadingFormbloc.price?.toString(),
          decoration: InputDecoration(
            enabled: true,
            suffix: const Text('price per value'),
            prefixIcon: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Icon(Icons.attach_money),
            ),
          ),
          onChanged: (value) =>
              meterReadingFormbloc.add(ChangePriceEvent(value)),
        )),
        SectionWithBottomBorder(
            child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          controller: valueController,
          decoration: InputDecoration(
            enabled: false,
            suffix: const Text('Value'),
            prefixIcon: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Icon(Icons.water_drop),
            ),
          ),
        )),
        SectionWithBottomBorder(
            child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          controller: totalController,
          decoration: InputDecoration(
            enabled: false,
            suffix: const Text('Total'),
            prefixIcon: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Icon(Icons.functions),
            ),
          ),
        )),
        const PhotoSection()
      ],
    ));
  }
}
