import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/profile/data/models/profile_model.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**/


class AuthModel extends Auth{
  AuthModel({required super.email, required super.password, required super.profile, super.userAuth});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    email: json["email"],
    password: json["password"],
    userAuth: User.fromJson(json['user']),
    profile:ProfileModel.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "userAuth": userAuth,
    "data": profile,
  };
}