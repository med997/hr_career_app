
import 'dart:convert';

import '../../domain/entities/company.dart';

List<CompanyModel> companyFromJson(String str) =>
    List<CompanyModel>.from(json.decode(str).map((x) => CompanyModel.fromJson(x)));

class CompanyModel extends Company {
  CompanyModel({super.id, required super.city,
    required super.email, required super.major,
    required super.phone, required super.address,
    required super.nameAr, required super.nameEn,  super.website,
     super.aboutUs,  super.locations,  super.createdAt,super.companyLogo,
     super.headOffice,  super.imagesPath,  super.nationality,
     super.videoPaths,  super.otherContact,  super.documentPaths});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    id: json["id"]?? '0',
    city: json["city"],
    email: json["email"],
    major: json["major"],
    phone: json["phone"],
    address: json["address"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    website: json["website"],
    aboutUs: json["about_us"],
    companyLogo: json["company_logo"],
    locations: json["locations"],
    createdAt: json["created_at"],
    headOffice: json["head_office"],
    imagesPath: json["images_path"],
    nationality: json["nationality"],
    videoPaths: json["video_paths"],
    otherContact: json["other_contact"],
    documentPaths: json["document_paths"],
  );
  factory CompanyModel.fromCompany(Company? company) => CompanyModel(
    id: company!.id,
    city: company.city,
    email: company.email,
    major: company.major,
    phone: company.phone,
    address: company.address,
    nameAr: company.nameAr,
    nameEn: company.nameEn,
    website: company.website,
    aboutUs: company.aboutUs,
    companyLogo: company.companyLogo,
    locations: company.locations,
    createdAt: company.createdAt,
    headOffice: company.headOffice,
    imagesPath: company.imagesPath,
    nationality: company.nationality,
    videoPaths: company.videoPaths,
    otherContact: company.otherContact,
    documentPaths: company.documentPaths,
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
    "company_logo": companyLogo,
    "locations": List<dynamic>.from(locations!.map((x) => x.toJson())),
    "created_at": createdAt,
    "head_office": headOffice,
    "images_path": imagesPath,
    "nationality": nationality,
    "video_paths": videoPaths,
    "other_contact": otherContact,
    "document_paths": documentPaths,
  };
}
