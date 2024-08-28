import 'package:flutter/material.dart';

AppBar loginAndRegisterAppBar() {
  return AppBar(
    title:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/imgs/project_logo.png'),
        const Text(
          'Welcome',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
        ),

        const Text(
          "Let's log in. Apply or post to jobs!",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    ),
    centerTitle: false,
    leadingWidth: 0,
    toolbarHeight: 120,
  );
}

