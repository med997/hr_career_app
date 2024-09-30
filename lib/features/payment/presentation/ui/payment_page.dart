
import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/payment/presentation/widgets/credit_card_payment_widget.dart';
import 'package:moyasar/moyasar.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_test_uPPeSaJvibxgtZtwUX2Jc5wYfsXZxXwQGvqiFTid',
    amount: 25758, // SAR Halala
    description: 'order #1324',
    metadata: {'size': '250g'},
    creditCard: CreditCardConfig( saveCard: true, manual: false),
  );
  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.initiated:
          print('init');
          break;
        case PaymentStatus.paid:
          // result.
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
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        CreditCard(config: paymentConfig,
        onPaymentResult: onPaymentResult),
      ],
    );
  }
}
