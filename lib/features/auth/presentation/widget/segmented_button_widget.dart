import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/auth/presentation/widget/text_field_widget.dart';
import '../../../../core/app_theme.dart';

class SegmentedControlWidget extends StatefulWidget {
  const SegmentedControlWidget({super.key});

  @override
  _SegmentedControlWidgetState createState() => _SegmentedControlWidgetState();
}

class _SegmentedControlWidgetState extends State<SegmentedControlWidget> {
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
              ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFieldWidget(
                label: 'Full Name',
                icon: Icons.person_outline_rounded,
              ),
              TextFieldWidget(
                label: 'Email',
                icon: Icons.email_outlined,
              ),
              TextFieldWidget(
                label: '+967',
                icon: Icons.phone,
              ),
              TextFieldWidget(
                label: 'Password',
                icon: Icons.key_outlined,
              ),
              TextFieldWidget(
                label: 'Confirm Password',
                icon: Icons.key_outlined,
              ),
            ],
          )
              : const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFieldWidget(
                label: 'Company Name',
                icon: Icons.person_outline_rounded,
              ),
              TextFieldWidget(
                label: 'Email',
                icon: Icons.email_outlined,
              ),
              TextFieldWidget(
                label: 'Address',
                icon: Icons.place_outlined,
              ),
              TextFieldWidget(
                label: '+967',
                icon: Icons.phone,
              ),
              TextFieldWidget(
                label: 'Password',
                icon: Icons.key_outlined,
              ),
              TextFieldWidget(
                label: 'Confirm Password',
                icon: Icons.key_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
