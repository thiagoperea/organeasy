import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:organeasy/data/model/transaction_data.dart';

class TransactionsPage extends StatelessWidget {
  TransactionsPage({Key? key}) : super(key: key);

  final List<TransactionData> _mockItems = [
    TransactionData(
      walletId: 0,
      transactionType: TransactionType.receive.index,
      description: "Teste",
      dueDate: DateTime.now(),
      value: 100.0,
      isDone: true,
    ),
    TransactionData(
        walletId: 0,
        transactionType: TransactionType.pay.index,
        description: "Teste ontem",
        dueDate: DateTime.now().add(Duration(days: -1)),
        value: 200.0,
        isDone: false),
    TransactionData(
      walletId: 0,
      transactionType: TransactionType.save.index,
      description: "Teste poup",
      dueDate: DateTime.now(),
      value: 50.0,
      isDone: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 12),
          Text(
            "Transactions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _mockItems.length,
              itemBuilder: (context, idx) => _TransactionItem(
                data: _mockItems[idx],
                isFirst: idx == 0,
                isLast: idx == (_mockItems.length - 1),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final TransactionData data;
  final bool isFirst;
  final bool isLast;

  const _TransactionItem({Key? key, required this.data, this.isFirst = false, this.isLast = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          print("CLICKED ON $data");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 16),
            _timelineView(context, isFirst, isLast, data.isDone),
            SizedBox(width: 16),
            _descriptionView(data),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                "R\$ ${data.value}",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _timelineView(BuildContext context, bool isFirst, bool isLast, bool isDone) {
    final Color lineColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.35);
    final Color dotColor = isDone ? Colors.green : Colors.red;
    final Color firstColor = isFirst ? Colors.transparent : lineColor;
    final Color lastColor = isLast ? Colors.transparent : lineColor;

    return Column(
      children: [
        Container(
          width: 1,
          height: 48,
          color: firstColor,
        ),
        Container(
          width: 10,
          height: 10,
          decoration: ShapeDecoration(
            shape: CircleBorder(),
            color: dotColor,
          ),
        ),
        Container(
          width: 1,
          height: 48,
          color: lastColor,
        ),
      ],
    );
  }

  Widget _descriptionView(TransactionData data) {
    String dueDate = DateFormat("dd/MM").format(data.dueDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dueDate,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Text(
          data.description,
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
            "Pagamentos", // ! TODO
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
