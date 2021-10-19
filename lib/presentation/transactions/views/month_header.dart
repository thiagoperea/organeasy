import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organeasy/presentation/transactions/cubit/load_transactions_cubit.dart';

class MonthHeader extends StatelessWidget {
  final Function onPreviousClick;
  final Function onNextClick;
  final Function onInfoClick;

  const MonthHeader({
    Key? key,
    required this.onPreviousClick,
    required this.onNextClick,
    required this.onInfoClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadTransactionsCubit, LoadTransactionsState>(
      builder: (context, state) => Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: state.state == LoadTransactionsStates.loading ? null : () => onPreviousClick(),
              ),
              Text(state.selectedMonth, style: TextStyle(fontSize: 18.0)),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                onPressed: state.state == LoadTransactionsStates.loading ? null : () => onNextClick(),
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
