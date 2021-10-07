import 'package:flutter/material.dart';
import 'package:organeasy/data/model/transaction_data.dart';

class TransactionTypeDropdown extends StatefulWidget {
  final Function(int) onValueChanged;

  const TransactionTypeDropdown({Key? key, required this.onValueChanged}) : super(key: key);

  @override
  State<TransactionTypeDropdown> createState() => _TransactionTypeDropdownState();
}

class _TransactionTypeDropdownState extends State<TransactionTypeDropdown> {
  int _selectedType = 0;

  final _types = [
    DropdownMenuItem(value: TransactionType.pay.index, child: Text("Pagar")),
    DropdownMenuItem(value: TransactionType.receive.index, child: Text("Receber")),
    DropdownMenuItem(value: TransactionType.save.index, child: Text("Guardar")),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: "Categoria",
        hintText: "Selecione a categoria",
        border: OutlineInputBorder(),
      ),
      items: _types,
      value: _selectedType,
      onChanged: (newValue) {
        setState(() {
          _selectedType = newValue!;
          widget.onValueChanged(newValue);
        });
      },
      validator: (currentValue) {
        if (currentValue == null) {
          return "Campo obrigatório";
        }
        return null;
      },
    );
  }
}
