import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/internal/money_mask.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({Key? key}) : super(key: key);

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  // ! TODO: THIS WILL BE RETRIEVED FROM BLOC
  final _categoryList = [
    CategoryData(id: 0, description: "Receitas"),
    CategoryData(id: 1, description: "Aposentadoria"),
    CategoryData(id: 2, description: "Reserva de Emergência"),
    CategoryData(id: 3, description: "Necessidades"),
    CategoryData(id: 4, description: "Lazer"),
    CategoryData(id: 5, description: "Doação"),
  ];
  int? _categorySelectedKey;

  final TextEditingController _dateController = TextEditingController(text: DateFormat.yMd().format(DateTime.now()));
  final TextEditingController _valueController = TextEditingController(text: NumberFormat.simpleCurrency().format(0.0));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Transaction"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_rounded),
            onPressed: () {
              _formKey.currentState?.validate();
              // ! TODO: SAVE TRANSACTION
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _categoryDropdownField(),
              SizedBox(height: 16),
              _descriptionField(),
              SizedBox(height: 16),
              _datePickerField(),
              SizedBox(height: 16),
              _valueField(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getDueDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 1, 1),
      lastDate: DateTime(2030, 1, 1),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  /// Creates the date picker field
  Widget _datePickerField() => TextFormField(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); // remove focus on click
          _getDueDate();
        },
        controller: _dateController,
        decoration: InputDecoration(
          hintText: "Data da transação",
          labelText: "Data",
          prefixIcon: Icon(Icons.date_range_rounded),
          border: OutlineInputBorder(),
        ),
      );

  Widget _categoryDropdownField() => DropdownButtonFormField<int>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: "Categoria",
          hintText: "Selecione a categoria",
          border: OutlineInputBorder(),
        ),
        items: _categoryList.map<DropdownMenuItem<int>>((entry) => DropdownMenuItem(value: entry.id, child: Text(entry.description))).toList(),
        value: _categorySelectedKey,
        onChanged: (newValue) => _categorySelectedKey = newValue,
        validator: (currentValue) {
          if (currentValue == null) {
            return "Campo obrigatório";
          }
          return null;
        },
      );

  Widget _descriptionField() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Descrição da transação",
          labelText: "Descrição",
        ),
        validator: (currentValue) {
          if (currentValue == null || currentValue.isEmpty) {
            return "Campo obrigatório";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  /// Value field with mask
  Widget _valueField() => TextFormField(
        controller: _valueController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Valor da transação",
          labelText: "Valor",
        ),
        maxLength: 20,
        keyboardType: TextInputType.number,
        inputFormatters: [MoneyMask()],
        validator: (currentValue) {
          String _onlyDigits = currentValue?.replaceAll(RegExp(r"[^0-9]"), "") ?? "";
          double _asDecimal = double.tryParse(_onlyDigits) ?? 0.0;

          if (_asDecimal == 0.0) {
            return "Campo obrigatório";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );
}
