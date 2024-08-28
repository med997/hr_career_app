import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/widget/text_field_widget.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/widgets/dyn_form_widget.dart';

class SegmentedControlLoginWidget extends StatefulWidget {
  const SegmentedControlLoginWidget({super.key});

  @override
  _SegmentedControlLoginWidgetState createState() =>
      _SegmentedControlLoginWidgetState();
}

class _SegmentedControlLoginWidgetState
    extends State<SegmentedControlLoginWidget> {
  int _selectedIndex = 0;
  final List<String> _options = ['User', 'Company'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButtons(
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 100.0,
          ),
          fillColor: primaryColor,
          selectedBorderColor: primaryColor,
          selectedColor: Colors.white,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: primaryColor,
          color: primaryColor,
          isSelected: List.generate(
              _options.length, (index) => index == _selectedIndex),
          onPressed: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _options.map((String label) => Text(label)).toList(),
        ),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: _selectedIndex == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DynamicFormWidget(dynamicFormsList: [
                          DynamicModel('email', FormType.text,
                              controller: context.read<LoginCubit>().userEmailController,
                              value: '', isRequired: true, disabled: false),
                          DynamicModel('password', FormType.password,
                              controller: context.read<LoginCubit>().userPasswordController,
                              value: '', isRequired: true, disabled: false),
                        ], submitBtnLabel: 'register'),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DynamicFormWidget(dynamicFormsList: [
                          DynamicModel('email', FormType.text,
                              controller: context.read<LoginCubit>().companyEmailController,
                              value: '', isRequired: true, disabled: false),
                          DynamicModel('password', FormType.text,
                              controller: context.read<LoginCubit>().companyPasswordController,
                              value: '', isRequired: true, disabled: false),
                        ], submitBtnLabel: 'register'),
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}
