import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/const_val.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/curd_profile_cubit.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/avatar_network.dart';
import '../bloc/profile_cubit.dart';

class HeaderProfileWidget extends StatelessWidget {
  const HeaderProfileWidget({
    required this.withBox,
    super.key,
    required this.avatar,
    this.uuid,
    this.editingAvatar = false,
    required this.desc,
    required this.fullName,
  });

  final String avatar;
  final String desc;
  final String fullName;
  final bool withBox;
  final bool editingAvatar;
  final String? uuid;

  void pickImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      print(result.files.first.name);

      final File file = File(result.files.first.path.toString());
      // pickedFileBytes = await file.readAsBytes();
     context.read<CurdProfileCubit>().uploadImageProfile(file,uuid!);

    } else {
      print("No file selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        BlocBuilder<CurdProfileCubit, CurdProfileState>(
                  builder: (context, state) {
        if(state is LoadingCurdProfileState){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoadingWidget(width: 2,progressColor: primaryColor,),
          );
        }else if(state is MessageCurdProfileState){
          String imageUrl =state.profile!.avatarUrl!=null? '$BaseStorageUrl${state.profile!.avatarUrl}':'';
          return AvatarNetwork(imgUrl:imageUrl, withBorder: false, withEditBtn:editingAvatar ,
          editClicked: ()=> pickImage(context),);
        }
        String imageUrl =avatar.isNotEmpty? '$BaseStorageUrl$avatar':'';
        return AvatarNetwork(imgUrl: imageUrl, withBorder: false , withEditBtn: editingAvatar,
          editClicked: ()=> pickImage(context),);
                  },
                ),
        const SizedBox(
          height: 2,
        ),
        Text(
          fullName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          desc,
          style: const TextStyle(color: Colors.grey),
        ),
        // if (withBox == true)
          // Container(
          //   height: 60,
          //   margin: EdgeInsets.symmetric(
          //       vertical: 12,
          //       horizontal: Responsive.isMobile(context) ? 32 : 65),
          //   decoration: BoxDecoration(
          //       border: Border.all(
          //           color: Colors.blueGrey.withOpacity(0.5), width: 0.5),
          //       borderRadius: BorderRadius.circular(12),
          //       color: Colors.white),
          //   child: const Flex(
          //     direction: Axis.horizontal,
          //     children: [
          //       Flexible(
          //         flex: 1,
          //         fit: FlexFit.tight,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               '27',
          //               style: TextStyle(fontWeight: FontWeight.bold),
          //             ),
          //             Text('applied')
          //           ],
          //         ),
          //       ),
          //       VerticalDivider(),
          //       Flexible(
          //         flex: 1,
          //         fit: FlexFit.tight,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               '19',
          //               style: TextStyle(fontWeight: FontWeight.bold),
          //             ),
          //             Text('viewed')
          //           ],
          //         ),
          //       ),
          //       VerticalDivider(),
          //       Flexible(
          //         flex: 1,
          //         fit: FlexFit.tight,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               '14',
          //               style: TextStyle(fontWeight: FontWeight.bold),
          //             ),
          //             Text('interview')
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        // else
        //   const SizedBox(),
      ],
    );
  }
}
