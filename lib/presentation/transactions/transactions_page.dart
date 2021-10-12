import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organeasy/common_widgets/progress_loading.dart';
import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';
import 'package:organeasy/presentation/new_transaction/new_transaction_page.dart';
import 'package:organeasy/presentation/transactions/cubit/transactions_cubit.dart';
import 'package:organeasy/presentation/transactions/views/transaction_item.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TransactionsCubit _cubit = TransactionsCubit();

  @override
  void initState() {
    _cubit.loadTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionsCubit>(
      create: (context) => _cubit,
      child: Scaffold(
        body: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded),
                      onPressed: state is TransactionsLoading ? null : () => _cubit.setPreviousMonth(),
                    ),
                    Text(state.selectedMonth, style: TextStyle(fontSize: 18.0)),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: state is TransactionsLoading ? null : () => _cubit.setNextMonth(),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: Builder(builder: (ctx) {
                    if (state is TransactionsLoading) {
                      return Center(
                        child: ProgressLoading(loadingDescription: "Carregando..."),
                      );
                    }

                    if (state is TransactionsLoaded) {
                      return _TransactionList(dataset: state.dataset);
                    }

                    if (state is TransactionsError) {
                      return Center(
                        child: Container(width: 50, height: 50, color: Colors.red),
                      );
                    }

                    return Container();
                  }),
                )
              ],
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 0,
              onPressed: () {},
              child: Icon(Icons.playlist_add_rounded),
              mini: true,
              tooltip: "Add Multiple",
            ),
            SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 1,
              onPressed: () => _onAddSingleClick(context),
              child: Icon(Icons.add_rounded),
              mini: true,
              tooltip: "Add single",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAddSingleClick(BuildContext context) async {
    bool wasCreated = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (_) => NewTransactionPage())) ?? false;

    if (wasCreated) {
      _cubit.loadTransactions();
    }
  }
}

class _TransactionList extends StatelessWidget {
  final List<TransactionData> dataset;

  const _TransactionList({Key? key, required this.dataset}) : super(key: key);

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
