import 'package:flutter/material.dart';

class ButtonCheckout extends StatelessWidget {
  const ButtonCheckout({
    super.key,
    required this.onPressed,
  });

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_forward, size: 20),
      label: const Text(
        'Lanjut Checkout',
      ),
    );
  }
}
