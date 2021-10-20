import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organeasy/presentation/home/cubit/home_actions_cubit.dart';
import 'package:organeasy/presentation/home/cubit/home_actions_state.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeActionsCubit, HomeActionsState>(
      listener: (context, state) {
        if (state.action == HomeActions.screenHelp) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Help clicked!!"))); //TODO: showcase plugin
        }
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8),
          children: [
            GoalsItem(),
            GoalsItem(),
            GoalsItem(),
            GoalsItem(),
            GoalsItem(),
            GoalsItem(),
            GoalsItem(),
            GoalsItem(),
            GoalsItem(),
            GoalsItem(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onAddClick(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _onAddClick() {}
}

class GoalsItem extends StatelessWidget {
  const GoalsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade100,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _GoalTitle(),
                    SizedBox(height: 32),
                    _GoalSubtitle(),
                  ],
                ),
              ),
              _GoalProgress(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalTitle extends StatelessWidget {
  const _GoalTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green.shade200),
          padding: EdgeInsets.all(8),
          child: Icon(Icons.house, color: Colors.white),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("TITLE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black54)),
            Text("SUBTITLE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38)),
          ],
        )
      ],
    );
  }
}

class _GoalSubtitle extends StatelessWidget {
  const _GoalSubtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mock = Random().nextBool() ? "\$5.000,00" : "\$400,00 de \$1.000,00";

    return Text(mock, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54));
  }
}

class _GoalProgress extends StatelessWidget {
  const _GoalProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: 72,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green.shade200),
          ),
          CircularProgressIndicator(
            value: 0.35,
            backgroundColor: Colors.green.shade300,
            color: Colors.green.shade700,
          ),
          Icon(Icons.attach_money_rounded, size: 40, color: Colors.white),
        ],
      ),
    );
  }
}
