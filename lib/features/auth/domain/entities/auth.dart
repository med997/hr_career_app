



import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth extends Equatable {
  final String email;
  final String password;
  final User? userAuth;
  final Profile profile;

  Auth({required this.email, required this.password,required this.profile, this.userAuth});

  @override
  List<Object?> get props => [];




}