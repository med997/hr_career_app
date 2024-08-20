

import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
final String message;
final Icon icons;

  const SearchWidget({required this.message, required this.icons});

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: SearchBar(
        hintText: message,
        leading: Icon(icons as IconData?),
        onTap: () {
          SearchButton();

        },
      ),
    );
  }
}


class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {});
  }
}
