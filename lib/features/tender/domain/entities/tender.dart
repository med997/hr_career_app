import 'dart:core';

import 'package:equatable/equatable.dart';

class Tender extends Equatable {
  final int? id;
  final String? createdAt;
  final String tenderTitle;
  final String? otherApplyLinks;
  final String city;
  final String category;
  final DateTime? deadlineDate;
  final String? nationalities;
  final String? status;
  final String? companyId;
  final String tenderDesc;
  final List<dynamic>? tenderDescFormated;
  final int? tenderPackage;
  final int? applianceNo;

  const Tender(
      {required this.tenderTitle,
      this.otherApplyLinks,
      required this.city,
      required this.category,
      this.deadlineDate,
      this.nationalities,
      this.status,
      this.companyId,
      required this.tenderDesc,
      this.tenderDescFormated,
       this.tenderPackage,
      this.applianceNo,
      this.id,
      this.createdAt});

  @override
  List<Object?> get props => [];
}
