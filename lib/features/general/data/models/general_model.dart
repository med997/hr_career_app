import 'package:hr_career_platform/features/general/domain/entities/general.dart';

class GeneralModel extends General {
  GeneralModel(
      {required super.cities,
      required super.gender,
      required super.pkgType,
      required super.continents,
      required super.jobStatus,
      required super.timeParts,
      required super.nationality,
      required super.officeType,
      required super.jobCategory,
      required super.companyMajor,
      required super.qualifications,
      required super.jobClassification});

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
      cities: List<String>.from(json["cities"].map((x) => x)),
      gender: List<String>.from(json["gender"].map((x) => x)),
      pkgType: List<String>.from(json["pkg_type"].map((x) => x)),
      continents: List<String>.from(json["continents"].map((x) => x)),
      jobStatus: List<String>.from(json["job_status"].map((x) => x)),
      timeParts: List<String>.from(json["time_parts"].map((x) => x)),
      nationality: List<String>.from(json["nationality"].map((x) => x)),
      officeType: List<String>.from(json["office_type"].map((x) => x)),
      jobCategory: List<String>.from(json["job_category"].map((x) => x)),
      companyMajor: List<String>.from(json["company_major"].map((x) => x)),
      qualifications: List<String>.from(json["qualifications"].map((x) => x)),
      jobClassification: List<String>.from(json["job_classification"].map((x) => x)),
  );
  Map<String, dynamic> toJson() => {
      "cities": List<dynamic>.from(cities.map((x) => x)),
      "gender": List<dynamic>.from(gender.map((x) => x)),
      "pkg_type": List<dynamic>.from(pkgType.map((x) => x)),
      "continents": List<dynamic>.from(continents.map((x) => x)),
      "job_status": List<dynamic>.from(jobStatus.map((x) => x)),
      "time_parts": List<dynamic>.from(timeParts.map((x) => x)),
      "nationality": List<dynamic>.from(nationality.map((x) => x)),
      "office_type": List<dynamic>.from(officeType.map((x) => x)),
      "job_category": List<dynamic>.from(jobCategory.map((x) => x)),
      "company_major": List<dynamic>.from(companyMajor.map((x) => x)),
      "qualifications": List<dynamic>.from(qualifications.map((x) => x)),
      "job_classification": List<dynamic>.from(jobClassification.map((x) => x)),
  };
}
