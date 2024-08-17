
import 'dart:convert';

import '../../domain/entities/company.dart';

List<CompanyModel> companyFromJson(String str) =>
    List<CompanyModel>.from(json.decode(str).map((x) => CompanyModel.fromJson(x)));

class CompanyModel extends Company {
  CompanyModel({super.id, required super.city,
    required super.email, required super.major,
    required super.phone, required super.address,
    required super.nameAr, required super.nameEn, required super.website,
    required super.aboutUs, required super.locations, required super.createdAt,
    required super.headOffice, required super.imagesPath, required super.nationality,
    required super.videoPaths, required super.otherContact, required super.documentPaths});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    id: json["id"],
    city: json["city"],
    email: json["email"],
    major: json["major"],
    phone: json["phone"],
    address: json["address"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    website: json["website"],
    aboutUs: json["about_us"],
    locations: json["locations"],
    createdAt: json["created_at"],
    headOffice: json["head_office"],
    imagesPath: json["images_path"],
    nationality: json["nationality"],
    videoPaths: json["video_paths"],
    otherContact: json["other_contact"],
    documentPaths: json["document_paths"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "email": email,
    "major": major,
    "phone": List<dynamic>.from(phone.map((x) => x.toJson())),
    "address": address,
    "name_ar": nameAr,
    "name_en": nameEn,
    "website": website,
    "about_us": aboutUs,
    "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
    "created_at": createdAt,
    "head_office": headOffice,
    "images_path": imagesPath,
    "nationality": nationality,
    "video_paths": videoPaths,
    "other_contact": otherContact,
    "document_paths": documentPaths,
  };
}
