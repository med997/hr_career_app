import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final int? id;
  final String city;
  final String email;
  final String major;
  final List<dynamic> phone;
  final String address;
  final String nameAr;
  final String nameEn;
  final String website;
  final dynamic aboutUs;
  final List<dynamic> locations;
  final String createdAt;
  final String headOffice;
  final dynamic imagesPath;
  final String nationality;
  final dynamic videoPaths;
  final dynamic otherContact;
  final dynamic documentPaths;

  Company({
    this.id,
    required this.city,
    required this.email,
    required this.major,
    required this.phone,
    required this.address,
    required this.nameAr,
    required this.nameEn,
    required this.website,
    required this.aboutUs,
    required this.locations,
    required this.createdAt,
    required this.headOffice,
    required this.imagesPath,
    required this.nationality,
    required this.videoPaths,
    required this.otherContact,
    required this.documentPaths,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];

}