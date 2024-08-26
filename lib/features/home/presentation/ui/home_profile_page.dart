import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/profile_cubit.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

class HomeProfilePage extends StatelessWidget {
  HomeProfilePage({super.key});

  late Profile preProfile = Profile(username: '', phone: '', currentJob: '',  email: '', gender: '', nationality: '');

  _submitClicked(BuildContext context, Profile profile) {
    context.read<ProfileCubit>().insertProfile(profile);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8),
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
              return DynamicFormWidget(
                submitBtnLabel: "save",
                dynamicFormsList: [
                  DynamicModel('name', FormType.text,
                      value: preProfile.username, ),
                  DynamicModel(
                    'nameAr',
                    FormType.text,
                    value: preProfile.phone,
                  ),
                  DynamicModel(
                    'currentJob',
                    FormType.text,
                    value: preProfile.currentJob,
                  ),
                  DynamicModel(
                    'nationality',
                    FormType.dropdown,
                    items: [
                      ItemModel(key: 'saudi', value: 'saoudi'),
                      ItemModel(key: 'yemeni', value: 'yemeni'),
                      ItemModel(key: 'egyption', value: 'egyption')
                    ],
                    value: preProfile.nationality,
                  ),
                ],
              );

          },
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(

              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(12)),
              width: 350,
              height: 35,
              child: ElevatedButton(onPressed: () {
                _submitClicked(context, preProfile);
              }, child: Text('gooo'))),
        ),
      ],
    );
  }
}
