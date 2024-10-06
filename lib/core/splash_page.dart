import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/reload_btn_cubit.dart';
import 'package:hr_career_platform/core/strings/failures.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/err_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/curd_profile_cubit.dart';

import '../features/auth/presentation/bloc/login_cubit.dart';
import '../features/auth/presentation/widget/login_ana_register_appbar_functhion.dart';
import '../features/home/presentation/ui/company_home_page.dart';
import '../features/home/presentation/ui/home_page.dart';
import 'app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  reloadingAgain(BuildContext context) {}

  @override
  void initState() {
    super.initState();
  context.read<LoginCubit>().checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is CurrentUserStatus) {

        if (state.auth.userType == UsrType.user) {
          // FirebaseMessaging.instance.getToken().then((value) {
          //   Profile profile = Profile(
          //       id: state.auth.userAuth!.id,
          //       fcmToken:value,
          //       phone: state.auth.profile!.phone,
          //       email: state.auth.profile!.email);
          //
          //
          //   context.read<CurdProfileCubit>().updateProfile(profile);
          // });

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(auth: state.auth,),
              ),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>  HomeCompanyPage(auth: state.auth,),
              ),
              (route) => false);
        }
      }
      if (state is NoLoginUser) {
        if (state.msg == EMPTY_CACHE_FAILURE_MESSAGE) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
                  (route) => false);
        } else {
          String imgUrl = state.msg == OFFLINE_FAILURE_MESSAGE
              ? 'assets/imgs/conectErr.png'
              : 'assets/imgs/ServerErr.png';

          showModalBottomSheet<void>(
              context: context,
              enableDrag: false,
              builder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocProvider(
                        create: (context) => ReloadBtnCubit(),
                        child: ErrWidget(
                          imgUrl: imgUrl,
                          errorText: state.msg,
                          clickedReload: () {
                            context.read<LoginCubit>().checkLoginStatus();
                          },
                        )),
                  ));
        }
      }
    }, builder: (context, state) {
      return Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/imgs/image10.png'),
              fit: BoxFit.fitWidth, // Adjust fit as needed
            ),
            color: primaryColor.withOpacity(0.3),
            /*border: Border.all(
                color: primaryColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(12)*/
          ),
          child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loginAndRegisterAppBar(bgColor: Colors.transparent),
                LoadingWidget(
                  width: 2,
                )
              ]));
    }));
  }
}
