import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import '../widget/login_ana_register_appbar_functhion.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAndRegisterAppBar(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),


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
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
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
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
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
                    'Have an account?',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: primaryColor),
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
