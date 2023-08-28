import 'package:flutter/material.dart';

class TopBoxBottomSheet extends StatelessWidget {
  const TopBoxBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16).copyWith(bottom: 0),
      height: 4,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
