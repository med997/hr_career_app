import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/validator.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/map_icon_button.dart';
import 'package:hr_career_platform/features/general/domain/entities/general.dart';
import 'package:hr_career_platform/features/general/presentation/bloc/general_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/strepper_page_body_widget.dart';
import 'package:hr_career_platform/core/widgets/map_icon_button.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../../../payment/presentation/ui/pkg_Page.dart';

class AddJobBodyPage extends StatelessWidget {
  AddJobBodyPage({super.key, this.generals});

  final General? generals;

  final addJobFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        BlocBuilder<GeneralCubit, GeneralState>(
          builder: (context, state) {
            if (state is GeneralLoading) {
              return Center(
                child: LoadingWidget(),
              );
            } else if (state is GeneralFetchedState) {
              return Column(
                children: [
                  Center(
                    child: DynamicFormWidget(
                        formKey: addJobFormKey,
                        dynamicFormsList: [
                          DynamicModel('Job Title', FormType.text,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: '',
                              isRequired: true,
                              disabled: false),
                          DynamicModel('Deadline', FormType.datePicker,
                              value: '',
                              isRequired: true,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              disabled: false),
                          DynamicModel('Qualifications', FormType.dropdown,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: '',
                              items: state.generals.qualifications
                                  .map(
                                    (e) => ItemModel(key: e, value: e),
                                  )
                                  .toList(),
                              isRequired: true,
                              disabled: false),
                          DynamicModel('Nationality', FormType.dropdown,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: '',
                              items: state.generals.nationality
                                  .map(
                                    (e) => ItemModel(key: e, value: e),
                                  )
                                  .toList(),
                              isRequired: true,
                              disabled: false),
                          DynamicModel('Gender', FormType.dropdown,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: '',
                              items: state.generals.gender
                                  .map(
                                    (e) => ItemModel(key: e, value: e),
                                  )
                                  .toList(),
                              isRequired: true,
                              disabled: false),
                          DynamicModel('Time parts', FormType.dropdown,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: '',
                              isRequired: true,
                              disabled: false),
                          DynamicModel('Other apply links', FormType.text,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: '',
                              isRequired: true,
                              disabled: false),
                          DynamicModel('Office Type', FormType.dropdown,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: '',
                              items: state.generals.officeType
                                  .map(
                                    (e) => ItemModel(key: e, value: e),
                                  )
                                  .toList(),
                              isRequired: true,
                              disabled: false),
                          DynamicModel(
                            'Address',
                            FormType.text,
                            validators: [
                              DynamicFormValidator(
                                  ValidatorType.notEmpty, 'isRequired')
                            ],
                            value: '',
                            isRequired: true,
                            disabled: false,
                            action: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder:(context) => LocationWidget(),));
                              },
                              icon: const Icon(
                                Icons.location_on,
                                color: primaryColor,
                              ),

                            ),
                          ),
                          DynamicModel('Job Description', FormType.multiline,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: '',
                              isRequired: true,
                              disabled: false),
                          DynamicModel('Job requirement', FormType.multiline,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: '',
                              isRequired: true,
                              disabled: false),
                        ],
                        useResponsiveUi: false),
                  ),
                  FloatingActionButton(
                      child: const Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => stepperPageBody(1)));
                      }),
                ],
              );
            } else if (state is GeneralErrorState) {
              print('GeneralErrorState');
              return Text(
                state.msg,
                style: TextStyle(color: Colors.red),
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }

  Widget buildMapLocationPicker() {
    return MapLocationPicker(
      apiKey: "AIzaSyB3WewDbc4RDT5KQDeZQ1wRncc9Xp0IPAI",
      hasLocationPermission: true,
      popOnNextButtonTaped: true,
      hideMapTypeButton: true,
      currentLatLng: const LatLng(22.968509, 44.917676),
      onNext: (GeocodingResult? result) {
        if (result != null) {

            print('next ${result.formattedAddress}');
            print('next ${result.geometry.location.toString()}');
            result.formattedAddress ?? "";
          }else
            return SizedBox();
        },

    );
  }
}
