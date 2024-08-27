import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/auth/presentation/widget/text_field_widget.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/widgets/dyn_form_widget.dart';

class SegmentedControlRegisterWidget extends StatefulWidget {
  const SegmentedControlRegisterWidget({super.key});

  @override
  _SegmentedControlRegisterWidgetState createState() => _SegmentedControlRegisterWidgetState();
}

class _SegmentedControlRegisterWidgetState extends State<SegmentedControlRegisterWidget> {
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: _selectedIndex == 0
              ?  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DynamicFormWidget(dynamicFormsList: [
                DynamicModel('Full Name', FormType.text,value: '',isRequired: true, disabled: false),
                DynamicModel('Email', FormType.text,value: '',isRequired: true, disabled: false),
                DynamicModel('phone Number', FormType.text,value: '',isRequired: true, disabled: false),
                DynamicModel('Password', FormType.text,value: '',isRequired: true, disabled: false),
                DynamicModel('Confirm Password', FormType.text,value: '',isRequired: true, disabled: false),
              ], submitBtnLabel: 'login'),
            ],
          )
              :  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DynamicFormWidget(dynamicFormsList: [
                DynamicModel('Company Name', FormType.text,value: '',isRequired: true, disabled: false),
                DynamicModel('Email', FormType.text,value: '',isRequired: true, disabled: false),
                DynamicModel('Address', FormType.text,value: '',isRequired: true, disabled: false),
                DynamicModel('Phone Number', FormType.text,value: '',isRequired: true, disabled: false),
                DynamicModel('Password', FormType.text,value: '',isRequired: true, disabled: false),
                DynamicModel('Confirm Password', FormType.text,value: '',isRequired: true, disabled: false),

              ], submitBtnLabel: 'login'),
            ],
          ),
        ),
      ],
    );
  }
}
