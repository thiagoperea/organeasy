import 'package:flutter/material.dart';
import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';
import 'package:organeasy/presentation/transactions/cubit/transactions_cubit.dart';
import 'package:organeasy/presentation/transactions/views/transaction_item.dart';
import 'package:provider/src/provider.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionData> dataset;

  const TransactionList({Key? key, required this.dataset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataset.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text("Nenhuma transação!"),
        ],
      );
    }

    return RefreshIndicator(
      child: ListView.builder(
        itemCount: dataset.length,
        itemBuilder: (context, idx) {
          final TransactionData _item = dataset[idx];
          final CategoryData _category = context.read<TransactionsCubit>().getCategory(_item.categoryId);

          return TransactionItem(
            transaction: _item,
            category: _category,
            isFirst: idx == 0,
            isLast: idx == (dataset.length - 1),
          );
        },
      ),
      onRefresh: () => context.read<TransactionsCubit>().loadTransactions(),
    );
  }
}
