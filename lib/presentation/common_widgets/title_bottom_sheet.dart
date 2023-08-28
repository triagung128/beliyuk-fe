import 'package:flutter/material.dart';

class TitleBottomSheet extends StatelessWidget {
  final String titleText;

  const TitleBottomSheet({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        Text(
          titleText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
