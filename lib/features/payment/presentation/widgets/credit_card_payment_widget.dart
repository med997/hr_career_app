

import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

class CreditCardPaymentWidget extends StatelessWidget {
  CreditCardPaymentWidget({super.key});

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'YOUR_API_KEY',
    amount: 25758, // SAR 257.58
    description: 'order #1324',
    metadata: {'size': '250g'},
    creditCard: CreditCardConfig(saveCard: true, manual: false),
  );
  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          break;
        case PaymentStatus.failed:
          break;
        case PaymentStatus.initiated:

        case PaymentStatus.authorized:

        case PaymentStatus.captured:

      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return CreditCard(config: paymentConfig,
        onPaymentResult: onPaymentResult);
  }
}
