import 'package:flutter/material.dart';

Future<DateTime?> selectDate(BuildContext context, DateTime? firstDate,
    DateTime? lastDate, DateTime? initialDate) async {
  if (lastDate == null) {
    return null;
  }
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    firstDate: firstDate ?? DateTime.now(),
    lastDate: lastDate,
    initialDate: initialDate ?? firstDate!,
  );
  return pickedDate;
}

Future<TimeOfDay?> selectTime(
    BuildContext context, TimeOfDay initialTime) async {
  var selectedTime = await showTimePicker(
    initialTime: TimeOfDay.now(),
    orientation: Orientation.portrait,
    context: context,
  );
  return selectedTime;
}
