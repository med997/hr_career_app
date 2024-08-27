import 'package:flutter/cupertino.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/jobCard_widget.dart';

class EsraTesting extends StatelessWidget {
  const EsraTesting({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _mobileBuilder(),
        tablet: _mobileBuilder(),
        desktop: _mobileBuilder());
  }

  Widget _mobileBuilder (){

    return ListView(
      children: [
        JobCard(jobTitle: 'Software Engineer ',
            companyName: 'yemensoft',
            jobLocation: 'jobLocation', companyLogo: '',
            jobDeadLine: '', jobNationality: ''),
        JobCard(jobTitle: 'Software Engineer ',
            companyName: 'yemensoft',
            jobLocation: 'jobLocation', companyLogo: '',
            jobDeadLine: '', jobNationality: ''),
        JobCard(jobTitle: 'Software Engineer ',
            companyName: 'yemensoft',
            jobLocation: 'jobLocation', companyLogo: '',
            jobDeadLine: '', jobNationality: ''),
        JobCard(jobTitle: 'Software Engineer ',
            companyName: 'yemensoft',
            jobLocation: 'jobLocation', companyLogo: '',
            jobDeadLine: '', jobNationality: ''),
        JobCard(jobTitle: 'Software Engineer ',
            companyName: 'yemensoft',
            jobLocation: 'jobLocation', companyLogo: '',
            jobDeadLine: '', jobNationality: ''),
        JobCard(jobTitle: 'Software Engineer ',
            companyName: 'yemensoft',
            jobLocation: 'jobLocation', companyLogo: '',
            jobDeadLine: '', jobNationality: ''),
        JobCard(jobTitle: 'Software Engineer ',
            companyName: 'yemensoft',
            jobLocation: 'jobLocation', companyLogo: '',
            jobDeadLine: '', jobNationality: ''),
      ],
    );


  }


}
