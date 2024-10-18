import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/payment/domain/entities/package.dart';
import 'package:hr_career_platform/features/payment/presentation/bloc/package_cubit.dart';
import 'package:hr_career_platform/features/payment/presentation/bloc/package_cubit.dart';
import 'package:hr_career_platform/features/payment/presentation/widgets/payment_card_widget.dart';

import '../../../job/presentation/bloc/stepper_cubit.dart';

class PkgPage extends StatefulWidget {

  final PkgType pkgType;
  const PkgPage({super.key, required this.pkgType});

  @override
  State<PkgPage> createState() => _PkgPageState();
}

class _PkgPageState extends State<PkgPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageCubit, PackageState>(
      builder: (context, state) {
        if (state is PackageFetchedState) {
          return ListView.builder(
            itemCount: state.packages.length,
            itemBuilder: (context, index) {
              Package e = state.packages[index];
              return InkWell(
                  child: PaymentCardWidget(
                pkg: e,
                onPkgSelected: () {
                  context.read<StepperCubit>().addJobChangeStep(2, selectedPackage: e);
                },
              ));
            },
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 32),
          );
        } else if (state is PackageLoadingState) {
          return LoadingWidget();
        }

        return SizedBox();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<PackageCubit>().getAllJobPackage(widget.pkgType);
  }
}
