import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
      {Key? key, required this.onSelect, this.defaultValue, required this.text})
      : super(key: key);
  final Function(DateTime? date) onSelect;
  final DateTime? defaultValue;
  final String text;

  void showPickerDate(BuildContext context, DateTime defaultValue) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(value: defaultValue),
        title: Text("Select Date"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, _) {
          onSelect((picker.adapter as DateTimePickerAdapter).value);
        }).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () =>
            showPickerDate(context, defaultValue ?? DateTime.now()),
        child: Text(text));
  }
}
