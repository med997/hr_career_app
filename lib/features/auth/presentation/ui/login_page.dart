import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/register_page.dart';
import 'package:hr_career_platform/features/auth/presentation/widget/login&register_appbar_functhion.dart';
import 'package:hr_career_platform/features/auth/presentation/widget/segmented_button_login_widget.dart';

import '../../../../core/app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAndRegisterAppBar(),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              SegmentedControlLoginWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      )),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow.shade700),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      )),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue as Gust',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 14.0,
                    width: 150,
                    child: Divider(
                      endIndent: 20,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'or with',
                    style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(
                    height: 14.0,
                    width: 150,
                    child: Divider(
                      indent: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Haven't an account?",
                    style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  RegisterPage()),
                        );
                      }, child: const Text('Register')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
