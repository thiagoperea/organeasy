import 'package:flutter/material.dart';
import 'package:organeasy/data/model/category_data.dart';

class CategoryDropdown extends StatefulWidget {
  final Function(int) onValueChanged;
  final List<CategoryData> categoryList;

  const CategoryDropdown({Key? key, required this.onValueChanged, required this.categoryList}) : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  int _selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Categoria",
        hintText: "Selecione a categoria",
        border: OutlineInputBorder(),
      ),
      items: widget.categoryList.map((entry) => DropdownMenuItem<int>(value: entry.id, child: Text(entry.description))).toList(),
      value: _selectedIdx,
      onChanged: (newValue) {
        setState(() {
          _selectedIdx = newValue!;
          widget.onValueChanged(_selectedIdx);
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
