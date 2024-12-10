import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/payment/domain/entities/package.dart';
import 'package:hr_career_platform/features/payment/domain/entities/payment.dart';
import 'package:hr_career_platform/features/payment/presentation/bloc/payment_curd_cubit.dart';
import 'package:hr_career_platform/features/tender/domain/entities/tender.dart';
import 'package:moyasar/moyasar.dart';

import '../../../../core/widgets/success_dialog.dart';
import '../../../auth/presentation/bloc/login_cubit.dart';
import '../../../home/presentation/ui/company_home_page.dart';

class PaymentPage extends StatefulWidget {
  final PkgType pkgType;

  const PaymentPage({super.key, required this.pkgType});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentConfig? paymentConfig;

  Package? pkg;

  Job? job;
  Tender? tender;

  _insertPaymentJob(result) {
    Payment payment = Payment(
        jobId: job!.id!,
        companyId: job!.companyId!,
        amount: result.amount,
        refId: result.id,
        amountTxt: result.amountFormat,
        fee: result.feeFormat,
        description: result.description!,
        metadata: result.metadata,
        pkg: pkg!.id!);
    context.read<PaymentCurdCubit>().insertPayment(payment);
  }

  _insertPaymentTender(result) {
    Payment payment = Payment(
        tenderId: tender!.id!,
        companyId: tender!.companyId!,
        amount: result.amount,
        refId: result.id,
        amountTxt: result.amountFormat,
        fee: result.feeFormat,
        description: result.description!,
        metadata: result.metadata,
        pkg: pkg!.id!);
    context.read<PaymentCurdCubit>().insertPayment(payment);
  }

  onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.initiated:
          print('init');
          break;
        case PaymentStatus.paid:
          if (widget.pkgType == PkgType.job) {
            _insertPaymentJob(result);
          } else {
            _insertPaymentTender(result);
          }

          print('paid');
          break;
        case PaymentStatus.failed:
          // handle failure.
          print('failed');
          break;
        case PaymentStatus.authorized:
          print('auth');
          break;
        case PaymentStatus.captured:
          print('capture');
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    pkg = context.read<StepperCubit>().package!;
    if (widget.pkgType == PkgType.job) {
      job = context.read<StepperCubit>().job!;
      paymentConfig = PaymentConfig(
        publishableApiKey: 'pk_test_9GuD6YHzMHnA43YVkeH6nyUFzk2uEYc9AepYdQnP',
        amount: pkg!.price * 100,
        // SAR Halala
        description:
            'payment ${pkg!.pkgName} for Job No ${job!.id} from company id ${job!.companyId}',
        metadata: {'pkgDesc': ' ${pkg!.desc}', "title'": job!.jobTitle},
        creditCard: CreditCardConfig(saveCard: true, manual: false),
      );
    } else {
      tender = context.read<StepperCubit>().tender!;

      paymentConfig = PaymentConfig(
        publishableApiKey: 'pk_test_9GuD6YHzMHnA43YVkeH6nyUFzk2uEYc9AepYdQnP',
        amount: pkg!.price * 100,
        // SAR Halala
        description:
            'payment ${pkg!.pkgName} for tender No ${tender!.id} from company id ${tender!.companyId}',
        metadata: {'pkgDesc': ' ${pkg!.desc}', 'title': tender!.tenderTitle},
        creditCard: CreditCardConfig(saveCard: true, manual: false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        CreditCard(config: paymentConfig!, onPaymentResult: onPaymentResult),
        BlocConsumer<PaymentCurdCubit, PaymentCurdState>(
          listener: (context, state) {
            if (state is MessageCurdPaymentState) {
              context.read<StepperCubit>().job = null;
              context.read<StepperCubit>().tender = null;
              context.read<StepperCubit>().package = null;

              showDialog(
                  context: context,
                  builder: (context) => SuccessDialog(
                        message: 'Job_inserted_done'.tr(),
                        onDonePressed: () {
                          context.read<StepperCubit>().addJobChangeStep(0);
                          context.read<StepperCubit>().addTenderChangeStep(0);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => HomeCompanyPage(auth: context.read<LoginCubit>().authenticatedUser!)
                          ));                        },
                      ));
            }
          },
          builder: (context, state) {
            if (state is LoadingCurdPaymentState) {
              return LoadingWidget();
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
