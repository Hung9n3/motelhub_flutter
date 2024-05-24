import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/bill_form/bill_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/bill_form/bill_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/bill_form/bill_form_state.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/alert_dialog.dart';
import 'package:motelhub_flutter/presentation/components/commons/common_date_picker.dart';
import 'package:motelhub_flutter/presentation/components/commons/form_container.dart';
import 'package:motelhub_flutter/presentation/components/commons/horizontal_divider_with_text.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';

class BillForm extends StatelessWidget {
  final int? contractId;
  final int? billId;
  const BillForm({super.key, required this.contractId, this.billId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BillFormBloc>(
              create: (context) =>
                  sl()..add(BillFormInitEvent(billId, contractId))),
          BlocProvider<PhotoSectionBloc>(create: (context) => sl()),
        ],
        child: BlocConsumer<BillFormBloc, BaseBillFormState>(
            builder: (context, state) {
          if (state is BillFormLoading) {
            return const CupertinoActivityIndicator();
          }
          return _buildBody(context);
        }, listener: (context, state) {
          if (state is GetPhotoFailed) {
            showAlertDialog(context, "Add photo fail");
          }
          if (state is BillFormError) {
            showAlertDialog(context, state.errorMessage!);
          }
        }));
  }

  Widget _buildBody(BuildContext context) {
    var billBloc = context.read<BillFormBloc>();
    var roomPriceController =
        TextEditingController(text: '${billBloc.roomPrice}');
    var electricPriceController =
        TextEditingController(text: '${billBloc.electricPrice}');
    var waterPriceController =
        TextEditingController(text: '${billBloc.waterPrice}');
    var electricFromController = TextEditingController(
        text: billBloc.electricFrom == null
            ? ''
            : DateFormat('dd, MMM y').format(billBloc.electricFrom!));
    var electricToController = TextEditingController(
        text: billBloc.electricTo == null
            ? ''
            : DateFormat('dd, MMM y').format(billBloc.electricTo!));
    var electricCurrentController =
        TextEditingController(text: '${billBloc.electricCurrent}');
    var electricLastController =
        TextEditingController(text: '${billBloc.electricLast}');
    var electricValueController = TextEditingController(
        text: '${billBloc.electricCurrent! - billBloc.electricLast!}');
    var electricTotalController = TextEditingController(
        text:
            '${(billBloc.electricCurrent! - billBloc.electricLast!) * billBloc.electricPrice!}');
    var waterFromController = TextEditingController(
        text: billBloc.waterFrom == null
            ? ''
            : DateFormat('dd, MMM y').format(billBloc.waterFrom!));
    var waterToController = TextEditingController(
        text: billBloc.waterTo == null
            ? ''
            : DateFormat('dd, MMM y').format(billBloc.waterTo!));
    var waterCurrentController =
        TextEditingController(text: '${billBloc.waterCurrent}');
    var waterLastController =
        TextEditingController(text: '${billBloc.waterLast}');
    var waterValueController = TextEditingController(
        text: '${billBloc.waterCurrent! - billBloc.waterLast!}');
    var waterTotalController = TextEditingController(
        text:
            '${(billBloc.waterCurrent! - billBloc.waterLast!) * billBloc.waterPrice!}');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //billBloc.add()
              },
              icon: const Icon(Icons.check))
        ],
        title: const Text('Bill'),
      ),
      body: FormContainer(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SectionWithBottomBorder(
              child: TextField(
            controller: roomPriceController,
            decoration: const InputDecoration(
                label: Text("Room price"), suffixText: 'VND'),
          )),
          HorizontalDivider(text: 'Electric'),
          _electricSection(
              context,
              billBloc,
              electricFromController,
              electricToController,
              electricPriceController,
              electricLastController,
              electricCurrentController,
              electricValueController,
              electricTotalController),
          HorizontalDivider(
            text: 'Water',
          ),
          _waterSection(
              context,
              billBloc,
              waterFromController,
              waterToController,
              waterPriceController,
              waterLastController,
              waterCurrentController,
              waterValueController,
              waterTotalController),
        ]),
      ),
    );
  }

  Widget _electricSection(
    BuildContext context,
    BillFormBloc billBloc,
    TextEditingController electricFromController,
    TextEditingController electricToController,
    TextEditingController electricPriceController,
    TextEditingController electricLastController,
    TextEditingController electricCurrentController,
    TextEditingController electricValueController,
    TextEditingController electricTotalController,
  ) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
              controller: electricFromController,
              readOnly: true,
              onTap: () async {
                var selectedDate = await selectDate(
                    context,
                    DateTime(1900),
                    billBloc.electricTo == null
                        ? DateTime(3000)
                        : billBloc.electricTo!.add(const Duration(days: -1)),
                    billBloc.electricFrom ??
                        DateTime(
                            DateTime.now().year, DateTime.now().month - 1));
                billBloc.add(BillFormChangeDateEvent(selectedDate,
                    billBloc.electricTo, billBloc.waterFrom, billBloc.waterTo));
              },
              decoration: const InputDecoration(
                  label: Text("Electric from date"),
                  suffixIcon: Icon(Icons.calendar_month)),
            )),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
              controller: electricToController,
              readOnly: true,
              onTap: () async {
                var selectedDate = await selectDate(
                  context,
                  billBloc.electricFrom == null
                      ? DateTime(1900)
                      : billBloc.electricFrom!.add(const Duration(days: 1)),
                  DateTime(3000),
                  billBloc.electricFrom == null
                      ? DateTime.now()
                      : billBloc.electricFrom!.add(const Duration(days: 1)),
                );
                billBloc.add(BillFormChangeDateEvent(billBloc.electricFrom,
                    selectedDate, billBloc.waterFrom, billBloc.waterTo));
              },
              decoration: const InputDecoration(
                  label: Text("To date"),
                  suffixIcon: Icon(Icons.calendar_month)),
            )),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: electricLastController,
                    readOnly: true,
                    onChanged: (value) {
                      if (double.tryParse(value) == null) {
                        value = '0';
                      }
                      billBloc.add(BillFormChangeTextEvent(
                          billBloc.roomPrice?.toString(),
                          billBloc.electricPrice?.toString(),
                          billBloc.electricCurrent?.toString(),
                          value,
                          billBloc.waterPrice?.toString(),
                          billBloc.waterCurrent?.toString(),
                          billBloc.waterLast?.toString()));
                    },
                    decoration: const InputDecoration(
                      label: Text("Electric previous value"),
                    ))),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: electricCurrentController,
                    readOnly: true,
                    onChanged: (value) {
                      if (double.tryParse(value) == null) {
                        value = '0';
                      }
                      billBloc.add(BillFormChangeTextEvent(
                          billBloc.roomPrice?.toString(),
                          billBloc.electricPrice?.toString(),
                          value,
                          billBloc.electricLast?.toString(),
                          billBloc.waterPrice?.toString(),
                          billBloc.waterCurrent?.toString(),
                          billBloc.waterLast?.toString()));
                    },
                    decoration: const InputDecoration(
                      label: Text("Electric current value"),
                    ))),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: electricValueController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text("Electric used"),
                    ))),
          ),
          const SizedBox(
            width: 50,
            child: Text(
              'X',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: electricPriceController,
                    readOnly: true,
                    onChanged: (value) {
                      if (double.tryParse(value) == null) {
                        value = '0';
                      }
                      billBloc.add(BillFormChangeTextEvent(
                          billBloc.roomPrice?.toString(),
                          value,
                          billBloc.electricCurrent?.toString(),
                          billBloc.electricTo?.toString(),
                          billBloc.waterPrice?.toString(),
                          billBloc.waterCurrent?.toString(),
                          billBloc.waterLast?.toString()));
                    },
                    decoration: const InputDecoration(
                      label: Text("Electric price"),
                    ))),
          ),
          const SizedBox(
            width: 50,
            child: Text(
              '=',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: electricTotalController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text("Electric total price"),
                    ))),
          ),
        ],
      ),
    ]);
  }

  Widget _waterSection(
    BuildContext context,
    BillFormBloc billBloc,
    TextEditingController waterFromController,
    TextEditingController waterToController,
    TextEditingController waterPriceController,
    TextEditingController waterLastController,
    TextEditingController waterCurrentController,
    TextEditingController waterValueController,
    TextEditingController waterTotalController,
  ) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
              controller: waterFromController,
              readOnly: true,
              onTap: () async {
                var selectedDate = await selectDate(
                    context,
                    DateTime(1900),
                    billBloc.waterTo == null
                        ? DateTime(3000)
                        : billBloc.waterTo!.add(const Duration(days: -1)),
                    billBloc.waterFrom ??
                        DateTime(
                            DateTime.now().year, DateTime.now().month - 1));
                billBloc.add(BillFormChangeDateEvent(selectedDate,
                    billBloc.waterTo, billBloc.waterFrom, billBloc.waterTo));
              },
              decoration: const InputDecoration(
                  label: Text("Water from date"),
                  suffixIcon: Icon(Icons.calendar_month)),
            )),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
              controller: waterToController,
              readOnly: true,
              onTap: () async {
                var selectedDate = await selectDate(
                  context,
                  billBloc.waterFrom == null
                      ? DateTime(1900)
                      : billBloc.waterFrom!.add(const Duration(days: 1)),
                  DateTime(3000),
                  billBloc.waterFrom == null
                      ? DateTime.now()
                      : billBloc.waterFrom!.add(const Duration(days: 1)),
                );
                billBloc.add(BillFormChangeDateEvent(billBloc.waterFrom,
                    selectedDate, billBloc.waterFrom, billBloc.waterTo));
              },
              decoration: const InputDecoration(
                  label: Text("To date"),
                  suffixIcon: Icon(Icons.calendar_month)),
            )),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: waterLastController,
                    readOnly: false,
                    onChanged: (value) {
                      if (double.tryParse(value) == null) {
                        value = '0';
                      }
                      billBloc.add(BillFormChangeTextEvent(
                          billBloc.roomPrice?.toString(),
                          billBloc.electricPrice?.toString(),
                          billBloc.electricCurrent?.toString(),
                          billBloc.electricLast?.toString(),
                          billBloc.waterPrice?.toString(),
                          billBloc.waterCurrent?.toString(),
                          value));
                    },
                    decoration: const InputDecoration(
                      label: Text("Water previous value"),
                    ))),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: waterCurrentController,
                    readOnly: false,
                    onChanged: (value) {
                      if (double.tryParse(value) == null) {
                        value = '0';
                      }
                      billBloc.add(BillFormChangeTextEvent(
                          billBloc.roomPrice?.toString(),
                          billBloc.electricPrice?.toString(),
                          billBloc.electricCurrent?.toString(),
                          billBloc.electricLast?.toString(),
                          billBloc.waterPrice?.toString(),
                          value,
                          billBloc.waterLast?.toString()));
                    },
                    decoration: const InputDecoration(
                      label: Text("Water current value"),
                    ))),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: waterValueController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text("Water used"),
                    ))),
          ),
          const SizedBox(
            width: 50,
            child: Text(
              'X',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: waterPriceController,
                    readOnly: false,
                    onChanged: (value) {
                      if (double.tryParse(value) == null) {
                        value = '0';
                      }
                      billBloc.add(BillFormChangeTextEvent(
                          billBloc.roomPrice?.toString(),
                          billBloc.electricPrice?.toString(),
                          billBloc.electricCurrent?.toString(),
                          billBloc.electricTo?.toString(),
                          value,
                          billBloc.waterCurrent?.toString(),
                          billBloc.waterLast?.toString()));
                    },
                    decoration: const InputDecoration(
                      label: Text("Water price"),
                    ))),
          ),
          const SizedBox(
            width: 50,
            child: Text(
              '=',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SectionWithBottomBorder(
                child: TextField(
                    controller: waterTotalController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text("Water total price"),
                    ))),
          ),
        ],
      ),
    ]);
  }
}
