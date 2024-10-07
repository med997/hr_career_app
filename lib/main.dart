import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fleather/l10n/fleather_localizations.g.dart';
import 'package:flutter/foundation.dart';
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
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/register_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/company_profile_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/curd_company_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_page.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/ui/add_job_page.dart';
import 'package:hr_career_platform/features/payment/presentation/bloc/package_cubit.dart';

import 'features/general/presentation/bloc/general_cubit.dart';
import 'features/home/presentation/ui/company_home_page.dart';
import 'features/job/presentation/bloc/curd_job_cubit.dart';
import 'features/job/presentation/bloc/job_cubit.dart';
import 'features/notification/service/notification_service.dart';
import 'features/payment/presentation/bloc/payment_curd_cubit.dart';
import 'features/profile/presentation/bloc/appliance_cubit.dart';
import 'features/profile/presentation/bloc/curd_profile_cubit.dart';
import 'features/profile/presentation/bloc/profile_cubit.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);




  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  di.initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => di.sl<JobCubit>()..getAllJobs(),
      ),
      BlocProvider(
        create: (context) => di.sl<HomeCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<RegisterCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<TabNavCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<LoginCubit>(),
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
        create: (context) => di.sl<DynamicFormCubit>(),
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
      BlocProvider(
        create: (context) => di.sl<CurdJobCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<CompanyProfileCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<CurdCompanyCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<PaymentCurdCubit >(),
      ),
      BlocProvider(
        create: (context) => di.sl<CurdProfileCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<ApplianceCubit>(),
      ),
    ],
    child: const MyApp(),
  ));
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 await setupFlutterNotifications();
  showFlutterNotification(message);
  print("Handling a background message: ${message.messageId}");
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
            FleatherLocalizations.delegate,
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // internally:
            // FlutterQuillLocalizations.delegate,
          ],
          title: 'Flutter Demo',
          theme: appTheme,
          routes: {
           /* '': (context) => HomePage(auth: s,),*/
          },
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown
            },
          ),
          home: const SplashPage(),
        );
      },
    );
  }
}
