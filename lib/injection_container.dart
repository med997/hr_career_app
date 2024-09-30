import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/locale_cubit.dart';
import 'package:hr_career_platform/core/cubit/location_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/util/const_val.dart';
import 'package:hr_career_platform/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hr_career_platform/features/auth/domain/usecases/fetch_auth.dart';
import 'package:hr_career_platform/features/auth/domain/usecases/login_use_case.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hr_career_platform/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hr_career_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:hr_career_platform/features/auth/domain/usecases/signup_use_case.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/register_cubit.dart';
import 'package:hr_career_platform/features/company/data/datasources/company_remote_datasource.dart';
import 'package:hr_career_platform/features/company/data/repositories/company_repository_impl.dart';
import 'package:hr_career_platform/features/company/domain/repositories/company_repository.dart';
import 'package:hr_career_platform/features/company/domain/usecases/fetch_company.dart';
import 'package:hr_career_platform/features/company/domain/usecases/update_company.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/curd_company_cubit.dart';
import 'package:hr_career_platform/features/general/data/datasources/general_local_datasource.dart';
import 'package:hr_career_platform/features/general/data/datasources/general_remote_datasource.dart';
import 'package:hr_career_platform/features/general/data/repositories/general_repository_impl.dart';
import 'package:hr_career_platform/features/general/domain/repositories/general_repository.dart';
import 'package:hr_career_platform/features/general/domain/usecases/fetch_general.dart';
import 'package:hr_career_platform/features/general/presentation/bloc/general_cubit.dart';
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
import 'package:hr_career_platform/features/job/domain/usercase/search_jobs.dart';
import 'package:hr_career_platform/features/job/domain/usercase/update_job.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/curd_job_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:hr_career_platform/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:hr_career_platform/features/payment/domain/repositories/payment_repository.dart';
import 'package:hr_career_platform/features/payment/domain/usecases/get_package.dart';
import 'package:hr_career_platform/features/payment/presentation/bloc/package_cubit.dart';
import 'package:hr_career_platform/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:hr_career_platform/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:hr_career_platform/features/profile/domain/repositories/profile_repository.dart';
import 'package:hr_career_platform/features/profile/domain/usecases/fetch_profile.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/app_localizations.dart';
import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/company/presentation/bloc/company_profile_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initJob();
  _initProfile();
  _initHome();
  _initCore();
  _initPayment();
  _initAuth();
  _initGeneral();
  _initCompany();

//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  final supBaseInit = await Supabase.initialize(url: BaseUrl, anonKey: AnonKey);
  sl.registerLazySingleton(() => supBaseInit.client);
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

//! External

  sl.registerLazySingleton(() => InternetConnection());
}


void _initJob() {
  sl
  // datasource
    ..registerFactory<JobRemoteDataSource>(
          () =>
          JobRemoteDataSourceImpl(
            supBase: sl(),
          ),
    )

  // repository
    ..registerFactory<JobRepository>(
          () =>
          JobRepositoryImpl(
            jobRemoteDataSource: sl(),
            networkInfo: sl(),
          ),
    )
  // usecases
    ..registerFactory(
          () =>
          GetJobUserCase(
            sl(),
          ),
    )..registerFactory(
        () =>
        SearchJobsUserCase(
          repository: sl(),
        ),
  )..registerFactory(
        () =>
        AddJobUserCase(
          sl(),
        ),
  )..registerFactory(
        () =>
        UpdateJob(
          sl(),
        ),
  )
  // cubit
    ..registerLazySingleton(
          () => JobCubit(getJobUserCase: sl(), searchJobsUserCase: sl()),
    )
  // cubit
    ..registerLazySingleton(
          () => CurdJobCubit(addJobUserCase: sl(), updateJobUseCase: sl()),
    )..registerLazySingleton(
        () => StepperCubit(),
  );
}

void _initPayment() {
  sl
  // datasource
    ..registerFactory<PaymentRemoteDataSource>(
          () =>
          PaymentsRemoteDataSourceImpl(
            supBase: sl(),
          ),
    )

  // repository
    ..registerFactory<PaymentRepository>(
          () =>
          PaymentRepositoryImpl(
            paymentRemoteDataSource: sl(),
            networkInfo: sl(),
          ),
    )
  // usecases
    ..registerFactory(
          () => GetPackageUseCase(repository: sl()),
    )
  // cubit
    ..registerLazySingleton(
          () => PackageCubit(getPackageUseCase: sl()),
    );
}

void _initHome() {
  sl

  // datasource
    ..registerFactory<HomeRemoteDataSource>(
          () =>
          HomeRemoteDataSourceImpl(
            supBase: sl(),
          ),
    )

  // repository
    ..registerFactory<HomeRepository>(
          () =>
          HomeRepositoryImpl(
            homeRemoteDataSource: sl(),
            networkInfo: sl(),
          ),
    )
  // usecases
    ..registerFactory(
          () =>
          GetHomeUserCase(
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

void _initAuth() {
  sl

  // datasource
    ..registerFactory<AuthRemoteDatasource>(
          () =>
          AuthRemoteDatasourceImpl(
            supBase: sl(),
          ),
    )
  // datasource
    ..registerFactory<AuthLocalDataSource>(
          () =>
          AuthLocalDataSourceImpl(
            sharedPreferences: sl(),
          ),
    )

  // repository
    ..registerFactory<AuthRepository>(
          () =>
          AuthRepositoryImpl(
            authLocalDataSource: sl(),
            authRemoteDatasource: sl(),
            networkInfo: sl(),
          ),
    )
  // usecases
    ..registerFactory(
          () =>
          SignupUseCase(
            sl(),
          ),
    )..registerFactory(
        () =>
        LoginUseCase(
          sl(),
        ),
  )..registerFactory(
        () =>
        FetchAuthUseCase(
          sl(),
        ),
  )
  // cubit

    ..registerLazySingleton(
          () => RegisterCubit(signupUseCase: sl()),
    )..registerLazySingleton(
        () => LoginCubit(loginUseCase: sl(), fetchAuthUseCase: sl()),
  );
}

void _initCore() {
  sl..registerLazySingleton(
        () => ToggleBtnCubit(),
  )

    ..registerLazySingleton(() => LocaleCubit())

    ..registerLazySingleton(() => DynamicFormCubit())

    ..registerLazySingleton(() => LocationCubit());
}

void _initProfile() {
  sl
    ..registerFactory<ProfileRemoteDatasource>(
          () =>
          ProfileRemoteDatasourceImp(
            client: sl(),
          ),
    )

  // repository
    ..registerFactory<ProfileRepository>(
          () =>
          ProfileRepositoryImpl(
            profileRemoteDatasource: sl(),
            networkInfo: sl(),
          ),
    )..registerFactory(
        () =>
        FetchProfileUserCase(
          sl(),
        ),
  )
    ..registerLazySingleton(
          () => ProfileCubit(fetchProfileUserCase: sl()),
    );
}

void _initGeneral() {
  sl

  // datasource
    ..registerFactory<GeneralRemoteDataSource>(
          () =>
          GeneralRemoteDataSourceImpl(
            supBase: sl(),
          ),
    )..registerFactory<GeneralLocalDataSource>(
          () =>
          GeneralLocalDataSourceImpl(
            sharedPreferences: sl(),
          ),
    )

  // repository
    ..registerFactory<GeneralRepository>(
          () =>
          GeneralRepositoryImpl(
            generalRemoteDataSource: sl(),
            generalLocaleDataSource: sl(),
            networkInfo: sl(),
          ),
    )
  // usecases
    ..registerFactory(
          () =>
          GetGeneralUseCase(
            sl(),
          ),
    )

  // cubit
    ..registerLazySingleton(
          () =>
          GeneralCubit(
            getGeneralUseCase: sl(),
          ),
    );
}

void _initCompany() {
  sl
    ..registerFactory<CompanyRemoteDatasource>(() => CompanyRemoteDatasourceImp(
          client: sl(),
        ))
    // repository
    ..registerFactory<CompanyRepository>(
      () => CompanyRepositoryImpl(
        companyRemoteDatasource: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerFactory(
      () => FetchCompanyUserCase(
        sl(),
      ),
    )
    ..registerFactory(
      () => UpdateCompany(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => CompanyProfileCubit(fetchCompanyUserCase: sl()),
    )
    ..registerLazySingleton(
      () => CurdCompanyCubit(updateCompanyUserCase: sl()),
    );
}
