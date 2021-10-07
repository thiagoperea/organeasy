import 'package:flutter/material.dart';
import 'package:organeasy/data/model/goal_data.dart';

class GoalDropdown extends StatefulWidget {
  final List<GoalData> goalsList;
  final Function(int) onValueChanged;

  const GoalDropdown({Key? key, required this.goalsList, required this.onValueChanged}) : super(key: key);

  @override
  _GoalDropdownState createState() => _GoalDropdownState();
}

class _GoalDropdownState extends State<GoalDropdown> {
  int _selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Objetivo",
        hintText: "Selecione o objetivo",
        border: OutlineInputBorder(),
      ),
      items: widget.goalsList.map((entry) => DropdownMenuItem(value: entry.id, child: Text(entry.description))).toList(),
      value: _selectedIdx,
      onChanged: (newValue) {
        setState(() {
          _selectedIdx = newValue!;
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
