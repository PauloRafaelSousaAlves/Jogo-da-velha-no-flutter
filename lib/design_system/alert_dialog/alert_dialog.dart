import 'package:flutter/material.dart';
import 'package:tic_tac_toe/design_system/color/ds_colors.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTap;

  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: DSColors.black100, width: 2),
      ),
      title: Text(
        textAlign: TextAlign.center,
        title,
        style: const TextStyle(
          color: DSColors.black100,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          color: DSColors.grey100,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(DSColors.grey10),
          ),
          child: const Text(
            'Reiniciar!',
            style: TextStyle(
              color: DSColors.black100,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
