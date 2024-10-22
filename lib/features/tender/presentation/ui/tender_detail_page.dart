import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/features/company/presentation/ui/company_details_profile_page.dart';


import '../../domain/entities/tender.dart';
import '../widgets/tender_details_header.dart';
import '../widgets/tender_details_tabbar.dart';


class TenderDetailsPage extends StatelessWidget {
  final Tender tender;

  const TenderDetailsPage({super.key, required this.tender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            Flexible(
                flex: 2,
                child: TenderDetailsHeader(
                  tender: tender,
                  profileFilledText: MaterialButton(
                    minWidth: 35,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => CompanyProfileDetailPage(
                                  company: tender.company!)));
                    },
                    child:  const Icon(Icons.person, size: 18,color: Colors.white,),
                  ),
                  profileIcoButton: MaterialButton(
                    minWidth: 25,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(0),
                    child: const Icon(Icons.visibility_off_outlined, size: 18,color: Colors.orangeAccent,),
                    onPressed: () {  },

                  ),
                )),
            Expanded(
              /*fit: FlexFit.tight,flex: 1,*/
                flex: 3,
                child: TenderDetailsTabBar(tender: tender)),
            Center(
              child: SizedBox(
                width: 260,
                height: 35,
                child: MaterialButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {},
                  child: Text(
                    tr("apply_now_msg"),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
