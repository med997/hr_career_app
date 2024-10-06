
import 'package:equatable/equatable.dart';

import '../../../company/domain/entities/company.dart';


class Job extends Equatable{
  final  int? id;
  final String? createdAt;
  final String jobTitle;
  final String? gender;
  final String office;
  final String? otherApplyLinks;
  final String address;
  final String timeParts;
  final List<dynamic>? jobDescFormated;
  final List<dynamic>? jobReqFormated;
  final String city;
  final String category;
  final DateTime? deadlineDate;
  final String? nationalities;
  final String? qualifications;
  final String? status;
  final String jobDesc;
  final String jobRequirements;
  final String? companyId;
  final Company? company;

   const Job({
    this.id,
      this.createdAt,
    required this.jobTitle,
     this.gender,
    required this.office,
     this.jobDescFormated,
     this.jobReqFormated,
     this.otherApplyLinks,
    required this.address,
    required this.timeParts,
    required this.city,
    required this.category,
      this.deadlineDate,
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