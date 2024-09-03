import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyCardWidget extends StatelessWidget {
  final String labelText;
  final int jobText;
  final String daysText;
  final String applianceText;

  const CompanyCardWidget({super.key,
    required this.labelText,
    required this.jobText,
    required this.daysText,
    required this.applianceText,});

  @override
  Widget build(BuildContext context) {
    return companyCardWidget();
  }

  Widget companyCardWidget() {
    return Center(
      child: Container(
        width: 400,
        height: 180,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Text(
          labelText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Text(
                '$jobText',
                style: TextStyle(fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade200),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('/job'),
            ),
          ],
        ),
        Text('- $daysText days available',
          style: TextStyle(color: Colors.grey.shade600),),
        Text('- $applianceText appliance',
            style: TextStyle(color: Colors.grey.shade600)),
        SizedBox(
        height: 20,
      ),
      ElevatedButton(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)))),
        child: const Text(
          'Select',
        ),
        onPressed: () {},
      ),
      ],
    ),)
    ,
    );
  }
}
