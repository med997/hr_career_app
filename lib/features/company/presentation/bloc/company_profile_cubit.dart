import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';

part 'company_profile_state.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileState> {
  TextEditingController companyNameArProfileController =
      TextEditingController();
  TextEditingController companyNameEnProfileController =
      TextEditingController();
  TextEditingController companyMajorProfileController = TextEditingController();
  TextEditingController companyNationalityProfileController =
      TextEditingController();
  TextEditingController companyEmailProfileProController =
      TextEditingController();
  TextEditingController companyPhoneNumberProfileProController =
      TextEditingController();
  TextEditingController companyWebsiteProfileProController =
      TextEditingController();
  TextEditingController companyHeadOfficeProfileProController =
      TextEditingController();
  TextEditingController companyAddressProfileProController =
      TextEditingController();
  TextEditingController companyAboutUsProfileProController =
      TextEditingController();
  TextEditingController companyPasswordProfileController =
      TextEditingController();

  CompanyProfileCubit() : super(CompanyProfileInitial()) {
    companyNameArProfileController = TextEditingController();
    companyNameEnProfileController = TextEditingController();
    companyMajorProfileController = TextEditingController();
    companyNationalityProfileController = TextEditingController();
    companyEmailProfileProController = TextEditingController();
    companyWebsiteProfileProController = TextEditingController();
    companyAddressProfileProController = TextEditingController();
    companyAboutUsProfileProController = TextEditingController();
    companyPasswordProfileController = TextEditingController();
  }

  Future<void> editProfileCompany() async {
    Company companyProfile = Company(
        email: companyEmailProfileProController.text,
        phone: [companyPhoneNumberProfileProController.text],
        address: companyAddressProfileProController.text,
        nameAr: companyNameArProfileController.text,
        nameEn: companyNameEnProfileController.text,
        major: companyMajorProfileController.text,
        headOffice: companyHeadOfficeProfileProController.text,
        nationality: companyNationalityProfileController.text,
        aboutUs: companyAboutUsProfileProController.text,
        website: companyWebsiteProfileProController.text);
    emit(CompanyProfile(companyProfile));
  }
}
