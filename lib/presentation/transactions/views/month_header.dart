import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organeasy/presentation/transactions/cubit/transactions_cubit.dart';

class MonthHeader extends StatelessWidget {
  final Function onInfoClick;

  const MonthHeader({Key? key, required this.onInfoClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) => Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: state is TransactionsLoading ? null : () => context.read<TransactionsCubit>().setPreviousMonth(),
              ),
              Text(state.selectedMonth, style: TextStyle(fontSize: 18.0)),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                onPressed: state is TransactionsLoading ? null : () => context.read<TransactionsCubit>().setNextMonth(),
              ),
            ],
          ),
          Align(
            child: IconButton(
              onPressed: () => onInfoClick(),
              icon: FaIcon(FontAwesomeIcons.searchDollar),
            ),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}
