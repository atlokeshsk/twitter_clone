import 'package:flutter/material.dart';

class RoundedSmallButton extends StatelessWidget {
  const RoundedSmallButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor = Colors.white,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
