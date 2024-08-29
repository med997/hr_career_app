import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';

class ToggleBtnWidget extends StatelessWidget {
  ToggleBtnWidget({super.key});

  final List<String> _options = ['User', 'Company'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ToggleButtons(
            constraints: const BoxConstraints.tightFor(height: 35, width: 120),
            fillColor: primaryColor,
            selectedBorderColor: primaryColor,
            selectedColor: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            borderRadius: BorderRadius.circular(8.0),
            borderColor: primaryColor,
            color: primaryColor,
            isSelected: List.generate(
                _options.length, (index) => index == state.selectedTab),
            onPressed: (int index) {
              context.read<ToggleBtnCubit>().changeTab(index);
            },
            children: _options.map((String label) => Text(label)).toList(),
          ),
        );
      },
    );
  }
}
