import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'documents_widget.dart';

class NotificationListWidget extends StatelessWidget {
  final bool hasButtons;
  final bool hasDocument;
  final String time;

  const NotificationListWidget(
      {required this.hasButtons,
        required this.time,
        required this.hasDocument});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.black,
            ),
            title: const Text(
              'Jenny Wilson compelete Create new copmonent',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Visibility(
                  visible:
                  hasDocument == true ? hasButtons == false : hasDocument,
                  child: Document(
                    size: '1.5 MB',
                    fileName: 'Tet_Dart_Mode_v102.fig',
                  ),
                ),
                Visibility(
                  visible:
                  hasButtons == true ? hasDocument == false : hasButtons,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ElevatedButton(
                          child: const Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            /* ... */
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          )),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        child: const Text(
                          'Deny',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
