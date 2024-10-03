import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/payment/domain/entities/package.dart';
import 'package:hr_career_platform/features/payment/domain/entities/payment.dart';
import 'package:hr_career_platform/features/payment/presentation/bloc/payment_curd_cubit.dart';
import 'package:moyasar/moyasar.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  PaymentConfig? paymentConfig;

  Package? pkg;

  Job? job;

  onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.initiated:
          print('init');
          break;
        case PaymentStatus.paid:
          Payment payment = Payment(jobId: job!.id!,
              companyId: job!.companyId!,
              amount: result.amount,
              refId: result.id,
              amountTxt: result.amountFormat,
              fee: result.feeFormat,
              description: result.description!,
              metadata: result.metadata,
              pkg: pkg!.id!);
          context.read<PaymentCurdCubit>().insertPayment(payment);

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
    job = context
        .read<StepperCubit>()
        .job!;
    pkg = context
        .read<StepperCubit>()
        .package!;
    paymentConfig = PaymentConfig(
      publishableApiKey: 'pk_test_9GuD6YHzMHnA43YVkeH6nyUFzk2uEYc9AepYdQnP',
      amount: pkg!.price * 100,
      // SAR Halala
      description: 'payment ${pkg!.pkgName} for Job No ${job!
          .id} from company id ${job!.companyId}',
      metadata: {'pkgDesc': ' ${pkg!.desc}', "jobTitle": job!.jobTitle},
      creditCard: CreditCardConfig(saveCard: true, manual: false),
    );
  }



  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        CreditCard(config: paymentConfig!,
            onPaymentResult: onPaymentResult),
        BlocConsumer<PaymentCurdCubit, PaymentCurdState>(
          listener: (context, state) {
            if (state is MessageCurdPaymentState){
              context.read<StepperCubit>().job=null;
              context.read<StepperCubit>().package=null;
              context.read<StepperCubit>().changeStep(0);
              Navigator.pop(context);

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
