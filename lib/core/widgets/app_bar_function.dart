import 'package:flutter/material.dart';

const String DefaultImage =
    'data:image/png;base64,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';

AppBar buildAppBar(String userName, String img, bool fullHeader) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullHeader ? 'Welcome Back!' : ' ',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text(
              fullHeader ? "$userName 👋🏻" : userName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (fullHeader == true)
          Center(
            child: CircleAvatar(
              radius: 23.0,
              backgroundImage:
              img != null ? NetworkImage(img) : NetworkImage(DefaultImage),
            ),
          )
        else
          SizedBox(),
      ],
    ),
  );
}
