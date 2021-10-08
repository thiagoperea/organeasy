import 'package:flutter/material.dart';

class ProgressLoading extends StatelessWidget {
  final String loadingDescription;

  const ProgressLoading({Key? key, required this.loadingDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 8),
        Text(loadingDescription),
      ],
    );
  }
}
