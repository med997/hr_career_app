import 'package:easy_localization/easy_localization.dart';
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
          child: MaterialButton(
            color: primaryColor,
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            height: 35,
            minWidth: 260,
            child:   Text('done'.tr(),style: TextStyle(color: Colors.white),),
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
