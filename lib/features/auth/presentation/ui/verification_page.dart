import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/splash_page.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/verification_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../../../core/cubit/dynamic_form_cubit.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/auth.dart';
import '../bloc/login_cubit.dart';
import '../widget/login_ana_register_appbar_functhion.dart';

class VerificationPage extends StatelessWidget {
  final String email;

  const VerificationPage({super.key, required this.email});

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

          iconTheme: const IconThemeData.fallback(),
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
          ),
          child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loginAndRegisterAppBar(bgColor: Colors.transparent),
                  ],
                ),
                verificationCard(context),
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
                child: verificationCard(context),
              ),
            ],
          )),
    );
  }

  _verifyBtn() {
    return BlocConsumer<VerificationCubit, VerificationState>(
      listener: (context, state) {
        if (state is SuccessVerificationUser) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verification Successfully! 🎉'),
            ),
          );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SplashPage(),
              ),
                  (route) => false);
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 350,
                height: 35,
                child: BlocBuilder<DisableButtonCubit, bool>(
                  builder: (context, btnState) {
                    return MaterialButton(
                      disabledColor: Colors.grey,

                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed:btnState? () {
                          context.read<VerificationCubit>().resendOtp(email);
                          context.read<DisableButtonCubit>().disableButton(true);

                      }:null,
                      enableFeedback: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Resend Code:',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Countdown(
                            seconds: 30,
                            build: (BuildContext context, double time) =>
                                Text(time.toString()),
                            interval: const Duration(milliseconds: 1000),
                            onFinished: () {
                              context.read<DisableButtonCubit>().disableButton(false);
                            },
                          ),
                          if (state is VerificationLoading)
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                              child: FittedBox(
                                  child: LoadingWidget(
                                    progressColor: Colors.white,
                                  )),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            if (state is ErrVerificationUser)
              Text(
                state.msg,
                style: const TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.w500),
              )
          ],
        );
      },
    );
  }

  Widget verificationCard(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
      margin: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(18)),
      child: ListView(
        shrinkWrap: true,

        children: [
          const Center(
            child: Text(
              "Verify Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Enter your verification code from your email that we've sent",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                VerificationCodeField(
                  length: 6,
                  onFilled: (value) {
                    context.read<VerificationCubit>().verifyUser(value, email);
                  },
                  size: const Size(40, 40),
                  spaceBetween: 8,
                  matchingPattern: RegExp(r'^\d+$',),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _verifyBtn()
        ],
      ),
    );
  }


}