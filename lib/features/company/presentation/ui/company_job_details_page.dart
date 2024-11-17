import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/job_details_header.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/appliance_cubit.dart';
import 'package:hr_career_platform/features/profile/presentation/widgets/recent_profile.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:universal_html/js.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/cubit/toggle_btn_cubit.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/const_val.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/dyn_form_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/map_icon_button.dart';
import '../../../../core/widgets/square_button_function.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../../../auth/presentation/bloc/login_cubit.dart';
import '../../../general/domain/entities/general.dart';
import '../../../general/presentation/bloc/general_cubit.dart';
import '../../../job/domain/entities/job.dart';
import '../../../job/presentation/bloc/curd_job_cubit.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../profile/domain/entities/profile.dart';
import '../../../profile/presentation/bloc/appliance_cubit.dart';

class CompanyJobDetailsPage extends StatelessWidget {
  final Job job;
  final Profile? profile;

  CompanyJobDetailsPage({super.key, required this.job, this.profile});

  final reviewProfileFormKey = GlobalKey<FormState>();

  bool isEditing = true;

  @override
  Widget build(BuildContext context) {
    context.read<ApplianceCubit>().state;



    return Scaffold(
      body: SafeArea(
        child: Responsive(
                  mobile: _buildMobileWidget(
                    context,
                    isEditing,
                  ),
                  tablet: _buildTabletAndDesktopWidget(
                    context,
                    isEditing,
                  ),
                  desktop: _buildTabletAndDesktopWidget(
                    context,
                    isEditing,
                  ))


      ),
    );
  }

  Widget _getDynFormWidget(BuildContext context, double width) {
    final ParchmentDocument? documentReq = job.jobReqFormated != null
        ? ParchmentDocument.fromJson(jsonDecode(jsonEncode(job.jobReqFormated)))
        : null;
    final ParchmentDocument? documentDesc = job.jobDescFormated != null
        ? ParchmentDocument.fromJson(
            jsonDecode(jsonEncode(job.jobDescFormated)))
        : null;
    General? generals = context.read<GeneralCubit>().general;
    List<ItemModel> nationalityItems = [];
    List<ItemModel> qualificationsItems = [];
    List<ItemModel> genderItems = [];
    List<ItemModel> officeItems = [];
    List<ItemModel> timePartsItems = [];
    List<ItemModel> categoryItems = [];
    List<ItemModel> cityItems = [];
    if (generals != null) {
      nationalityItems =
          generals.nationality.map((e) => ItemModel(key: e, value: e)).toList();
      qualificationsItems = generals.qualifications
          .map((e) => ItemModel(key: e, value: e))
          .toList();
      genderItems =
          generals.gender.map((e) => ItemModel(key: e, value: e)).toList();
      officeItems =
          generals.officeType.map((e) => ItemModel(key: e, value: e)).toList();
      cityItems =
          generals.cities.map((e) => ItemModel(key: e, value: e)).toList();
      categoryItems =
          generals.jobCategory.map((e) => ItemModel(key: e, value: e)).toList();
      timePartsItems =
          generals.timeParts.map((e) => ItemModel(key: e, value: e)).toList();
    }

    final List<DynamicModel> reviewJobForm = [
      DynamicModel('jobTitle', FormType.text,
          key: 'jobTitle',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          controller: TextEditingController(text: job.jobTitle),
          isRequired: true,
          disabled: isEditing),
      DynamicModel('otherApplyLinks', FormType.text,
          key: 'otherApplyLinks',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.otherApplyLinks),
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('jobDesc', FormType.multiline,
          key: 'jobDesc',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controllerFlt: FleatherController(document: documentDesc),
          controller:
              TextEditingController(text: documentDesc!.toPlainText() ?? ''),
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('jobRequirements', FormType.multiline,
          key: 'jobRequirements',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller:
              TextEditingController(text: documentReq!.toPlainText() ?? ''),
          controllerFlt: FleatherController(document: documentReq),
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel(
          'address',
          width: width,
          key: 'address',
          FormType.text,
          controller: TextEditingController(text: job.address),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: isEditing,
          action: _addressActionBtn(context)),
      DynamicModel('office', FormType.dropdown,
          key: 'office',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.office),
          width: width,
          items: officeItems,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('city', FormType.dropdown,
          key: 'city',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.city),
          width: width,
          items: cityItems,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('qualifications', FormType.dropdown,
          key: 'qualifications',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.qualifications),
          width: width,
          items: qualificationsItems,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('nationalities', FormType.dropdown,
          key: 'nationalities',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.nationalities),
          width: width,
          items: nationalityItems,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('gender', FormType.dropdown,
          key: 'gender',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.gender),
          width: width,
          items: genderItems,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('category', FormType.dropdown,
          key: 'category',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.category),
          width: width,
          items: categoryItems,
          disabled: isEditing),
      DynamicModel('timeParts', FormType.dropdown,
          key: 'timeParts',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          items: timePartsItems,
          controller: TextEditingController(text: job.timeParts),
          isRequired: true,
          disabled: isEditing),
    ];

    return DynamicFormWidget(
      key: const Key('jobEditingInf'),
      dynamicFormsList: reviewJobForm,
      formKey: reviewProfileFormKey,
      useResponsiveUi: true,
    );
  }

  _buildMobileWidget(
    BuildContext context,
    isEditing,
  ) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        JobDetailsHeader(
            job: job,
            profileFilledText: CustomChips(chipsTitles: [job.status!.tr()??''],bgColor: primaryColor,),
            profileIcoButton: IconButton(
                iconSize: 18,
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.visibility_off_outlined))),
        Center(
          child: ToggleBtnWidget(
            options: ["main_information_msg".tr(), "appliance_msg".tr()],
          ),
        ),
        Flexible(
          child: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
            builder: (context, state) {
              switch (state.selectedTab) {
                case 0:
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    children: [
                      SubTitle(
                        title: tr("main_information_msg"),
                        titleType: SubTitleType.withIcon,
                        iconButton: IconButton(
                            onPressed: () {
                              isEditing = !isEditing;
                              context
                                  .read<DynamicFormCubit>()
                                  .setDisableFiled(isEditing);
                              context
                                  .read<DisableButtonCubit>()
                                  .disableButton(isEditing);
                            },
                            icon: const Icon(
                              Icons.edit_road,
                              color: primaryColor,
                            )),
                      ),
                      _getDynFormWidget(
                          context, MediaQuery.of(context).size.width),
                      Flex(
                        mainAxisAlignment: MainAxisAlignment.end,
                        direction: Axis.horizontal,
                        children: [
                          BlocBuilder<DisableButtonCubit, bool>(
                            builder: (context, isEditing) {
                              if (isEditing == true) {
                                context
                                    .read<DisableButtonCubit>()
                                    .resetButtonState(isEditing);
                                return MaterialButton(
                                    color: Colors.yellow.shade700,
                                    minWidth: 40,
                                    height: 40,
                                    shape: const CircleBorder(),
                                    onPressed: isEditing
                                        ? () {
                                            var value = context
                                                .read<DynamicFormCubit>()
                                                .getCurrentValue();
                                            final companyId = context
                                                .read<LoginCubit>()
                                                .authenticatedUser!
                                                .userAuth!
                                                .id;
                                            print(
                                                'company_id: $companyId ===> $value');
                                            context
                                                .read<CurdJobCubit>()
                                                .updateJob(value, job);
                                          }
                                        : null,
                                    child:
                                        BlocBuilder<CurdJobCubit, CurdJobState>(
                                      builder: (context, state) {
                                        if (state is LoadingCurdJobState) {
                                          return LoadingWidget(
                                            progressColor: Colors.white,
                                            width: 2,
                                          );
                                        } else {
                                          return const Icon(
                                            Icons.save_outlined,
                                            color: Colors.white,
                                            size: 19,
                                          );
                                        }
                                      },
                                    ));
                              }
                              return SizedBox();
                            },
                          ),
                        ],
                      )
                    ],
                  );

                case 1:
                  context.read<ApplianceCubit>().getAppliance(job.id.toString());
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          squareButton(
                              clr: Colors.green,
                              icn: Icons.file_upload_outlined,
                              iconLabel: tr("export_excel_msg"),
                              onTap: () {}),
                        ],
                      ),
                      const RecentProfile(),
                    ],
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }

  _addressActionBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: MaterialButton(
          disabledColor: Colors.grey.shade600,
          padding: const EdgeInsets.all(4),
          onPressed: () async {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => LocationWidget(),
            ))
                .then((value) {
              context
                  .read<DynamicFormCubit>()
                  .updateValueOnly('address', value[0].toString());
              // print(value[0]);
              // print(value[1]);
              // latLong = value[1].split(",");
              // print(latLong);
            });
          },
          shape: const CircleBorder(),
          color: primaryColor,
          child: const Icon(
            Icons.location_on_outlined,
            color: Colors.white,
            size: 18,
          )),
    );
  }

  _buildTabletAndDesktopWidget(
    BuildContext context,
    isEditing,
  ) {
    double width = 400 /*MediaQuery.of(context).size.width*/;
    context.read<ApplianceCubit>().getAppliance(job.id.toString());

    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            SizedBox(
              width: 400,
              child: JobDetailsHeader(
                  job: job,
                  profileFilledText: FilledButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.blueAccent)),
                    onPressed: () {},
                    child: Text(
                      tr("active_msg"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  profileIcoButton: IconButton(
                      iconSize: 18,
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_off_outlined))),
            ),
            Expanded(
              child: SizedBox(
                width: width,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SubTitle(
                      title: tr("main_information_msg"),
                      titleType: SubTitleType.withIcon,
                      iconButton: IconButton(
                          onPressed: () {
                            isEditing = !isEditing;
                            context
                                .read<DynamicFormCubit>()
                                .setDisableFiled(isEditing);
                            context
                                .read<DisableButtonCubit>()
                                .disableButton(isEditing);
                          },
                          icon: const Icon(
                            Icons.edit_road,
                            color: primaryColor,
                          )),
                    ),
                    _getDynFormWidget(context, 400),
                    Flex(
                      mainAxisAlignment: MainAxisAlignment.end,
                      direction: Axis.horizontal,
                      children: [
                        BlocBuilder<DisableButtonCubit, bool>(
                          builder: (context, isEditing) {
                            if (isEditing == true) {
                              context
                                  .read<DisableButtonCubit>()
                                  .resetButtonState(isEditing);
                              return MaterialButton(
                                  color: Colors.yellow.shade700,
                                  minWidth: 40,
                                  height: 40,
                                  shape: const CircleBorder(),
                                  onPressed: isEditing
                                      ? () {
                                    var value = context
                                        .read<DynamicFormCubit>()
                                        .getCurrentValue();
                                    final companyId = context
                                        .read<LoginCubit>()
                                        .authenticatedUser!
                                        .userAuth!
                                        .id;
                                    print(
                                        'company_id: $companyId ===> $value');
                                    context
                                        .read<CurdJobCubit>()
                                        .updateJob(value, job);
                                  }
                                      : null,
                                  child:
                                  BlocBuilder<CurdJobCubit, CurdJobState>(
                                    builder: (context, state) {
                                      if (state is LoadingCurdJobState) {
                                        return LoadingWidget(
                                          progressColor: Colors.white,
                                          width: 2,
                                        );
                                      } else {
                                        return const Icon(
                                          Icons.save_outlined,
                                          color: Colors.white,
                                          size: 19,
                                        );
                                      }
                                    },
                                  ));
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            children: [
              SubTitle(
                title: tr("appliance_of_job_msg"),
                titleType: SubTitleType.textOnly,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ApplianceCubit, ApplianceState>(
  builder: (context, state) {
    if (state is ApplianceFetchedState) {

      return Wrap(
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          squareButton(
              clr: Colors.green,
              icn: Icons.file_upload_outlined,
              iconLabel: tr("export_excel_msg"),
              onTap: () async {
                await createExcel(state.profile); // Call the async function here
              },
          ),
        ],
      );
    }  else {
      return const SizedBox();
    }
  }

    ),
              const SizedBox(
                height: 12,
              ),

              const RecentProfile(),
            ],
          ),
        )
      ],
    );
  }

 Future<void> createExcel(List<Profile> profiles) async{
   final Workbook workbook = Workbook();
   final Worksheet sheet = workbook.worksheets[0];
   sheet.enableSheetCalculations();


   sheet.getRangeByName('A1:E1').columnWidth = 22;
   sheet.getRangeByName('A1:E1').cellStyle.backColor = '#356899';
   sheet.getRangeByName('A1:E1').cellStyle.fontColor = '#ffffff';
   sheet.getRangeByName('A1:E1').cellStyle.bold = true;
   sheet.getRangeByName('A1:E1').cellStyle.fontSize = 12;





   sheet.getRangeByName('A1').setText('Appliance Name');
   sheet.getRangeByName('B1').setText('Arabic Appliance Name');
   sheet.getRangeByName('C1').setText('Phone');
   sheet.getRangeByName('D1').setText('Appliance Major');
   sheet.getRangeByName('E1').setText('Appliance Current Job');
   sheet.getRangeByName('F1').setText('Resume');
   for (int i = 0; i < profiles.length; i++) {

     final website =profiles[i].resumeUrl!=null?
     '$BaseStorageUrl${profiles[i].resumeUrl}':'';


       sheet.getRangeByIndex(i + 2, 2).setText(profiles[i].fullNameAr);
       sheet.getRangeByIndex(i + 2, 1).setText(profiles[i].fullName);
       sheet.getRangeByIndex(i + 2, 3).setText(profiles[i].phone);
       sheet.getRangeByIndex(i + 2, 4).setText(profiles[i].major);
       sheet.getRangeByIndex(i + 2, 5).setText(profiles[i].currentJob);
       sheet.getRangeByIndex(i + 2, 6).setText(website);

   }



   final List<int> bytes = workbook.saveAsStream();
   workbook.dispose();

   if (kIsWeb) {
     AnchorElement(
         href:
         'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
       ..setAttribute('download', 'applianceReport.xlsx')
       ..click();
   } else {
     final String path = (await getApplicationSupportDirectory()).path;
     final String fileName =
     Platform.isWindows ? '$path\\applianceReport.xlsx' : '$path/applianceReport.xlsx';
     final File file = File(fileName);
     await file.writeAsBytes(bytes, flush: true);
     OpenFile.open(fileName);

  }
}
  // Future<List<ExcelDataRow>> _buildCustomersDataRowsIH() async {
  //   List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
  //
  //   List<Profile> reports_1 = await Future.value(reports);
  //
  //   excelDataRows = reports_1.map<ExcelDataRow>((Profile dataRow) {
  //     return ExcelDataRow(cells: <ExcelDataCell>[
  //       ExcelDataCell(columnHeader: 'Person name', value: dataRow.fullName),
  //       ExcelDataCell(
  //           columnHeader: 'Phone Number', value: dataRow.phone),
  //       ExcelDataCell(
  //           columnHeader: 'Email', value: dataRow.email),
  //       ExcelDataCell(columnHeader: 'Address', value: dataRow.address),
  //       ExcelDataCell(columnHeader: 'Current Job', value: dataRow.currentJob),
  //       ExcelDataCell(columnHeader: 'Major', value: dataRow.major)
  //     ]);
  //   }).toList();
  //
  //   return excelDataRows;
  // }
}
