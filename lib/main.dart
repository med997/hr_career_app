import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/locale_cubit.dart';
import 'package:hr_career_platform/core/cubit/location_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/splash_page.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/register_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_page.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/ui/add_job_page.dart';
import 'package:hr_career_platform/features/payment/presentation/bloc/package_cubit.dart';

import 'features/general/presentation/bloc/general_cubit.dart';
import 'features/home/presentation/ui/company_home_page.dart';
import 'features/job/presentation/bloc/job_cubit.dart';
import 'features/profile/presentation/bloc/profile_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => di.sl<JobCubit>()..getAllJobs(),
      ),
      BlocProvider(
        create: (context) => di.sl<HomeCubit>()..getUserHome(),
      ),
      BlocProvider(
        create: (context) => di.sl<RegisterCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<TabNavCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<LoginCubit>()..checkLoginStatus(),
      ),
      BlocProvider(
        create: (context) => di.sl<ToggleBtnCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<ProfileCubit>(),
      ),

      BlocProvider(
        create: (context) => di.sl<RegisterCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<LocaleCubit>()..getSavedLanguage(),
      ),

      BlocProvider(
        create: (context) => di.sl<StepperCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<PackageCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<GeneralCubit>()..getGeneral(),
      ),
      BlocProvider(
        create: (context) => di.sl<LocationCubit>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return MaterialApp(
          locale: state.locale,
          debugShowCheckedModeBanner: false,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          title: 'Flutter Demo',
          theme: appTheme,
          routes: {
            '': (context) => HomePage(),
          },
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown
            },
          ),
          home: SplashPage(),
        );
      },
    );
  }
}
