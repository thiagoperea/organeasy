import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/goal_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';

import 'package:organeasy/internal/money_mask.dart';
import 'package:organeasy/internal/string_extensions.dart';
import 'package:organeasy/presentation/new_transaction/cubit/new_transaction_cubit.dart';
import 'package:organeasy/presentation/new_transaction/views/category_dropdown.dart';
import 'package:organeasy/presentation/new_transaction/views/description_field.dart';
import 'package:organeasy/presentation/new_transaction/views/due_date_field.dart';
import 'package:organeasy/presentation/new_transaction/views/goal_dropdown.dart';
import 'package:organeasy/presentation/new_transaction/views/transaction_type_dropdown.dart';
import 'package:organeasy/presentation/new_transaction/views/value_field.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({Key? key}) : super(key: key);

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  late final NewTransactionCubit _cubit;

  @override
  void initState() {
    _cubit = NewTransactionCubit();
    _cubit.loadScreen();
    super.initState();
  }

  int _transactionType = 0;
  int _categorySelected = 0;
  bool _isGoalSelected = false;
  int? _goalSelected;
  bool _isDoneStatus = true;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(text: DateFormat.yMd().format(DateTime.now()));
  final TextEditingController _valueController = TextEditingController(text: NumberFormat.simpleCurrency().format(0.0));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewTransactionCubit>(
      create: (_) => _cubit,
      child: BlocListener<NewTransactionCubit, NewTransactionState>(
        listener: (context, state) => _doOnStateChanged(context, state),
        child: Scaffold(
          appBar: AppBar(
            title: Text("New Transaction"),
            actions: [
              IconButton(
                icon: const Icon(Icons.check_rounded),
                onPressed: () => _onSavePressed(),
              ),
            ],
          ),
          body: BlocBuilder<NewTransactionCubit, NewTransactionState>(
            builder: (ctx, state) {
              if (state is LoadingScreen) {
                return Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TransactionTypeDropdown(
                        onValueChanged: (newValue) => _transactionType = newValue,
                      ),
                      SizedBox(height: 16),
                      CategoryDropdown(
                        categoryList: _cubit.getCategoryList(),
                        onValueChanged: (newValue) => _onCategoryValueChanged(newValue),
                      ),
                      SizedBox(height: 16),
                      Visibility(
                        child: GoalDropdown(
                          goalsList: _cubit.getGoalList(),
                          onValueChanged: (newValue) => _goalSelected,
                        ),
                        visible: _isGoalSelected,
                      ),
                      Visibility(
                        child: SizedBox(height: 16),
                        visible: _isGoalSelected,
                      ),
                      DescriptionField(controller: _descriptionController),
                      SizedBox(height: 16),
                      DueDateField(
                        controller: _dateController,
                        onTap: () => _getDueDate(),
                      ),
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: ValueField(controller: _valueController)),
                          SizedBox(width: 16),
                          SizedBox(
                            width: 150.0, // TODO: find a better way
                            child: CheckboxListTile(
                              value: _isDoneStatus,
                              onChanged: (isChecked) {
                                setState(() => _isDoneStatus = isChecked!);
                              },
                              title: Text("Finalizado"),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _doOnStateChanged(BuildContext context, NewTransactionState state) {
    if (state is SavingTransaction) {
      // ! TODO: show dialog
      return;
    }

    if (state is TransactionSaved) {
      // ! TODO: remove dialog, show success, return to screen
      return;
    }

    if (state is TransactionError) {
      // ! TODO: remove dialog, show error
      return;
    }
  }

  void _onCategoryValueChanged(int newValue) {
    _categorySelected = newValue;

    bool isGoal = false;
    if (_categorySelected == 1337) {
      isGoal = true;
    }

    if (isGoal != _isGoalSelected) {
      setState(() {
        _isGoalSelected = isGoal;
      });
    }
  }

  Future<void> _getDueDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 1, 1), // ! TODO: INITIAL AND LAST TIME??
      lastDate: DateTime(2030, 1, 1),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  _onSavePressed() {
    bool? isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid == true) {
      _cubit.saveTransaction(
        transactionTypeId: _transactionType,
        categoryId: _categorySelected,
        goalId: _goalSelected,
        description: _descriptionController.text,
        dueDate: _dateController.text,
        totalValue: _valueController.text,
        isDone: _isDoneStatus,
      );
    }
  }
}
