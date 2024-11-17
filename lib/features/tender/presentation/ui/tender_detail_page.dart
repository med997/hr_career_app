import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/features/company/presentation/ui/company_details_profile_page.dart';
import 'package:parchment_to_html/parachment_to_html.dart';

import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../domain/entities/tender.dart';
import '../widgets/tender_details_header.dart';
import '../widgets/tender_details_tabbar.dart';

class TenderDetailsPage extends StatefulWidget {
  final Tender tender;

  const TenderDetailsPage({super.key, required this.tender});

  @override
  State<TenderDetailsPage> createState() => _TenderDetailsPageState();
}

class _TenderDetailsPageState extends State<TenderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Responsive(
              mobile: _buildMobileWidget(context),
              tablet: _buildTabletAndDesktopWidget(context),
              desktop: _buildTabletAndDesktopWidget(context))),
    );
  }

  _buildMobileWidget(
    BuildContext context,
  ) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        Flexible(
            flex: 2,
            child: TenderDetailsHeader(
              tender: widget.tender,
              profileFilledText: MaterialButton(
                minWidth: 35,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompanyProfileDetailPage(
                              company: widget.tender.company!)));
                },
                child: const Icon(
                  Icons.person,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              profileIcoButton: MaterialButton(
                minWidth: 25,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                child: SizedBox(),
                onPressed: () {},
              ),
            )),
        Expanded(
            /*fit: FlexFit.tight,flex: 1,*/
            flex: 3,
            child: TenderDetailsTabBar(tender: widget.tender)),
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
                "apply_now_msg".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildTabletAndDesktopWidget(
    BuildContext context,
  ) {
    ParchmentDocument? documentDesc = widget.tender.tenderDescFormated != null
        ? ParchmentDocument.fromJson(
            jsonDecode(jsonEncode(widget.tender.tenderDescFormated)))
        : null;
    ParchmentDocument? documentOtherLinks =
        widget.tender.otherApplyLinksFormated != null
            ? ParchmentDocument.fromJson(
                jsonDecode(jsonEncode(widget.tender.otherApplyLinksFormated)))
            : null;
    const converter = ParchmentHtmlCodec();

    String? htmlDesc =
        documentDesc != null ? converter.encode(documentDesc.toDelta()) : null;
    String? htmlOtherLinks = documentOtherLinks != null
        ? converter.encode(documentOtherLinks.toDelta())
        : null;
    double width = 400 /*MediaQuery.of(context).size.width*/;
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            SizedBox(
                width: 400,
                child: TenderDetailsHeader(
                  tender: widget.tender,
                  profileFilledText: MaterialButton(
                    minWidth: 35,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompanyProfileDetailPage(
                                  company: widget.tender.company!)));
                    },
                    child: const Icon(
                      Icons.person,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  profileIcoButton: MaterialButton(
                    minWidth: 25,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                  ),
                )),
            SubTitle(
              title: "description_msg".tr(),
              titleType: SubTitleType.textOnly,
            ),
            Expanded(
              child: SizedBox(
                width: width,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: htmlDesc != null
                          ? Html(
                              data: htmlDesc,
                            )
                          : Text(
                              widget.tender.tenderDesc!,
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(
                width: 260,
                height: 35,
                child: MaterialButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {},
                  child: Text(
                    "apply_now_msg".tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              const SizedBox(
                height: 12,
              ),
              SubTitle(
                title: "how_to_apply_msg".tr(),
                titleType: SubTitleType.textOnly,
              ),
              const SizedBox(
                height: 20,
              ),
              htmlOtherLinks != null
                  ? Html(
                      data: htmlOtherLinks,
                    )
                  : Text(
                      widget.tender.otherApplyLinks!,
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
