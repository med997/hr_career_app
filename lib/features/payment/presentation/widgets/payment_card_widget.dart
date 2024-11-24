import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../domain/entities/package.dart';

class PaymentCardWidget extends StatelessWidget {
  final Package pkg;
  final Function onPkgSelected;

  const PaymentCardWidget({
    super.key,
    required this.pkg,
    required this.onPkgSelected,
  });

  @override
  Widget build(BuildContext context) {
    return paymentCardWidget();
  }

  Widget paymentCardWidget() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pkg.pkgName.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 2,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Text(
                  pkg.price.toString(),
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: primaryColor.withOpacity(0.4)),
                ),
                 Text('currencyJob'.tr()),
              ],
            ),
            const SizedBox(height: 12),
            ...pkg.desc.map((feature) {
              return  Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '• ${feature.tr()}', style: TextStyle(color: Colors.grey.shade600)),
              );
            },),
            const SizedBox(height: 20),
            _selectPkgBtn(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  _selectPkgBtn() {
    return Center(
      child: SizedBox(
        width: 350,
        height: 30,
        child: MaterialButton(
          color: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            onPkgSelected();

          },
          enableFeedback: false,
          child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Select'.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
