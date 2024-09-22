import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';

class ToggleBtnWidget extends StatelessWidget {
  final Axis directions;
  ToggleBtnWidget({super.key, this.options = const ['User', 'Company'],  this.directions=Axis.horizontal});

  final List<String> options;

  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width /options.length;
    return BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ToggleButtons(
            constraints:  BoxConstraints.tightFor(height: 30,width:directions==Axis.vertical?350:null),
            fillColor: primaryColor,
            direction:directions,
            selectedBorderColor: primaryColor,
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            borderColor: primaryColor,
            color: primaryColor,
            isSelected: List.generate(
                options.length, (index) => index == state.selectedTab),
            onPressed: (int index) {
              context.read<ToggleBtnCubit>().changeTab(index);
            },
            children: options.map((String label) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(label),
            )).toList(),
          ),
        );
      },
    );
  }
}
