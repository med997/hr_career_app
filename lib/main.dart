import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/locale_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/widgets/snackbar_message.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/register_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/company_profile_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/selecte_button_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/ui/company_profile_page.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/profile_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_page.dart';
import 'core/widgets/loading_widget.dart';
import 'features/job/domain/entities/job.dart';
import 'features/job/presentation/bloc/job_cubit.dart';
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
        create: (context) => di.sl<LoginCubit>(),
      ),

      BlocProvider(
        create: (context) => di.sl<ToggleBtnCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<ProfileCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<CompanyProfileCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<SelectButtonCubit>(),
      ),

      BlocProvider(
        create: (context) => di.sl<RegisterCubit>(),
      ),

      BlocProvider(
        create: (context) => di.sl<LocaleCubit>()..getSavedLanguage(),
      ),

    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
  builder: (context, state) {
    return MaterialApp(
        locale: state.locale,
        supportedLocales: const [Locale('en'), Locale('ar'),],
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
        '/myHome': (context) => const MyHomePage(title: 'hi',),
      },
        scrollBehavior: const MaterialScrollBehavior().copyWith(
      dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch,
        PointerDeviceKind.stylus, PointerDeviceKind.unknown},),

      home: LoginPage(),
        );
  },
);
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('hi'),
      ),
      body:BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          if(state is JobLoadingState){
            return const LoadingWidget();
          } else if (state is JobFetchedState){
            return  ListView.separated(
                itemBuilder: (context, index) {
                  final Job job = state.jobs[index];
                  return ListTile(
                    leading: Text(job.id.toString()),
                    title: Text(
                      job.jobTitle,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(job.deadlineDate.toString()),);
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                ),
                itemCount:  state.jobs.length ?? 0);
          }else if(state is JobErrorState) {
            return Text(state.msg);
          }else{
            return const Text('error');
          }

        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  final String title;


}
 
