import 'package:flutter/material.dart';

class DueDateField extends StatelessWidget {
  final TextEditingController controller;
  final Function onTap;

  const DueDateField({Key? key, required this.controller, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        onTap();
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: "Data da transação",
        labelText: "Data",
        prefixIcon: Icon(Icons.date_range_rounded),
        border: OutlineInputBorder(),
      ),
    );
  }
}
