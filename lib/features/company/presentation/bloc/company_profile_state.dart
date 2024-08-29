part of 'company_profile_cubit.dart';

sealed class CompanyProfileState extends Equatable {}


final class CompanyProfileInitial extends CompanyProfileState {
  @override
  List<Object> get props => [];
}

final class CompanyProfile extends CompanyProfileState {
  Company companyProfile = Company(
    email: '',
    phone: [],
    address: '',
    nameAr: '',
    nameEn: '',
    website: '',
    aboutUs: '',
    nationality: '',
    headOffice: '',
    major: '',
  );

  CompanyProfile(this.companyProfile);

  @override
  List<Object?> get props => [];
}
