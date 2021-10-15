import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organeasy/common_widgets/progress_loading.dart';
import 'package:organeasy/presentation/home/cubit/home_cubit.dart';
import 'package:organeasy/presentation/home/cubit/home_state.dart';
import 'package:organeasy/presentation/new_transaction/new_transaction_page.dart';
import 'package:organeasy/presentation/transactions/cubit/transactions_cubit.dart';
import 'package:organeasy/presentation/transactions/views/month_header.dart';
import 'package:organeasy/presentation/transactions/views/transaction_list.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TransactionsCubit _cubit = TransactionsCubit();
  bool _showDetails = false;

  @override
  void initState() {
    _cubit.loadTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionsCubit>(
      create: (context) => _cubit,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeActionMenuPressed && state.action == HomeActions.screenHelp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Help clicked!!"))); //TODO: showcase plugin
          }
        },
        child: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              MonthHeader(
                onInfoClick: () {
                  setState(() {
                    _showDetails = !_showDetails;
                  });
                },
              ),
              Divider(),
              Visibility(
                visible: _showDetails,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Saldo receitas: 11111"),
                    Text("Saldo despesas: 22222"),
                    Text("Saldo poupança: 33333"),
                    Text("Saldo investimentos: 44444"),
                    Divider(),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<TransactionsCubit, TransactionsState>(
                  builder: (context, state) {
                    if (state is TransactionsLoading) {
                      return Center(
                        child: ProgressLoading(loadingDescription: "Carregando..."),
                      );
                    }
                    if (state is TransactionsLoaded) {
                      return TransactionList(dataset: state.dataset);
                    }

                    if (state is TransactionsError) {
                      return Center(
                        child: Container(width: 50, height: 50, color: Colors.red),
                      );
                    }

                    return Container();
                  },
                ),
              )
            ],
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
