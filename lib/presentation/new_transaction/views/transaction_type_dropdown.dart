import 'package:flutter/material.dart';
import 'package:organeasy/data/model/transaction_type.dart';

class TransactionTypeDropdown extends StatefulWidget {
  final Function(TransactionType) onValueChanged;

  const TransactionTypeDropdown({Key? key, required this.onValueChanged}) : super(key: key);

  @override
  State<TransactionTypeDropdown> createState() => _TransactionTypeDropdownState();
}

class _TransactionTypeDropdownState extends State<TransactionTypeDropdown> {
  TransactionType _selectedType = TransactionType.expense;

  final _types = [
    DropdownMenuItem(value: TransactionType.expense, child: Text("Pagar")),
    DropdownMenuItem(value: TransactionType.income, child: Text("Receber")),
    DropdownMenuItem(value: TransactionType.investment, child: Text("Guardar")),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TransactionType>(
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
