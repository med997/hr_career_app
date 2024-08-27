import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import '../widget/segmented_button_widget.dart';
import '../widget/text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/imgs/project_logo.png'),
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Text(
            "Let's log in. Apply or post to jobs!",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const SegmentedControlWidget(),
              SizedBox(
                width: 300,
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
                    height: 25.0,
                    width: 150,
                    child: Divider(
                      endIndent: 20,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'or with',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 25.0,
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
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
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
