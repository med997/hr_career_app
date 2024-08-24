import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/custom_drop_down_menu.dart';

class SearchWidget extends StatelessWidget {
 final double spacer = 4.0;
  late double  screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Responsive(
        mobile: _mobileWidgetBuilder(),
        tablet: _desktopWidgetBuilder(),
        desktop: _desktopWidgetBuilder());
  }

  Widget _mobileWidgetBuilder() {

    return ExpansionTile(

      childrenPadding: EdgeInsets.all(4),
      title:  SizedBox(
        width: 200,
        child: SearchBar(
          constraints: BoxConstraints.tight(
              const Size.fromHeight(35)),
          elevation: const WidgetStatePropertyAll(0.0),
          hintText: 'Search',
          leading: Icon(
            Icons.search,
            color: primaryTransparent,
          ),
        ),
      ),

      children: [

        Padding(
          padding:  EdgeInsets.all(spacer),
          child: buildCustomDropDownMenu('Category', [
            DropdownMenuEntry(value: 1, label: 'mohammed'),
            DropdownMenuEntry(value: 2, label: 'ibrahem'),
            DropdownMenuEntry(value: 3, label: 'ahmed'),
            DropdownMenuEntry(value: 4, label: 'mohammed'),
          ]),
        ),
        Padding(
          padding:  EdgeInsets.all(spacer),
          child: buildCustomDropDownMenu('Category', [
            DropdownMenuEntry(value: 1, label: 'mohammed'),
            DropdownMenuEntry(value: 2, label: 'ibrahem'),
            DropdownMenuEntry(value: 3, label: 'ahmed'),
            DropdownMenuEntry(value: 4, label: 'mohammed'),
          ]),
        ),
        Padding(
          padding:  EdgeInsets.all(spacer),
          child: buildCustomDropDownMenu('Category', [
            DropdownMenuEntry(value: 1, label: 'mohammed'),
            DropdownMenuEntry(value: 2, label: 'ibrahem'),
            DropdownMenuEntry(value: 3, label: 'ahmed'),
            DropdownMenuEntry(value: 4, label: 'mohammed'),
          ]),
        ),

        Padding(
          padding:  EdgeInsets.all(spacer),
          child: SizedBox(

              width: 350,
              height: 35,
              child: ElevatedButton( onPressed: () {}, child: Text('search'))),
        )
      ],
    );
  }

  Widget _desktopWidgetBuilder() {
    double widthItem = (screenWidth/5 - 50);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: (spacer*2),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          SizedBox(

            width: widthItem,
            child: SearchBar(
              constraints: BoxConstraints.tight(
                  const Size.fromHeight(35)),
              elevation: WidgetStatePropertyAll(0.0),
              hintText: 'Search',
              leading: Icon(
                Icons.search,
                color: primaryTransparent,
              ),
            ),
          ),
          buildCustomDropDownMenu('company', [
            DropdownMenuEntry(value: 1, label: 'mohammed'),
            DropdownMenuEntry(value: 2, label: 'ibrahem'),
            DropdownMenuEntry(value: 3, label: 'ahmed'),
            DropdownMenuEntry(value: 4, label: 'mohammed'),
          ], width: widthItem),
          buildCustomDropDownMenu('company', [
            DropdownMenuEntry(value: 1, label: 'mohammed'),
            DropdownMenuEntry(value: 2, label: 'ibrahem'),
            DropdownMenuEntry(value: 3, label: 'ahmed'),
            DropdownMenuEntry(value: 4, label: 'mohammed'),
          ], width: widthItem),
          buildCustomDropDownMenu('company', [
            DropdownMenuEntry(value: 1, label: 'mohammed'),
            DropdownMenuEntry(value: 2, label: 'ibrahem'),
            DropdownMenuEntry(value: 3, label: 'ahmed'),
            DropdownMenuEntry(value: 4, label: 'mohammed'),
          ], width: widthItem),
          Container(

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              width: widthItem,
              height: 35,
              child: ElevatedButton( onPressed: () {},
                  child: Text('search'))),
        ],
      ),
    );
  }
}
