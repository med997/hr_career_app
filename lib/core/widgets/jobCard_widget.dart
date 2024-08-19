import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String jobName;
  final String companyName;

  const JobCard({
    required this.jobName,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Text(
              jobName,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.yellowAccent,
            ),
            title: Text(
              companyName,
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.timelapse_outlined),
                Text(
                  '2 hour ago',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
