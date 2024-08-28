import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/register_page.dart';
import 'package:hr_career_platform/features/auth/presentation/widget/login_ana_register_appbar_functhion.dart';

import '../../../../core/app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: _buildMobileLoginPage(context), tablet: _desktopAndTabletLoginPage(), desktop:  _desktopAndTabletLoginPage());
  }

  Widget _desktopAndTabletLoginPage() {
    return Scaffold(
    body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imgs/project_logo.png',),
            Text('Sign in to',style: TextStyle(color: Colors.black, fontSize: 24 ,fontWeight: FontWeight.bold),),
            Text('Lorem Ipsum is simply ',style: TextStyle(color: Colors.black, fontSize: 18 ,fontWeight: FontWeight.bold),),
            SizedBox(height: 80,),
            Row(
              children: [
                Text('If you don’t have an account register You can',style: TextStyle(color: Colors.black, fontSize: 16),),
                TextButton(onPressed: (){}, child: Text('Register here !')),

              ],
            ),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign in',style: TextStyle(color: Colors.black, fontSize: 20 ,fontWeight: FontWeight.bold),),

          ],
        )
      ],
    ),
  );
  }


  Widget _buildMobileLoginPage(BuildContext context) {
    return Scaffold(
    appBar: loginAndRegisterAppBar(),
    body: ListView(
      children: [
        Column(
          children: [
            const SizedBox(height: 20),


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
    ),
  );
  }
}