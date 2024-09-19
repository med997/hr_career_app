import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/company/data/models/company_model.dart';
import 'package:hr_career_platform/features/profile/data/models/profile_model.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**/


class AuthModel extends Auth{
  AuthModel({required super.email, required super.userType,
      required super.password,   super.profile, super.company, super.userAuth});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    email: json["email"],
    password: json["password"]!=null?json['password']:'',
    userType: json["userType"],
    userAuth: json['user']!=null?  User.fromJson(json['user']):null,
    profile:ProfileModel.fromJson(json["profile"]),
    company:CompanyModel.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "userAuth": userAuth,
    "data": profile?? company,

  };
}