import 'dart:core';

import 'package:equatable/equatable.dart';

import '../../../company/domain/entities/company.dart';

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
  final int? applianceNo;
  final Company? company;


  const Tender(
      {required this.tenderTitle,
      this.otherApplyLinks,
      required this.city,
      required this.category,
      this.deadlineDate,
      this.nationalities,
      this.status,
        this.company,
      this.companyId,
      required this.tenderDesc,
      this.tenderDescFormated,
      this.applianceNo,
      this.id,
      this.createdAt});

  @override
  List<Object?> get props => [];
}
