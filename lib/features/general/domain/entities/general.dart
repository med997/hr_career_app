import 'package:equatable/equatable.dart';

class General extends Equatable {
 final List<String> cities;
 final List<String> gender;
 final List<String> pkgType;
 final List<String> continents;
 final List<String> jobStatus;
 final List<String> timeParts;
 final List<String> nationality;
 final List<String> officeType;
 final List<String> jobCategory;
 final List<String> companyMajor;
 final List<String> qualifications;
 final List<String> jobClassification;
 // final List<String> status;

  General({
    required this.cities,
    required this.gender,
    required this.pkgType,
    required this.continents,
    required this.jobStatus,
    required this.timeParts,
    required this.nationality,
    required this.officeType,
    required this.jobCategory,
    required this.companyMajor,
    required this.qualifications,
    required this.jobClassification,
    // required this.status
  });

  @override
  List<Object?> get props => [];
}