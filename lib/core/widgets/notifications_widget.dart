


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/notification/domain/entities/notification.dart';
import 'documents_widget.dart';

class NotificationListWidget extends StatelessWidget {
  final bool hasButtons;
  final bool hasDocument;
  final NotificationApp notification;


  const NotificationListWidget(
      {required this.hasButtons,
        required this.hasDocument, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ListTile(
            leading:  CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.black,
            ),
            title:  Text(
              notification.title,
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            trailing: Text(
              '${notification.createdAt}',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            subtitle: Text(
              notification.body,
              style:
              TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
//Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${notification.createdAt.hour}:${notification.createdAt.minute}',
//                   style: TextStyle(color: Colors.grey, fontSize: 16),
//                 ),
//                 Visibility(
//                   visible:
//                   hasDocument == true ? hasButtons == false : hasDocument,
//                   child: Document(
//                     size: '1.5 MB',
//                     fileName: 'Tet_Dart_Mode_v102.fig',
//                   ),
//                 ),
//                 Visibility(
//                   visible:
//                   hasButtons == true ? hasDocument == false : hasButtons,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       ElevatedButton(
//                           child: const Text(
//                             'Accept',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           onPressed: () {
//                             /* ... */
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                           )),
//                       const SizedBox(width: 8),
//                       ElevatedButton(
//                         child: const Text(
//                           'Deny',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         onPressed: () {
//                           /* ... */
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )