import 'package:flutter/material.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import '../widget/login_ana_register_appbar_functhion.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _mobileVerificationPage(context),
        tablet: _desktopAndTabletVerificationPage(context),
        desktop: _desktopAndTabletVerificationPage(context));
  }

  Widget _desktopAndTabletVerificationPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
          flexibleSpace: Container(
              padding: const EdgeInsets.all(120.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/imgs/bglarg.png'),
                  fit: BoxFit.fitWidth, // Adjust fit as needed
                ),
              ))),
      body: Container(
          padding: const EdgeInsets.all(120.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/bglarg.png'),
              fit: BoxFit.fitWidth, // Adjust fit as needed
            ),
            /*color: primaryColor,
          border: Border.all(
            color: primaryColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(12)*/
          ),
          child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      loginAndRegisterAppBar(bgColor: Colors.transparent),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    width: 420,
                    height: 400,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(18)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Jobizz",
                          style: TextStyle(
                              fontSize: 24,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Verify Code",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Enter your verification code from your email or phone number that we've sent",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 40),
                        VerificationCodeField(
                          length: 4,
                          onFilled: (value) => print(value),
                          size: const Size(50, 60),
                          spaceBetween: 20,
                          matchingPattern: RegExp(r'^\d+$'),
                        ),
                        Spacer(),
                        MaterialButton(
                          height: 45,
                          minWidth: 380,
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onPressed: () {},
                          enableFeedback: false,
                          child: const Text(
                            'Verify',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
    );
  }

  Widget _mobileVerificationPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryTransparent.withOpacity(0.2),
              image: const DecorationImage(
                image: AssetImage('assets/imgs/paternPrimary.png'),
                fit: BoxFit.cover, // Adjust fit as needed
              ),
            ),
          ),
          BackButton(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: loginAndRegisterAppBar(bgColor: Colors.transparent),
          ),
          Center(
            child: Container(
              width: 400,
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              margin: const EdgeInsets.symmetric(horizontal: 28),
              decoration: BoxDecoration(
                  color: bgColor, borderRadius: BorderRadius.circular(18)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Jobizz",
                    style: TextStyle(
                        fontSize: 24,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Verify Code",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Enter your verification code from your email or phone number that we've sent",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  VerificationCodeField(
                    length: 4,
                    onFilled: (value) => print(value),
                    size: const Size(50, 60),
                    spaceBetween: 20,
                    matchingPattern: RegExp(r'^\d+$',),
                  ),
                  Spacer(),
                  MaterialButton(
                    height: 45,
                    minWidth: 380,
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    onPressed: () {},
                    enableFeedback: false,
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
