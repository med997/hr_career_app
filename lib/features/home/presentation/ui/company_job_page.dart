import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../widgets/recent_jobs.dart';

class CompanyJobPage extends StatelessWidget {
  CompanyJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Center(
          child: ToggleBtnWidget(
            options: const ['active', 'hidden', 'completed'],
          ),
        ),
        Flexible(
          child: ListView(
            children: [
              const SizedBox(
                height: 5,
              ),

              BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
                builder: (context, state) {
                  if(state is ToggleBtnChangedState){
                    return RecentJobsWidget(
                      jobCardType: JobCardType.company,selectedJobState: state.selectedTab,
                    );
                  } else {
                    return const SizedBox();
                  }

                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
