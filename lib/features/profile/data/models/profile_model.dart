import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel(
      {super.id,
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
      super.fcmToken,
      super.username,
      required super.phone,
      super.currentJob,
      super.dob,
      super.education,
      super.experience,
      super.applianceId,
      super.applyState,
      required super.email,
      super.gender,
      super.address});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        username: json["username"] ?? '',
        fullName: json["full_name"],
        avatarUrl: json["avatar_url"] ?? '',
        phone: json["phone"] ?? '',
        fullNameAr: json["full_name_ar"] ?? '',
        currentJob: json["current_job"] ?? '',
        nationality: json["nationality"] ?? '',
        // dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
        secondaryPhone: json["secondary_phone"]??"",
        applyState: json["apply_state"],
        applianceId: json["appliance_id"],
        email: json["email"] ?? '',
        gender: json["gender"] ?? '',
        resumeUrl: json["resume_url"] ?? '',
        documentsUrl: json["documents_url"] ?? '',
        address: json["address"] ?? '',
        major: json["major"] ?? '',
        skils: json["skils"] != null
            ? List<String>.from(json["skils"].map((x) => x))
            : [],
        fcmToken: json["fcm_token"] != null
            ? List<String>.from(json["fcm_token"].map((x) => x))
            : [],
        education: json["education"] != null
            ? List<dynamic>.from(json["education"].map((x) => x))
            : [],
        experience: json["experience"] != null
            ? List<dynamic>.from(json["experience"].map((x) => x))
            : [],
      );

  factory ProfileModel.fromProfile(Profile? profile) {
    return ProfileModel(
        id: profile!.id ?? '',
        // Handle potential nulls
        updatedAt: profile.updatedAt ?? '',
        fullName: profile.fullName ?? '',
        avatarUrl: profile.avatarUrl ?? '',
        fullNameAr: profile.fullNameAr ?? '',
        nationality: profile.nationality ?? '',
        secondaryPhone: profile.secondaryPhone ?? '',
        resumeUrl: profile.resumeUrl ?? '',
        documentsUrl: profile.documentsUrl ?? '',
        major: profile.major ?? '',
        skils: profile.skils,
        experience: profile.experience ?? [],

        // Provide default empty list
        username: profile.username,
        fcmToken: profile.fcmToken,
        phone: profile.phone,
        currentJob: profile.currentJob ?? '',
        dob: profile.dob,
        email: profile.email,
        gender: profile.gender ?? '',
        address: profile.address ?? '',
      );
  }

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
        "dob": dob,
        "secondary_phone": secondaryPhone,
        "email": email,
        "gender": gender,
        "fcm_token": fcmToken,
        "resume_url": resumeUrl,
        "documents_url": documentsUrl,
        "major": major ?? '',
        // "status": status,
        "address": address ?? ""
        //"skils": List<dynamic>.from(skils!.map((x) => x)),
      };
}
