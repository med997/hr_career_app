import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/location_cubit.dart';
import 'package:map_location_picker/map_location_picker.dart';


class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

/*
  String address = "null";
  String autocompletePlace = "null";
  Prediction? initialValue;*/

  @override
  Widget build(BuildContext context) {
      return MapLocationPicker(
          apiKey: "AIzaSyB3WewDbc4RDT5KQDeZQ1wRncc9Xp0IPAI",
          hasLocationPermission: true,
          popOnNextButtonTaped: false,
          backButton: BackButton(onPressed: () {
            Navigator.pop(context);
          },),

          hideMapTypeButton: true,

          currentLatLng: const LatLng(15.3318817, 43.0049128),
          onNext: (GeocodingResult? result) {
            if ( result != null) {
              final formattedAddress = result.formattedAddress ?? "";
              Navigator.pop(context,[formattedAddress,result.geometry.location.toString()]);

            }
          },
        );
      }
  }
