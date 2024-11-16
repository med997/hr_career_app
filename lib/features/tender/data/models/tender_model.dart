import 'dart:convert';

import 'package:hr_career_platform/features/tender/domain/entities/tender.dart';

import '../../../company/data/models/company_model.dart';


class TenderModel extends Tender {
  const TenderModel({
    super.id,
    required super.createdAt,
    required super.tenderTitle,
     super.otherApplyLinks,
     super.otherApplyLinksFormated,
    required super.city,
    required super.category,
    super.deadlineDate,
    super.applianceNo,
    required super.nationalities,
    super.tenderDescFormated,
    super.status,
     super.tenderDesc,
    super.companyId,
    super.company
  });

  factory TenderModel.fromJson(Map<String, dynamic> json) => TenderModel(
        id: json["id"],
        createdAt: json["created_at"],
        tenderTitle: json["tender_title"],
        otherApplyLinks: json["other_apply_links"],
        otherApplyLinksFormated: json['other_apply_links_formated']!= null
            ? List<dynamic>.from(json['other_apply_links_formated'])
            : null,
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
        otherApplyLinks: tender.otherApplyLinks,
        otherApplyLinksFormated: tender.otherApplyLinksFormated,
        nationalities: tender.nationalities,
        tenderDesc: tender.tenderDesc,
        tenderDescFormated: tender.tenderDescFormated,
      companyId: tender.companyId,
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "created_at": createdAt,
        "tender_title": tenderTitle,
        "tender_desc_formated": tenderDescFormated,
        "other_apply_links": otherApplyLinks,
    "other_apply_links_formated" : otherApplyLinksFormated,
        "city": city,
        "category": category,
        "nationalities": nationalities,
        "tender_desc": tenderDesc,
        "company_id": companyId,
      };
}
