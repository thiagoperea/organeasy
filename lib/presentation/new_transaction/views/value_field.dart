import 'package:flutter/material.dart';
import 'package:organeasy/internal/money_mask.dart';
import 'package:organeasy/internal/string_extensions.dart';

class ValueField extends StatelessWidget {
  final TextEditingController controller;

  const ValueField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Valor da transação",
        labelText: "Valor",
      ),
      maxLength: 20,
      keyboardType: TextInputType.number,
      inputFormatters: [MoneyMask()],
      validator: (currentValue) {
        if (currentValue != null && currentValue.toOnlyDigits().toDouble() == 0.0) {
          return "Campo obrigatório";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
