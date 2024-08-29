



import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth extends Equatable {
  final String email;
  final String password;
  final User? userAuth;
  final Profile? profile;
  final Company? company;

  Auth({required this.email, required this.password,  this.profile, this.company, this.userAuth});

  @override
  List<Object?> get props => [];




}