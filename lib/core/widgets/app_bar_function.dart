import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/locale_cubit.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';

AppBar buildAppBar(
    {required String userName, required String img, bool fullHeader = false}) {
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
        BlocBuilder<LocaleCubit, ChangeLocaleState>(
          builder: (context, state) {
            return DropdownButton<String>(
              value: state.locale.languageCode,
              items: ['ar', 'en'].map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),);
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null ) {
                  context.read<LocaleCubit>().changeLanguage(newValue);
                }
              },
            );
          },
        ),
        if (fullHeader == true)
          Center(
              child: AvatarNetwork(
                imgUrl: '',
                withBorder: false,
              ))
        else
          SizedBox(),
      ],
    ),
  );
}
