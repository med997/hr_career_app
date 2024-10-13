import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String? id;
  final String? city;
  final String email;
  final String?  major;
  final String phone;
  final String address;
  final String? nameAr;
  final String nameEn;
  final String? website;
  final dynamic aboutUs;
  final List<dynamic>? locations;
  final String? createdAt;
  final String? govRegNo;
  final List<String> fcmToken;
  final String? headOffice;
  final dynamic imagesPath;
  final String? nationality;
  final String? companyLogo;
  final dynamic videoPaths;
  final dynamic otherContact;
  final dynamic documentPaths;

  Company( {
    this.id,
    this.city,
    this.major,
    this.fcmToken= const[],
    required this.email,
     required this.phone,
    required this.address,
    required this.nameEn,
     this.nameAr,

     this.govRegNo,
    this.companyLogo,
     this.website,
     this.aboutUs,
     this.locations,
     this.createdAt,
     this.headOffice,
     this.imagesPath,
     this.nationality,
     this.videoPaths,
     this.otherContact,
     this.documentPaths,
  });

  @override
  List<Object?> get props => [];

}