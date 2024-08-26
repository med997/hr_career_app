import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String? id;
  final dynamic updatedAt;
  final String username;
  final String? fullName;
  final String? avatarUrl;
  final String phone;
  final String? fullNameAr;
  final String currentJob;
  final String? nationality;
  final DateTime? dob;
  final String? secondaryPhone;
  final String email;
  final String gender;
  final String? resumeUrl;
  final String? documentsUrl;
  final String? major;
  final List<String>? skils;

  Profile({
     this.id,
     this.updatedAt,
    required this.username,
     this.fullName,
     this.avatarUrl,
    required this.phone,
     this.fullNameAr,
    required this.currentJob,
     this.nationality,
     this.dob,
     this.secondaryPhone,
    required this.email,
    required this.gender,
     this.resumeUrl,
     this.documentsUrl,
     this.major,
     this.skils,
  });

  @override
  List<Object?> get props => [];
}