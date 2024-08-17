import 'dart:convert';
import '../../domain/entities/job.dart';


List<JobModel> jobFromJson(String str) =>
    List<JobModel>.from(json.decode(str).map((x) => JobModel.fromJson(x)));

class JobModel extends Job {
  JobModel({
    super.id,
    required super.createdAt,
    required super.jobTitle,
    super.gender,
    required super.office,
    super.otherApplyLinks,
    required super.address,
    required super.timeParts,
    required super.city,
    required super.category,
    required super.deadlineDate,
    required super.nationalities,
    required super.qualifications,
    required super.status,
    required super.jobDesc,
    required super.jobRequirements,
    required super.companyId,
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
        qualifications: json["qualifications"],
        status: json["status"],
        jobDesc: json["job_desc"],
        jobRequirements: json["job_requirements"],
        companyId: json["company_id"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "job_title": jobTitle,
        "gender": gender,
        "office": office,
        "other_apply_links": otherApplyLinks,
        "address": address,
        "time_parts": timeParts,
        "city": city,
        "category": category,
        "deadline_date":
            "${deadlineDate.year.toString().padLeft(4, '0')}-${deadlineDate.month.toString().padLeft(2, '0')}-${deadlineDate.day.toString().padLeft(2, '0')}",
        "nationalities": nationalities,
        "qualifications": qualifications,
        "status": status,
        "job_desc": jobDesc,
        "job_requirements": jobRequirements,
        "company_id": companyId,
        "company": company,
      };
}
