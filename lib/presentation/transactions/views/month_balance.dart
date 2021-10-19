import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organeasy/internal/double_extensions.dart';
import 'package:organeasy/presentation/transactions/cubit/load_monthly_balance_cubit.dart';

class MonthBalance extends StatelessWidget {
  const MonthBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color onSurfaceColor = Theme.of(context).colorScheme.onSurface;

    return BlocBuilder<LoadMonthlyBalanceCubit, LoadMonthlyBalanceState>(
      builder: (context, state) {
        switch (state.state) {
          case LoadMonthlyBalanceStates.collapsed:
            return const SizedBox();
          case LoadMonthlyBalanceStates.loading:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                Divider(),
              ],
            );
          case LoadMonthlyBalanceStates.expanded:
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _formattedText(onSurfaceColor, "Saldo receitas: ", state.data!.totalIncome.toMonetary()),
                      _formattedText(onSurfaceColor, "Saldo despesas: ", state.data!.totalExpense.toMonetary()),
                      _formattedText(onSurfaceColor, "Saldo poupança: ", state.data!.totalSavings.toMonetary()),
                      _formattedText(onSurfaceColor, "Saldo investimentos: ", state.data!.totalInvestments.toMonetary()),
                    ],
                  ),
                ),
                Divider(),
              ],
            );
        }
      },
    );
  }

  RichText _formattedText(Color onSurfaceColor, String text1, String text2) => RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14.0, color: onSurfaceColor),
          children: <TextSpan>[
            TextSpan(text: text1, style: TextStyle(fontSize: 16)),
            TextSpan(text: text2, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
}
