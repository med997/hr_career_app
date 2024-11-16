import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/reload_btn_cubit.dart';


class ErrWidget extends StatelessWidget {
  final String imgUrl;
  final String errorText;
  final Function clickedReload;

  const ErrWidget(
      {super.key, required this.imgUrl, required this.errorText, required this.clickedReload});

  @override
  Widget build(BuildContext context) {
    return

      BlocProvider(
        create: (context) => ReloadBtnCubit(),
        child: BlocBuilder<ReloadBtnCubit, bool>(
         builder: (context, state) => SizedBox(
              height: 350,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imgUrl, height: 150,),
                    Text(
                      errorText,
                      style: const TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                        child: SizedBox(
                          width: 300,
                          height: 30,

                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {
                              clickedReload();
                            },
                            color: Colors.yellow.shade700,
                            child: const Text(
                              'Refresh',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      );
  }
}

