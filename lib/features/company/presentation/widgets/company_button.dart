import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
class CompanyButton extends StatelessWidget {
  CompanyButton({super.key});

  @override
  Widget build(BuildContext context) {
        return Wrap(
          alignment: WrapAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                  onPressed: ([int value = 0]) {
                    context.read<ToggleBtnCubit>().changeTab(value);
                  },
                  statesController: WidgetStatesController(),
                  style: ButtonStyle(
                      padding:
                          const WidgetStatePropertyAll(EdgeInsets.symmetric(
                        horizontal: 45,
                      )),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: const Text('Main Information')),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: OutlinedButton(
                  onPressed: ([int value = 1]) {
                    context.read<ToggleBtnCubit>().changeTab(value);
                  },
                  style: ButtonStyle(
                      padding:
                          const WidgetStatePropertyAll(EdgeInsets.symmetric(
                        horizontal: 55,
                      )),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: const Text('Gallery')),
            ),
            // IconButton(
            //     onPressed: () {},
            //     padding: const EdgeInsets.symmetric(horizontal: 80),
            //     icon: const Icon(
            //       Icons.edit_road,
            //       color: primaryColor,
            //     )),
            // Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 80),
            //     child: const Text(
            //       "Main Information",
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     )),
            //  const SizedBox(
            //   width: 10,
            // ),
            //
          ],
        );
  }
}

// IconButton(
//     onPressed: () {},
//     padding: const EdgeInsets.symmetric(horizontal: 80),
//     icon: const Icon(
//       Icons.edit_road,
//       color: primaryColor,
//     )),
// Container(
//     padding: const EdgeInsets.symmetric(horizontal: 80),
//     child: const Text(
//       "Main Information",
//       style: TextStyle(fontWeight: FontWeight.bold),
//     )),
//  const SizedBox(
//   width: 10,
// ),
