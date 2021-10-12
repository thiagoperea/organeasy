import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';

class TransactionItem extends StatelessWidget {
  final TransactionData transaction;
  final CategoryData category;
  final bool isFirst;
  final bool isLast;

  const TransactionItem({Key? key, required this.transaction, required this.category, this.isFirst = false, this.isLast = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          print("CLICKED ON $transaction");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 16),
            _TimelineView(isFirst, isLast, transaction.isDone),
            SizedBox(width: 16),
            _DescriptionView(transaction, category),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                NumberFormat.simpleCurrency().format(transaction.value),
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class _TimelineView extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isDone;

  const _TimelineView(this.isFirst, this.isLast, this.isDone, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color lineColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.35);

    final Color firstColor = isFirst ? Colors.transparent : lineColor;
    final IconData indicatorIcon = isDone ? FontAwesomeIcons.solidCheckCircle : FontAwesomeIcons.exclamationCircle;
    final Color indicatorColor = isDone ? Colors.green : Colors.red;
    final Color lastColor = isLast ? Colors.transparent : lineColor;

    return Column(
      children: [
        Container(width: 1, height: 48, color: firstColor),
        FaIcon(indicatorIcon, color: indicatorColor, size: 20),
        Container(width: 1, height: 48, color: lastColor),
      ],
    );
  }
}

class _DescriptionView extends StatelessWidget {
  final TransactionData _transaction;
  final CategoryData _category;

  const _DescriptionView(this._transaction, this._category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dueDate = DateFormat.Md().format(_transaction.dueDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dueDate,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 4),
        Text(
          _transaction.description,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Colors.green.shade300,
          ),
          child: Text(
            _category.description,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
