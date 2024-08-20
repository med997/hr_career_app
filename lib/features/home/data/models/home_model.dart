

import 'dart:convert';

import 'package:hr_career_platform/features/home/domain/entities/home.dart';
import 'package:hr_career_platform/features/job/data/models/job_model.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

class HomeModel extends Home{
  const HomeModel({required super.recentJobs, required super.featuredJobs});
  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(

      recentJobs: List<JobModel>.from(json["recent_jobs"].map((x) => JobModel.fromJson(x))),
      featuredJobs: List<JobModel>.from(json["featured_jobs"].map((x) => JobModel.fromJson(x)))
  );
  Map<String, dynamic> toJson() => {
    "recent_jobs": recentJobs,
    "featured_jobs": featuredJobs,
  };
}