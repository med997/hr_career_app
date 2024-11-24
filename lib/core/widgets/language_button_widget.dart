import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/locale_cubit.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';

import '../../features/home/presentation/bloc/tab_nav_cubit.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key, required this.clr});
  final Color clr;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(4),

        minWidth: 16,
        child: Icon(Icons.language, color: clr,size: 22,),
      onPressed: () {
        _showLanguageDialog(context);
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(

      context: context,
      builder: (BuildContext _) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
           width:400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      context.locale.languageCode == 'ar' ? 'أختر اللغة' : 'Choose Language',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.language, color: primaryColor),
                      title: const Text('English Language'),
                      onTap: () async{
                        context.locale.languageCode == 'en'? _showSnackBar(context,
                              'The Language is already English ')
                            : await context.setLocale(context.supportedLocales[0]);

                          Navigator.pop(_);
                        // context.locale.languageCode == 'en' ? null : context.read<TabNavCubit>().changeTab(0);
                      },
                    ),
                    const Divider(thickness: 2,),
                    ListTile(
                      leading: const Icon(Icons.language, color: primaryColor),
                      title: const Text('اللغة العربية'),
                      onTap: () async{

                        context.locale.languageCode == 'ar' ?  _showSnackBar(context,
                           'لغة التطبيق عربية بالفعل'):
                        await context.setLocale(context.supportedLocales[1]);

                        Navigator.pop(_);


                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                      'cancel'.tr(),
                      ),
                    ),
                  ],
                )

          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}