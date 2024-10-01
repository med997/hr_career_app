import 'dart:convert';
import 'package:hr_career_platform/features/company/data/models/company_model.dart';

import '../../domain/entities/job.dart';


List<JobModel> jobFromJson(String str) =>
    List<JobModel>.from(json.decode(str).map((x) => JobModel.fromJson(x)));

class JobModel extends Job {
  JobModel({
    super.id,
    required super.createdAt,
    required super.jobTitle,
    required super.gender,
    required super.office,
    required super.otherApplyLinks,
    required super.address,
    required super.timeParts,
    required super.city,
    required super.category,
    required super.deadlineDate,
    required super.nationalities,
    super.qualifications,
    super.status,
    required super.jobDesc,
    required super.jobRequirements,
     super.companyId,
    super.company,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        id: json["id"],
        createdAt: json["created_at"],
        jobTitle: json["job_title"],
        gender: json["gender"],
        office: json["office"],
        otherApplyLinks: json["other_apply_links"],
        address: json["address"],
        timeParts: json["time_parts"],
        city: json["city"],
        category: json["category"],
        deadlineDate: DateTime.parse(json["deadline_date"]),
        nationalities: json["nationalities"],
        qualifications: json["qualifications"]!,
        status: json["status"],
        jobDesc: json["job_desc"],
        jobRequirements: json["job_requirements"],
        companyId: json["company_id"],
        company:json["company"]!=null?CompanyModel.fromJson(json["company"]):null,
      );

  factory JobModel.fromJob(Job job) => JobModel(
        id: job.id,
        createdAt: job.createdAt,
        jobTitle: job.jobTitle,
        gender: job.gender,
        office: job.office,
        otherApplyLinks: job.otherApplyLinks,
        address: job.address,
        timeParts: job.timeParts,
        city: job.city,
        category: job.category,
        deadlineDate: job.deadlineDate,
        nationalities: job.nationalities,
        qualifications: job.qualifications,
        status: job.status,
        jobDesc: job.jobDesc,
        jobRequirements: job.jobRequirements,
        companyId: job.companyId,
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "created_at": createdAt,
        "job_title": jobTitle,
        "gender": gender,
        "office": office,
        "other_apply_links": otherApplyLinks,
        "address": address,
        "time_parts": timeParts,
        "city": city,
        "category": category,
        "deadline_date":deadlineDate.toString(),
        "nationalities": nationalities,
        "qualifications": qualifications,
        "status": status,
        "job_desc": jobDesc,
        "job_requirements": jobRequirements,
        "company_id": companyId,

      };
}
