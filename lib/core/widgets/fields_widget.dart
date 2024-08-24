import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:intl_phone_field/intl_phone_field.dart';



class FieldsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _mobileWidgetFields(),
        tablet: _desktopWidgetFields(),
        desktop: _desktopWidgetFields()
    );
  }

  Widget _mobileWidgetFields () {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding:EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          child: TextField(
            decoration: decorationFields.copyWith(
                label: Icon(
              Icons.person,
              color: Colors.grey[350],
              size: 22,),
                hintText: 'E-mail'),
          ),
        ),

        Container(
          padding:EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          child: TextFormField(
            decoration: decorationFields.copyWith(
              hintText: 'Password',
              label: Icon(
                Icons.email_outlined,
                color: Colors.grey[350],
                size: 22,
              ),
            ),
          ),
        ),
        Container(
          padding:EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          child: IntlPhoneField(
            decoration: decorationFields.copyWith(),
            initialCountryCode: 'SA',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        ),

      ],
    );
  }

  Widget _desktopWidgetFields ()  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: TextField(
            decoration: decorationFields.copyWith(label: Icon(
              Icons.person,
              color: Colors.grey[350],
              size: 22,),
                hintText: 'E-mail'),
          ),
        ),
        SizedBox(width: 20,),
        Flexible(
          child: TextFormField(
            decoration: decorationFields.copyWith(
              hintText: 'Password',
              label: Icon(
                Icons.email_outlined,
                color: Colors.grey[350],
                size: 22,
              ),
            ),
          ),
        ),
        SizedBox(width: 20,),
        Flexible(
          child: IntlPhoneField(
            decoration: decorationFields,
            initialCountryCode: 'SA',

          ),
        ),
      ],
    );
  }
}


InputDecoration decorationFields = InputDecoration(
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: Colors.blueAccent.shade700
        )),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8)),
    hintStyle: TextStyle(
        color: Colors.grey
    )
);