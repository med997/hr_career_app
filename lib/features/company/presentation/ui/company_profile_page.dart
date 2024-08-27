import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import '../widgets/company_appbar.dart';

class CompanyProfilePage extends StatelessWidget {
  var reasonValidation = true;

  CompanyProfilePage({super.key});

  late Company companyProfile = Company(
      city: '',
      email: '',
      major: '',
      phone: [],
      address: '',
      nameAr: '',
      nameEn: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: jobsAppBarFunction(
          backgroundCompanyImg: '',
          companyEmail: '',
          companyLocation: '',
          companyLogo: '',
          companyMajor: '',
          companyName: '',
          companyNumber: '',
          companyWebsite: ''),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding:
                          const WidgetStatePropertyAll(EdgeInsets.symmetric(
                        horizontal: 45,
                      )),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: const Text('Main Information')),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding:
                          const WidgetStatePropertyAll(EdgeInsets.symmetric(
                        horizontal: 55,
                      )),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: const Text('Gallery')),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: const Text(
                    "Main Information",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              IconButton(
                  onPressed: () {},
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  icon: const Icon(
                    Icons.edit_road,
                    color: primaryColor,
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          DynamicFormWidget(dynamicFormsList: [
            DynamicModel(
                disabled: true,
                'nameEn',
                FormType.text,
                value: companyProfile.nameEn),
            DynamicModel(
                disabled: true,
                'nameAr',
                FormType.text,
                value: companyProfile.nameAr),
            DynamicModel(
                disabled: true,
                'Major',
                FormType.text,
                value: companyProfile.major),
            DynamicModel(
                disabled: true,
                'Head Office',
                FormType.text,
                value: companyProfile.headOffice),
            DynamicModel(
                disabled: true,
                'nationality',
                FormType.dropdown,
                items: [
                  ItemModel(key: 'saudi', value: 'saoudi'),
                  ItemModel(key: 'yemeni', value: 'yemeni'),
                  ItemModel(key: 'egyption', value: 'egyption')
                ],
                value: companyProfile.nationality),
            DynamicModel(
                disabled: true,
                'Email',
                FormType.text,
                value: companyProfile.email),
            DynamicModel(
                disabled: true,
                'Website',
                FormType.text,
                value: companyProfile.website),
            DynamicModel(
                disabled: true,
                'Address',
                FormType.text,
                value: companyProfile.address),
            DynamicModel(
                disabled: true,
                'About Us',
                FormType.text,
                value: companyProfile.aboutUs),
          ], submitBtnLabel: "edit"),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  style: const ButtonStyle(),
                  icon: const Icon(
                    Icons.save_alt,
                    color: primaryColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
