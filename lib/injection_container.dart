import 'package:hr_career_platform/core/util/const_val.dart';
import 'package:hr_career_platform/features/home/data/datasources/home_remote_datasource.dart';
import 'package:hr_career_platform/features/home/data/repositories/home_repository_impl.dart';
import 'package:hr_career_platform/features/home/domain/repositories/home_repository.dart';
import 'package:hr_career_platform/features/home/domain/usecases/fetch_home.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/job/data/datasources/network/job_remote_datasource.dart';
import 'package:hr_career_platform/features/job/data/repositories/job_repository_impl.dart';
import 'package:hr_career_platform/features/job/domain/repositories/job_repository.dart';
import 'package:hr_career_platform/features/job/domain/usercase/add_job.dart';
import 'package:hr_career_platform/features/job/domain/usercase/get_job.dart';
import 'package:hr_career_platform/features/job/domain/usercase/update_job.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/app_localizations.dart';
import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
//! Features - posts

// Bloc
//   sl.registerLazySingleton(() => JobCubit(getJobUserCase: sl()));

// Usecases

  // sl.registerLazySingleton(() => GetJobUserCase(sl()));
  // sl.registerLazySingleton(() => AddJobUserCase(sl()));
  // sl.registerLazySingleton(() => UpdateJob(sl()));

// Repository

  /*sl.registerLazySingleton<JobRepository>(
      () => JobRepositoryImpl(jobRemoteDataSource: sl(), networkInfo: sl()));
*/
// Datasources

  /*sl.registerLazySingleton<JobRemoteDataSource>(
      () => JobRemoteDataSourceImpl(supBase: sl()));
*/
  _initJob();
  _initHome();
//! Core
  final supBaseInit = await Supabase.initialize(url: BaseUrl, anonKey:AnonKey);
  sl.registerLazySingleton(() => supBaseInit.client);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}

void _initJob() {
  sl
    // datasource
    ..registerFactory<JobRemoteDataSource>(
      () => JobRemoteDataSourceImpl(
        supBase: sl(),
      ),
    )

    // repository
    ..registerFactory<JobRepository>(
      () => JobRepositoryImpl(
        jobRemoteDataSource: sl(),
        networkInfo: sl(),
      ),
    )
    // usecases
    ..registerFactory(
      () => GetJobUserCase(
        sl(),
      ),
    )
    ..registerFactory(
      () => AddJobUserCase(
        sl(),
      ),
    )
    ..registerFactory(
      () => UpdateJob(
        sl(),
      ),
    )
    // cubit
    ..registerLazySingleton(
      () => JobCubit(getJobUserCase: sl()),
    );
}
void _initHome() {
  sl

    // datasource
   ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        supBase: sl(),
      ),
    )

    // repository
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(
        homeRemoteDataSource: sl(),
        networkInfo: sl(),
      ),
    )
    // usecases
    ..registerFactory(
      () => GetHomeUserCase(
        sl(),
      ),
    )
    // cubit
    ..registerLazySingleton(
          () => HomeCubit(getHomeUserCase: sl()),
    )
    // cubit
    ..registerLazySingleton(
          () => TabNavCubit(),
    );
}
