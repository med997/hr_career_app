import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';

class ApplyNowPage extends StatelessWidget {
  const ApplyNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
          userName: 'Ibrahim Murad',
          img: '',
          userOrCompany: 'User',
        ),
        body: const SizedBox());
  }
}
