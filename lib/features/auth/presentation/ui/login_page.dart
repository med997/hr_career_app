import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/register_page.dart';

import '../../../../core/app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/imgs/project_logo.png'),
                    const Text(
                      'Welcome',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  const SizedBox(height: 20),
                  SimpleSegmentedControl(),
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
                              MaterialPageRoute(builder: (context) => const RegisterPage()),
                            );
                          }, child: const Text('Register')),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            prefixIcon: Icon(
              icon,
              color: Colors.grey,
              size: 18,
            ),
            border: const OutlineInputBorder(),
            labelText: label,
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }
}

class SimpleSegmentedControl extends StatefulWidget {
  @override
  _SimpleSegmentedControlState createState() => _SimpleSegmentedControlState();
}

class _SimpleSegmentedControlState extends State<SimpleSegmentedControl> {
  int _selectedIndex = 0;
  final List<String> _options = ['User', 'Company'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButtons(
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 100.0,
          ),
          fillColor: primaryColor,
          selectedBorderColor: primaryColor,
          selectedColor: Colors.white,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: primaryColor,
          color: primaryColor,
          isSelected: List.generate(
              _options.length, (index) => index == _selectedIndex),
          onPressed: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _options.map((String label) => Text(label)).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: _selectedIndex == 0
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                  ],
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  ],
                ),
        ),
      ],
    );
  }
}
