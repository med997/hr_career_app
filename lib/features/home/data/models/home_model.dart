

import 'dart:convert';

import 'package:hr_career_platform/features/home/domain/entities/home.dart';
import 'package:hr_career_platform/features/job/data/models/job_model.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/tender/data/models/tender_model.dart';

class HomeModel extends Home{
  const HomeModel({ super.recentJobs,  super.featuredJobs, super.recentTender, super.featuredTender});
  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
      recentJobs: List<JobModel>.from(json["recent_jobs"].map((x) => JobModel.fromJson(x))),
      recentTender: List<TenderModel>.from(json["recent_tenders"].map((x) => TenderModel.fromJson(x))),
      featuredJobs:json["featured_jobs"]!=null?
      List<JobModel>.from(json["featured_jobs"].map((x) => JobModel.fromJson(x)))
          :[],

      featuredTender:json["featured_tenders"]!=null?
      List<TenderModel>.from(json["featured_tenders"].map((x) => TenderModel.fromJson(x)))
          :[]
  );
  Map<String, dynamic> toJson() => {
    "recent_jobs": recentJobs,
    "featured_jobs": featuredJobs,
  };
}