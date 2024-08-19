import 'package:flutter/material.dart';

class Document extends StatelessWidget {
  final String size;
  final String fileName;

  const Document({required this.size, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.sticky_note_2, size: 40,color: Colors.blue,),
      title: Text(
        fileName,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        size,
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}
