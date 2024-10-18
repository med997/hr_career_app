import 'dart:convert';

import 'package:hr_career_platform/features/tender/domain/entities/tender.dart';

import '../../../company/data/models/company_model.dart';

List<TenderModel> TenderFromJson(String str) => List<TenderModel>.from(
    json.decode(str).map((x) => TenderModel.fromJson(x)));

class TenderModel extends Tender {
  const TenderModel({
    super.id,
    required super.createdAt,
    required super.tenderTitle,
     super.tenderPackage,
    required super.otherApplyLinks,
    required super.city,
    required super.category,
    super.deadlineDate,
    super.applianceNo,
    super.company,
    required super.nationalities,
    super.tenderDescFormated,
    super.status,
    required super.tenderDesc,
    super.companyId,
  });

  factory TenderModel.fromJson(Map<String, dynamic> json) => TenderModel(
        id: json["id"],
        createdAt: json["created_at"],
        tenderTitle: json["tender_title"],
        tenderPackage: json["tender_package"],
        otherApplyLinks: json["other_apply_links"],
        applianceNo: json["appliance_no"],
        city: json["city"],
        tenderDescFormated: json['tender_desc_formated'] != null
            ? List<dynamic>.from(json['tender_desc_formated'])
            : null,
        category: json["category"],
        deadlineDate: json["deadline_date"] != null
            ? DateTime.parse(json["deadline_date"])
            : null,
        nationalities: json["nationalities"],
        status: json["status"],
        tenderDesc: json["tender_desc"],
        companyId: json["company_id"],
    company:json["company"]!=null?CompanyModel.fromJson(json["company"]):null,

  );

  factory TenderModel.fromTender(Tender tender) => TenderModel(
        id: tender.id,
        createdAt: tender.createdAt,
        category: tender.category,
        city: tender.city,
        tenderTitle: tender.tenderTitle,
        tenderPackage: tender.tenderPackage,
        otherApplyLinks: tender.otherApplyLinks,
        nationalities: tender.nationalities,
        tenderDesc: tender.tenderDesc,
        tenderDescFormated: tender.tenderDescFormated,
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "created_at": createdAt,
        "tender_title": tenderTitle,
        "tender_desc_formated": tenderDescFormated,
        "tender_package" : tenderPackage,
        "other_apply_links": otherApplyLinks,
        "city": city,
        "category": category,
        "nationalities": nationalities,
        "tender_desc": tenderDesc,
        "company_id": companyId,
      };
}
