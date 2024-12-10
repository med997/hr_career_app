import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/success_dialog.dart';
import 'package:hr_career_platform/features/payment/domain/entities/package.dart';
import 'package:hr_career_platform/features/payment/presentation/bloc/package_cubit.dart';
import 'package:hr_career_platform/features/payment/presentation/widgets/payment_card_widget.dart';
import 'package:moyasar/moyasar.dart';

import '../../../auth/presentation/bloc/login_cubit.dart';
import '../../../home/presentation/ui/company_home_page.dart';
import '../../../job/domain/entities/job.dart';
import '../../../job/presentation/bloc/stepper_cubit.dart';
import '../../../tender/domain/entities/tender.dart';
import '../../domain/entities/payment.dart';
import '../bloc/payment_curd_cubit.dart';

class PkgPage extends StatefulWidget {
  final PkgType pkgType;

  const PkgPage({super.key, required this.pkgType});

  @override
  State<PkgPage> createState() => _PkgPageState();
}

class _PkgPageState extends State<PkgPage> {
  PaymentConfig? paymentConfig;

  Job? job;
  Tender? tender;

  _insertPaymentJob(int pkgId) {
    Payment payment = Payment(
        jobId: job!.id,
        companyId: job!.companyId!,
        amount: 0,
        refId: 'FreeJob ${job!.id}',
        amountTxt: 'Zero',
        fee: '0',
        description: 'FreeJob ${job!.id}',
        metadata: 'FreeJob ${job!.id}',
        pkg: pkgId);
    context.read<PaymentCurdCubit>().insertPayment(payment);
    job = context.read<StepperCubit>().job!;
  }

  _insertPaymentTender(int pkgId) {
    Payment payment = Payment(
        tenderId: tender!.id!,
        companyId: tender!.companyId!,
        amount: 0,
        refId: 'FreeJob ${tender!.id}',
        amountTxt: 'Zero',
        fee: '0',
        description: 'FreeJob ${tender!.id}',
        metadata: 'FreeJob ${tender!.id}',
        pkg: pkgId);
    context.read<PaymentCurdCubit>().insertPayment(payment);
    tender = context.read<StepperCubit>().tender!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageCubit, PackageState>(
      builder: (context, state) {
        if (state is PackageFetchedState) {
          return Scaffold(
            body: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<PaymentCurdCubit, PaymentCurdState>(
                  listener: (context, state) {
                    if (state is MessageCurdPaymentState) {
                      context.read<StepperCubit>().job = null;
                      context.read<StepperCubit>().tender = null;
                      context.read<StepperCubit>().package = null;
                      context.read<StepperCubit>().addJobChangeStep(0);
                      context.read<StepperCubit>().addTenderChangeStep(0);
                      showDialog(
                        context: context,
                        builder: (context) => SuccessDialog(
                          message: widget.pkgType == PkgType.job
                              ? 'Job_inserted_done'.tr()
                              : 'tender_inserted_done'.tr(),
                          onDonePressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => HomeCompanyPage(auth: context.read<LoginCubit>().authenticatedUser!)
                            ));                          },
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingCurdPaymentState) {
                      return LoadingWidget();
                    } else if (state is ErrorCurdPaymentState) {
                      return Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Flexible(
                  child: Responsive(
                      mobile: buildMobileLayout(state.packages),
                      tablet: _buildTabletDesktopLayout(state.packages, 2),
                      desktop: _buildTabletDesktopLayout(state.packages, 3)),
                )
              ],
            ),
          );
        } else if (state is PackageLoadingState) {
          return LoadingWidget();
        }

        return const SizedBox();
      },
    );
  }

  Widget buildMobileLayout(List<Package> packages) {
    return Expanded(
      child: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (context, index) {
          Package e = packages[index];
          return InkWell(
              child: PaymentCardWidget(
            pkg: e,
            onPkgSelected: () {
              if (e.price == 0) {
                if (widget.pkgType == PkgType.job) {
                  _insertPaymentJob(e.id!);
                } else {
                  _insertPaymentTender(e.id!);
                }
              } else {
                context
                    .read<StepperCubit>()
                    .addJobChangeStep(2, selectedPackage: e);
              }
            },
          ));
        },
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 32),
      ),
    );
  }

  Widget _buildTabletDesktopLayout(List<Package> packages, int columnCount) {
    double itemWidth = MediaQuery.of(context).size.width / columnCount - 50;
    if (Responsive.isDesktop(context))
      itemWidth = MediaQuery.of(context).size.width / columnCount - 100;

    return ListView(
    shrinkWrap: true,
      children: [
        Center(
          child: Wrap(children: [
            ...packages.map(
              (package) => SizedBox(
                width: itemWidth,
                child: InkWell(
                    child: PaymentCardWidget(
                  pkg: package,
                  onPkgSelected: () {
                    if (package.price == 0) {
                      if (widget.pkgType == PkgType.job) {
                        _insertPaymentJob(package.id!);
                      } else {
                        _insertPaymentTender(package.id!);
                      }
                    } else {
                      context
                          .read<StepperCubit>()
                          .addJobChangeStep(2, selectedPackage: package);
                    }
                  },
                )),
              ),
            )
          ]),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<PackageCubit>().getAllJobPackage(widget.pkgType);
    if (widget.pkgType == PkgType.job) {
      job = context.read<StepperCubit>().job!;
    } else {
      tender = context.read<StepperCubit>().tender!;
    }
  }
}
