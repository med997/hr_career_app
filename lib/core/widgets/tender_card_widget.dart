import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/widgets/text_with_icon.dart';
import '../../features/tender/domain/entities/tender.dart';
import '../app_localizations.dart';
import 'avatar_network.dart';
import 'custom_chips.dart';

class TenderCardWidget extends StatelessWidget {
  final Color? chipBgColor;
  final String? chipText;
  Tender tender;
  double? columnWidth;

 TenderCardWidget({
   this.chipBgColor,
   required this.tender,
   this.chipText,
   this.columnWidth,});

  @override
  Widget build(BuildContext context) {
    return _tenderCard();
  }

  Widget _tenderCard() {
    double width = columnWidth ?? 320;
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border:
          Border.all(color: Colors.blueGrey.withOpacity(0.5), width: 0.5),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: Text(
              tender.tenderTitle,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          ListTile(
            leading:const AvatarNetwork(
              imgUrl:  '',
              withBorder: true,
            ),
            title:  const Text(
               '',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            subtitle: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              direction: Axis.horizontal,
              children: [
                CustomChips(
                  chipsTitles: [tr("tenders_msg")],
                  bgColor: Colors.blue.shade200,
                ),
                 TextWithIcon(
                    icon: const Icon(
                      Icons.timelapse_outlined,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    text: '${tender.deadlineDate!.hour}g ago'),
                    // text: '${job.deadlineDate!.hour}h ago'),
                 TextWithIcon(
                    icon: const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    text: tender.city),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
