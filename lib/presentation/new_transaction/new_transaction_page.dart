import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/goal_data.dart';
import 'package:organeasy/internal/money_mask.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({Key? key}) : super(key: key);

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  // ! TODO: THIS WILL BE RETRIEVED FROM BLOC
  final _categoryList = [
    CategoryData(id: 0, description: "Receita"),
    CategoryData(id: 1, description: "Aposentadoria"),
    CategoryData(id: 2, description: "Reserva de Emergência"),
    CategoryData(id: 3, description: "Necessidade"),
    CategoryData(id: 4, description: "Lazer"),
    CategoryData(id: 5, description: "Doação"),
    CategoryData(id: 1337, description: "Objetivo"),
  ];

  final _goalsList = [
    GoalData(id: 0, description: "Casa", dueDate: DateTime.now(), goalValue: 20000.00, currentValue: 500.00),
    GoalData(id: 1, description: "Carro", dueDate: DateTime.now(), goalValue: 1000.00, currentValue: 700.00),
    GoalData(id: 2, description: "Computador", dueDate: DateTime.now(), goalValue: 5000.00, currentValue: 1500.00),
  ];

  int? _categorySelectedKey;
  int? _goalSelectedKey;
  bool _isGoalSelected = false;

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
              bool? isValid = _formKey.currentState?.validate();

              if (isValid != null && isValid == true) {
                // ! TODO: SAVE TRANSACTION
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OK PRA SALVAR!")));
              }
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
              Visibility(child: _goalField(), visible: _isGoalSelected),
              Visibility(child: SizedBox(height: 16), visible: _isGoalSelected),
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
        items: _categoryList.map((entry) => DropdownMenuItem(value: entry.id, child: Text(entry.description))).toList(),
        value: _categorySelectedKey,
        onChanged: (newValue) {
          // ! TODO: THIS IS A FUNCTION!!!
          _categorySelectedKey = newValue;

          bool isGoal = false;
          if (newValue == 1337) {
            isGoal = true;
          }

          if (isGoal != _isGoalSelected) {
            setState(() {
              _isGoalSelected = isGoal;
            });
          }
        },
        validator: (currentValue) {
          if (currentValue == null) {
            return "Campo obrigatório";
          }
          return null;
        },
      );

  Widget _goalField() => DropdownButtonFormField<int>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: "Objetivo",
          hintText: "Selecione o objetivo",
          border: OutlineInputBorder(),
        ),
        items: _goalsList.map((entry) => DropdownMenuItem(value: entry.id, child: Text(entry.description))).toList(),
        onChanged: (newValue) => _goalSelectedKey = newValue,
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
