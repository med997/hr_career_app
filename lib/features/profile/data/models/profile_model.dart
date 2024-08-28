import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
      super.id,
      super.updatedAt,
      super.fullName,
      super.avatarUrl,
      super.fullNameAr,
      super.nationality,
      super.secondaryPhone,
      super.resumeUrl,
      super.documentsUrl,
      super.major,
      super.skils,
      super.username,
      required super.phone,
      required super.currentJob,
       super.dob,
      required super.email,
      super.gender});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
      id: json["id"],
      updatedAt: json["updated_at"],
      username: json["username"],
      fullName: json["full_name"],
      avatarUrl: json["avatar_url"],
      phone: json["phone"],
      fullNameAr: json["full_name_ar"],
      currentJob: json["current_job"],
      nationality: json["nationality"],
      dob: DateTime.parse(json["dob"]),
      secondaryPhone: json["secondary_phone"],
      email: json["email"],
      gender: json["gender"],
      resumeUrl: json["resume_url"],
      documentsUrl: json["documents_url"],
      major: json["major"],
      skils: List<String>.from(json["skils"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "updated_at": updatedAt,
      "username": username,
      "full_name": fullName,
      "avatar_url": avatarUrl,
      "phone": phone,
      "full_name_ar": fullNameAr,
      "current_job": currentJob,
      "nationality": nationality,
      "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
      "secondary_phone": secondaryPhone,
      "email": email,
      "gender": gender,
      "resume_url": resumeUrl,
      "documents_url": documentsUrl,
      "major": major,
      "skils": List<dynamic>.from(skils!.map((x) => x)),
  };
}
