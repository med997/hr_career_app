

import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

class CreditCardPaymentWidget extends StatelessWidget {
  CreditCardPaymentWidget({super.key});

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_test_uPPeSaJvibxgtZtwUX2Jc5wYfsXZxXwQGvqiFTid',
    amount: 25758, // SAR 257.58
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
        // handle success.
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
    return  CreditCard(config: paymentConfig,
          onPaymentResult: onPaymentResult);
  }
}
