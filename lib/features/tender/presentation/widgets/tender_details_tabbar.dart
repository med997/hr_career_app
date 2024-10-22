import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';
import 'package:parchment_to_html/parachment_to_html.dart';

import '../../domain/entities/tender.dart';


class TenderDetailsTabBar extends StatefulWidget {
  final Tender tender;

  const TenderDetailsTabBar({super.key, required this.tender});

  @override
  State<TenderDetailsTabBar> createState() => _TenderDetailsTabBarState();
}

class _TenderDetailsTabBarState extends State<TenderDetailsTabBar> {
  @override
  Widget build(BuildContext context) {
    print(widget.tender.tenderDescFormated);
    ParchmentDocument? documentTenderDesc =
        widget.tender.tenderDescFormated != null
            ? ParchmentDocument.fromJson(
                jsonDecode(jsonEncode(widget.tender.tenderDescFormated)))
            : null;
    const converter = ParchmentHtmlCodec();
    String? htmlTenderDesc = documentTenderDesc != null
        ? converter.encode(documentTenderDesc.toDelta())
        : null;
    return Column(
      children: [
        Center(
          child: ToggleBtnWidget(
            options: [
              tr("description_msg"),
              tr("how_to_apply_msg")
            ], // Adjusted options
          ),
        ),

        Flexible(
          child: ListView(children: [
            BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
              builder: (context, state) {
                switch (state.selectedTab) {
                  case 0:
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: htmlTenderDesc != null
                          ? Html(
                              data: htmlTenderDesc,
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
                    );

                  case 1:
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(''),
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ]),
        ),
      ],
    );
  }
}
