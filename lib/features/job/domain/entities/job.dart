

import 'package:equatable/equatable.dart';

import '../../../company/domain/entities/company.dart';


class Job extends Equatable{
  final  int? id;
  final String createdAt;
  final String jobTitle;
  final dynamic gender;
  final String office;
  final dynamic otherApplyLinks;
  final String address;
  final String timeParts;
  final String city;
  final String category;
  final DateTime deadlineDate;
  final String? nationalities;
  final String? qualifications;
  final String? status;
  final String jobDesc;
  final String jobRequirements;
  final int? companyId;
  final Company? company;

   Job({
    this.id,
    required this.createdAt,
    required this.jobTitle,
    required this.gender,
    required this.office,
    required this.otherApplyLinks,
    required this.address,
    required this.timeParts,
    required this.city,
    required this.category,
    required this.deadlineDate,
     this.nationalities,
     this.qualifications,
     this.status,
    required this.jobDesc,
    required this.jobRequirements,
     this.companyId,
    this.company,
  });

  @override
  List<Object?> get props =>[];

}