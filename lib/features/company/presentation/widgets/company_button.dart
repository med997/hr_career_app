// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hr_career_platform/core/app_theme.dart';
// import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
// import 'package:hr_career_platform/core/model/dynamic_model.dart';
// import 'package:hr_career_platform/core/util/responsive.dart';
// import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
// import 'package:hr_career_platform/core/widgets/sub-title.dart';
// import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';
//
// import '../../../../core/cubit/dynamic_form_cubit.dart';
// import '../../../../core/util/enums.dart';
// import '../../../../core/util/validator.dart';
//
// class CompanyButton extends StatelessWidget {
//   CompanyButton({super.key});
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     bool isEditing = false;
//     double width = MediaQuery.of(context).size.width;
//     List<DynamicModel> companyProfile() {
//       return [
//         DynamicModel(
//             width: Responsive.isMobile(context) ? width : 300,
//             'nameAr',
//             FormType.text,
//             value: '',
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('nameEn', FormType.text,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('headOffice', FormType.text,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('major', FormType.text,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('nationality', FormType.dropdown,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             items: [
//               ItemModel(key: 'saudi', value: 'saudi'),
//               ItemModel(key: 'yemeni', value: 'yemeni'),
//               ItemModel(key: 'egyptian', value: 'egyptian'),
//             ],
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('size', FormType.dropdown,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             items: [
//               ItemModel(key: '', value: '0-10'),
//               ItemModel(key: '', value: '10-20'),
//             ],
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('phone', FormType.phone,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('start Date', FormType.text,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('email', FormType.email,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('website', FormType.text,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('address', FormType.text,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//         DynamicModel('aboutUs', FormType.text,
//             value: '',
//             width: Responsive.isMobile(context) ? width : 300,
//             disabled: isEditing,
//             validators: [
//               DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
//             ]),
//       ];
//     }
//
//     return Flex(
//         direction: Axis.vertical,
//         //mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Center(
//                 child: ToggleBtnWidget(
//               options: const ['Main Information', 'Gallery'],
//             )),
//           ),
//
//           SubTitle(
//             title: 'Main Information',
//             titleType: SubTitleType.withIcon,
//             iconButton: IconButton(
//                 onPressed: () {
//                   isEditing = !isEditing;
//                   context.read<DynamicFormCubit>().replaceAll(
//                       companyProfile());
//                 },
//                 icon: const Icon(
//                   Icons.edit_road,
//                   color: primaryColor,
//                 )),
//           ),
//           BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
//               builder: (context, state) {
//             if (state.selectedTab == 0) {
//               context.read<ToggleBtnCubit>().changeTab(0);
//
//               return DynamicFormWidget(
//                 // key: const Key('companyProfile'),
//                 dynamicFormsList: companyProfile(),
//                 formKey: _formKey,
//                 useResponsiveUi: true,
//               );
//             } else
//               context.read<ToggleBtnCubit>().changeTab(1);
//               return SizedBox();
//           })
//         ],);
//   }
// }
// /*Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: ElevatedButton(
//                   onPressed: ([int value = 0]) {
//                     context.read<ToggleBtnCubit>().changeTab(value);
//                   },
//                   statesController: WidgetStatesController(),
//                   style: ButtonStyle(
//                       padding:
//                           const WidgetStatePropertyAll(EdgeInsets.symmetric(
//                         horizontal: 45,
//                       )),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18.0),
//                       ))),
//                   child: const Text('Main Information')),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: OutlinedButton(
//                   onPressed: ([int value = 1]) {
//                     context.read<ToggleBtnCubit>().changeTab(value);
//                   },
//                   style: ButtonStyle(
//                       padding:
//                           const WidgetStatePropertyAll(EdgeInsets.symmetric(
//                         horizontal: 55,
//                       )),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18.0),
//                       ))),
//                   child: const Text('Gallery')),
//             ),*/
// // IconButton(
// //     onPressed: () {},
// //     padding: const EdgeInsets.symmetric(horizontal: 80),
// //     icon: const Icon(
// //       Icons.edit_road,
// //       color: primaryColor,
// //     )),
// // Container(
// //     padding: const EdgeInsets.symmetric(horizontal: 80),
// //     child: const Text(
// //       "Main Information",
// //       style: TextStyle(fontWeight: FontWeight.bold),
// //     )),
// //  const SizedBox(
// //   width: 10,
// // ),
// //
//
// // IconButton(
// //     onPressed: () {},
// //     padding: const EdgeInsets.symmetric(horizontal: 80),
// //     icon: const Icon(
// //       Icons.edit_road,
// //       color: primaryColor,
// //     )),
// // Container(
// //     padding: const EdgeInsets.symmetric(horizontal: 80),
// //     child: const Text(
// //       "Main Information",
// //       style: TextStyle(fontWeight: FontWeight.bold),
// //     )),
// //  const SizedBox(
// //   width: 10,
// // ),
