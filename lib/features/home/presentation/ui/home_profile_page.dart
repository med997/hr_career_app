import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/profile_cubit.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/injection_container.dart' as di;

class HomeProfilePage extends StatelessWidget {
  HomeProfilePage({super.key});


  final _formKey = GlobalKey<FormState>();

  _submitClicked(BuildContext context) {
    context.read<ProfileCubit>().insertProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
                 DynamicFormWidget(
                  submitBtnLabel: "save",
                  dynamicFormsList: [
                    DynamicModel('name', FormType.text,
                      controller:  context.read<ProfileCubit>().userNameController),
                    DynamicModel(
                      'nameAr',
                      FormType.text,
                        controller:  context.read<ProfileCubit>().phoneController
                    ),
                    DynamicModel(
                      'currentJob',
                      FormType.text,
                        controller:  context.read<ProfileCubit>().currentJobController
                    ),
                    DynamicModel(
                      'nationality',
                      FormType.dropdown,
                      items: [
                        ItemModel(key: 'saudi', value: 'saoudi'),
                        ItemModel(key: 'yemeni', value: 'yemeni'),
                        ItemModel(key: 'egyption', value: 'egyption')
                      ],
                        value: context.read<ProfileCubit>().nationality,

                    ),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(

                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12)),
                width: 350,
                height: 35,
                child: ElevatedButton(onPressed: () {
                 _submitClicked(context);
                  // onSubmitClicked!();
                }, child: Text('gooo'))),
          ),



     ]);
  },
    );
}
}

