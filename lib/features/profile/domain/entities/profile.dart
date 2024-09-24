import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String? id;
  final String? updatedAt;
  final String? username;
  final String? fullName;
  final String? avatarUrl;
  final String phone;
  final String? fullNameAr;
  final String? currentJob;
  final String? nationality;
  final String? address;
  final DateTime? dob;
  final String? secondaryPhone;
  final String email;
  final String? gender;
  final String? resumeUrl;
  final String? documentsUrl;
  final String? major;
  final List<String>? skils;
  final List<dynamic> experience;
  final List<dynamic> education;

  Profile({
    this.id,
    this.updatedAt,
    this.username,
    this.fullName,
    this.avatarUrl,
    this.fullNameAr,
    this.nationality,
    this.dob,
    this.address,
    this.secondaryPhone,
    this.education= const[],
    this.experience= const[],


     this.currentJob,
    required this.phone,
    required this.email,
    this.gender,
    this.resumeUrl,
    this.documentsUrl,
    this.major,
    this.skils,
  });

  @override
  List<Object?> get props => [];
}
