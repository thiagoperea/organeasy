import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organeasy/common_widgets/progress_loading.dart';
import 'package:organeasy/presentation/home/cubit/home_cubit.dart';
import 'package:organeasy/presentation/home/cubit/home_state.dart';
import 'package:organeasy/presentation/new_transaction/new_transaction_page.dart';
import 'package:organeasy/presentation/transactions/cubit/load_monthly_balance_cubit.dart';
import 'package:organeasy/presentation/transactions/cubit/load_transactions_cubit.dart';
import 'package:organeasy/presentation/transactions/views/month_balance.dart';
import 'package:organeasy/presentation/transactions/views/month_header.dart';
import 'package:organeasy/presentation/transactions/views/transaction_list.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final LoadTransactionsCubit _loadTransactionsCubit = LoadTransactionsCubit(); //TODO: should I have this "load" prefix??
  final LoadMonthlyBalanceCubit _loadMonthlyBalanceCubit = LoadMonthlyBalanceCubit();

  @override
  void initState() {
    _loadTransactionsCubit.loadTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _loadTransactionsCubit),
        BlocProvider(create: (_) => _loadMonthlyBalanceCubit),
      ],
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
                onPreviousClick: () => _onPreviousMonthClick(),
                onNextClick: () => _onNextMonthClick(),
                onInfoClick: () => onMonthBalanceClick(),
              ),
              Divider(),
              MonthBalance(),
              Expanded(
                child: BlocBuilder<LoadTransactionsCubit, LoadTransactionsState>(
                  builder: (context, state) {
                    switch (state.state) {
                      case LoadTransactionsStates.loading:
                        return Center(
                          child: ProgressLoading(loadingDescription: "Carregando..."),
                        );
                      case LoadTransactionsStates.success:
                        return TransactionList(dataset: state.dataset!);
                      case LoadTransactionsStates.error:
                        return Center(
                          child: Container(width: 50, height: 50, color: Colors.red), //TODO!
                        );
                    }
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
                onPressed: () => _onAddMultipleClick(context),
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
      _loadTransactionsCubit.loadTransactions();
    }
  }

  void _onPreviousMonthClick() {
    _loadTransactionsCubit.setPreviousMonth();
    DateTime monthSelected = _loadTransactionsCubit.monthSelected;
    _loadMonthlyBalanceCubit.refreshExpanded(monthSelected);
  }

  void _onNextMonthClick() {
    _loadTransactionsCubit.setNextMonth();
    DateTime monthSelected = _loadTransactionsCubit.monthSelected;
    _loadMonthlyBalanceCubit.refreshExpanded(monthSelected);
  }

  void onMonthBalanceClick() {
    DateTime monthSelected = _loadTransactionsCubit.monthSelected;
    _loadMonthlyBalanceCubit.expandOrCollapse(monthSelected);
  }

  void _onAddMultipleClick(BuildContext context) {
    //TODO
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Falta implementar!")));
  }
}
