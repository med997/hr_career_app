import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/responsive.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _mobileWidgetBuilder(),
        tablet: _desktopWidgetBuilder(),
        desktop: _desktopWidgetBuilder());
  }


  Widget _mobileWidgetBuilder(){
    return
      ExpansionTile(
        title: SearchBar(

          leading: Icon(Icons.search, color: primaryTransparent,), ),
        children: <Widget>[
          DropdownMenu(
              label: Text('category'),
              dropdownMenuEntries:
              [
                DropdownMenuEntry(value: 1, label: 'mohammed'),
                DropdownMenuEntry(value: 2, label: 'ibrahem'),
                DropdownMenuEntry(value: 3, label: 'ahmed'),
                DropdownMenuEntry(value: 4, label: 'mohammed'),
              ]),
          DropdownMenu(
              label: Text('company'),
              dropdownMenuEntries:
              [
                DropdownMenuEntry(value: 1, label: 'mohammed'),
                DropdownMenuEntry(value: 2, label: 'ibrahem'),
                DropdownMenuEntry(value: 3, label: 'ahmed'),
                DropdownMenuEntry(value: 4, label: 'mohammed'),
              ]),
          DropdownMenu(
              label: Text('city'),
              dropdownMenuEntries:
              [
                DropdownMenuEntry(value: 1, label: 'mohammed'),
                DropdownMenuEntry(value: 2, label: 'ibrahem'),
                DropdownMenuEntry(value: 3, label: 'ahmed'),
                DropdownMenuEntry(value: 4, label: 'mohammed'),
              ]),
          ElevatedButton(onPressed:(){}, child: Text('search'))

        ],
      );
  }

  Widget _desktopWidgetBuilder(){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(

          direction: Axis.horizontal,
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            SearchBar(
              elevation:WidgetStatePropertyAll(0.0),
              hintText: 'Search',
              constraints: BoxConstraints(minWidth: 150, maxWidth: 300, maxHeight: 70, minHeight: 40),
              leading: Icon(Icons.search, color: primaryTransparent,), ),
            DropdownMenu(

              width: 220,
                label: Text('category'),
                dropdownMenuEntries:
                [
                  DropdownMenuEntry(value: 1, label: 'mohammed'),
                  DropdownMenuEntry(value: 2, label: 'ibrahem'),
                  DropdownMenuEntry(value: 3, label: 'ahmed'),
                  DropdownMenuEntry(value: 4, label: 'mohammed'),
                ]),
            DropdownMenu(

                width: 220,
                label: Text('company'),
                dropdownMenuEntries:
                [
                  DropdownMenuEntry(value: 1, label: 'mohammed'),
                  DropdownMenuEntry(value: 2, label: 'ibrahem'),
                  DropdownMenuEntry(value: 3, label: 'ahmed'),
                  DropdownMenuEntry(value: 4, label: 'mohammed'),
                ]),
            DropdownMenu(

                width: 220,
                label: Text('city'),
                dropdownMenuEntries:
                [
                  DropdownMenuEntry(value: 1, label: 'mohammed'),
                  DropdownMenuEntry(value: 2, label: 'ibrahem'),
                  DropdownMenuEntry(value: 3, label: 'ahmed'),
                  DropdownMenuEntry(value: 4, label: 'mohammed'),
                ]),
            FittedBox(

                child: ElevatedButton( onPressed:(){}, child: Text('search')))

          ],
        ),
      );
  }
}
