import 'package:flutter/material.dart';

class SaveDataButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SaveDataButton({
    super.key,
    this.text = 'Guardar',
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A3C50),
          disabledBackgroundColor: const Color(0xFF1A3C50).withOpacity(0.5),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Colors.white,
          ),
        )
            : Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}