import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';


AppBar buildAppBar({required String userName, required String img, bool fullHeader = false}) {
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
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              fullHeader ? "$userName 👋🏻" : userName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (fullHeader == true)
          Center(
              child: CircleAvatar(
            child: ClipOval(
              child: img.isEmpty
                  ? Image.asset('imgs/image10.png')
                  : ImageHolder(
                      url: img ?? '',
                    ),
            ),
          ))
        else
          SizedBox(),
      ],
    ),
  );
}
