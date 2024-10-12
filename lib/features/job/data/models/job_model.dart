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
    super.deadlineDate,
    required super.nationalities,
    super.qualifications,
    super.jobDescFormated,
    super.jobReqFormated,
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
        jobDescFormated:json['job_desc_formated']!=null?List<dynamic>.from(json['job_desc_formated']):null,
        jobReqFormated:json['job_req_formated']!=null?List<dynamic>.from(json['job_req_formated']):null,
        category: json["category"],
        deadlineDate: json["deadline_date"] != null ? DateTime.parse(json["deadline_date"]) : null,
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
        jobDescFormated: job.jobDescFormated,
        jobReqFormated: job.jobReqFormated,
        city: job.city,
        category: job.category,
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
        "job_desc_formated":jobDescFormated,
        "job_req_formated":jobReqFormated,
        "office": office,
        "other_apply_links": otherApplyLinks,
        "address": address,
        "time_parts": timeParts,
        "city": city,
        "category": category,
        "nationalities": nationalities,
        "qualifications": qualifications,
        "job_desc": jobDesc,
        "job_requirements": jobRequirements,
        "company_id": companyId,

      };
}
