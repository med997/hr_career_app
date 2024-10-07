import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../app_theme.dart';
class SuccessDialog extends StatelessWidget {
  final String message;
  final Function onDonePressed;
  const SuccessDialog({super.key, required this.message, required this.onDonePressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      content: Lottie.asset('assets/animation/success_animation.json',height: 160,repeat: false),
      actions: <Widget>[
         Center(
            child: Text(
              message,
              style: const TextStyle(
                  color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
            )),
        Center(
          heightFactor: 2,
          child: ElevatedButton(
            style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 150)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)))),
            child: const Text(
              'Done',
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onDonePressed();
            },
          ),
        )
      ],
    );
  }
}
