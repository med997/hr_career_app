import 'dart:convert';

import '../../domain/entities/company.dart';

List<CompanyModel> companyFromJson(String str) => List<CompanyModel>.from(
    json.decode(str).map((x) => CompanyModel.fromJson(x)));

class CompanyModel extends Company {
  CompanyModel(
      {super.id,
      super.city,
      required super.email,
      super.major,
      required super.phone,
      required super.address,
      super.fcmToken,
      super.nameAr,
      required super.nameEn,
      super.website,
      super.govRegNo,
      super.aboutUs,
      super.aboutUsFormated,
      super.locations,
      super.createdAt,
      super.companyLogo,
      super.headOffice,
      super.imagesPath,
      super.nationality,
      super.videoPaths,
      super.otherContact,
      super.documentPaths});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json["id"] ?? '0',
        city: json["city"] ?? '',
        email: json["email"] ?? '',
        major: json["major"] ?? '',
        phone: json["phone"] ?? '',
        address: json["address"] ?? "",
        nameAr: json["name_ar"] ?? '',
        nameEn: json["name_en"] ?? '',
        website: json["website"] ?? '',
        govRegNo: json["gov_reg_no"] ?? '',
        aboutUs: json["about_us"] ?? '',
        aboutUsFormated: json['about_us_formated'] != null
            ? List<dynamic>.from(json['about_us_formated'])
            : null,
        fcmToken: json["fcm_token"] != null
            ? List<String>.from(json["fcm_token"].map((x) => x))
            : [],
        companyLogo: json["company_logo"] ?? '',
        locations: json["locations"] ?? [],
        createdAt: json["created_at"] ?? '',
        headOffice: json["head_office"] ?? '',
        imagesPath: json["images_path"] ?? '',
        nationality: json["nationality"] ?? '',
        videoPaths: json["video_paths"] ?? '',
        otherContact: json["other_contact"] ?? '',
        documentPaths: json["document_paths"] ?? '',
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
        aboutUsFormated: company.aboutUsFormated,
        companyLogo: company.companyLogo,
        fcmToken: company.fcmToken,
        locations: company.locations,
        createdAt: company.createdAt,
        headOffice: company.headOffice,
        imagesPath: company.imagesPath,
        govRegNo: company.govRegNo,
        nationality: company.nationality,
        videoPaths: company.videoPaths,
        otherContact: company.otherContact,
        documentPaths: company.documentPaths,
      );

  Map<String, dynamic> toJson() => {
        // "id": id ,
        "city": city,
        "email": email,
        "major": major,
        "phone": phone,
        "address": address,
        "gov_reg_no": govRegNo,
        "name_ar": nameAr,
        "name_en": nameEn,
        "website": website,
        "about_us": aboutUs,
        "about_us_formated": aboutUsFormated,
        "company_logo": companyLogo,
         "locations": locations??[],
        "fcm_token": fcmToken,
        "head_office": headOffice,
        // "images_path": imagesPath,
        "nationality": nationality,
        // "video_paths": videoPaths,
        // "other_contact": otherContact,
        // "document_paths": documentPaths,
      };
}
