import 'package:flutter/material.dart';

/// Botão reutilizável customizado
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isPrimary ? Theme.of(context).primaryColor : Colors.white;
    final textColor = isPrimary ? Colors.white : Theme.of(context).primaryColor;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white))
          : Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
