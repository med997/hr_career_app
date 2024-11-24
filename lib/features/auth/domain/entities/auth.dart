



import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth extends Equatable {
  final String email;
  final String password;
  final List<String>  fcmToken;
  final User? userAuth;
  final UsrType userType;
  final Profile? profile;
  final Company? company;

  const Auth({
    required this.email,
    required this.password,
    required this.userType,
     this.fcmToken = const[],
    this.profile, this.company,
    this.userAuth});

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return 'Auth{email: $email, password: $password, fcmToken: $fcmToken, userAuth: $userAuth, userType: $userType, profile: $profile, company: $company}';
  }
}