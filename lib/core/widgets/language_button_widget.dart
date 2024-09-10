import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/locale_cubit.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.language, color: primaryColor,),
      tooltip: 'Choose Language',
      onPressed: () {
        _showLanguageDialog(context);
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      state.locale.languageCode == 'ar' ? 'أختر اللغة' : 'Choose Language',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.language, color: primaryColor),
                      title: const Text('English Language'),
                      onTap: () {
                        Navigator.pop(context);
                        context.read<LocaleCubit>().changeLanguage('en');
                        _showSnackBar(context,
                            state.locale.languageCode == 'en' ? 'The Language is already English' : 'Language changed to English');
                      },
                    ),
                    const Divider(thickness: 2,),
                    ListTile(
                      leading: const Icon(Icons.language, color: primaryColor),
                      title: const Text('اللغة العربية'),
                      onTap: () {
                        Navigator.pop(context);
                        context.read<LocaleCubit>().changeLanguage('ar');
                        _showSnackBar(context,
                            state.locale.languageCode == 'ar' ? 'لغة التطبيق عربية بالفعل' : 'تم تغيير اللغة الى اللغة العربية');
                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        state.locale.languageCode == 'ar' ? 'الغاء' : 'Cancel',
                      ),
                    ),
                  ],
                );
              },
            ),
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