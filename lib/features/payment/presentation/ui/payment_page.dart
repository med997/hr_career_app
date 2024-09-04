
import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/payment/presentation/widgets/credit_card_payment_widget.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        CreditCardPaymentWidget()
      ],
    );
  }
}
