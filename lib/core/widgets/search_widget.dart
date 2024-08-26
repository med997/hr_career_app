import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/custom_drop_down_menu.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';

import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';

class SearchWidget extends StatelessWidget {
  final String? nationalities;
  final String? category;
  final int? companyId;
  final double spacer = 4.0;
  late double screenWidth;

  SearchWidget(
      {super.key, this.nationalities, this.category, this.companyId,});
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Responsive(
        mobile: _mobileWidgetBuilder(),
        tablet: _desktopWidgetBuilder(),
        desktop: _desktopWidgetBuilder());
  }

  Widget _mobileWidgetBuilder() {
    return BlocBuilder<JobCubit, JobState>(
  builder: (context, state) {
    if(state is JobLoadingState){
      return LoadingWidget();
    }
    else if(state is JobFetchedState) {
        return ExpansionTile(
          childrenPadding: EdgeInsets.all(4),
          title: SizedBox(
            width: 200,
            child: SearchBar(
              onChanged: (value) {

              },
              constraints: BoxConstraints.tight(const Size.fromHeight(35)),
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
              padding: EdgeInsets.all(spacer),
              child: buildCustomDropDownMenu(
                  'Category',
                  [
                    DropdownMenuEntry(value: state.jobs[0].category, label: '${state.jobs[1].category}'),
                    DropdownMenuEntry(value: 2, label: '${state.jobs[2].category}'),
                    DropdownMenuEntry(value: 3, label: '${state.jobs[3].category}'),
                    DropdownMenuEntry(value: 4, label: '${state.jobs[4].category}'),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.all(spacer),
              child: buildCustomDropDownMenu('Company', [
                DropdownMenuEntry(value: state.jobs[0].companyId, label: '${state.jobs[0].company?.nameEn}'),
                DropdownMenuEntry(value: 2, label: '${state.jobs[2].company?.nameEn}'),
                DropdownMenuEntry(value: 3, label: '${state.jobs[3].company?.nameEn}'),
                DropdownMenuEntry(value: 4, label: '${state.jobs[4].company?.nameEn}'),
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(spacer),
              child: buildCustomDropDownMenu('Nationality', [
                DropdownMenuEntry(value: 1, label: '${state.jobs[0].nationalities}'),
                DropdownMenuEntry(value: 2, label: '${state.jobs[2].nationalities}'),
                DropdownMenuEntry(value: 3, label: '${state.jobs[3].nationalities}'),
                DropdownMenuEntry(value: 4, label: '${state.jobs[4].nationalities}'),
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(spacer),
              child: SizedBox(
                  width: 350,
                  height: 35,
                  child: ElevatedButton(onPressed: () {}, child: Text('search'))),
            )
          ],
        );}

    return SizedBox();

  },
);
  }

  Widget _desktopWidgetBuilder() {
    double widthItem = (screenWidth / 5 - 50);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: (spacer * 2),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          SizedBox(
            width: widthItem,
            child: SearchBar(
              constraints: BoxConstraints.tight(const Size.fromHeight(35)),
              elevation: WidgetStatePropertyAll(0.0),
              hintText: 'Search',
              leading: Icon(
                Icons.search,
                color: primaryTransparent,
              ),
            ),
          ),
          buildCustomDropDownMenu(
              'company',
              [
                DropdownMenuEntry(value: 1, label: 'mohammed'),
                DropdownMenuEntry(value: 2, label: 'ibrahem'),
                DropdownMenuEntry(value: 3, label: 'ahmed'),
                DropdownMenuEntry(value: 4, label: 'mohammed'),
              ],
              width: widthItem),
          buildCustomDropDownMenu(
              'company',
              [
                DropdownMenuEntry(value: 1, label: 'mohammed'),
                DropdownMenuEntry(value: 2, label: 'ibrahem'),
                DropdownMenuEntry(value: 3, label: 'ahmed'),
                DropdownMenuEntry(value: 4, label: 'mohammed'),
              ],
              width: widthItem),
          buildCustomDropDownMenu(
              'company',
              [
                DropdownMenuEntry(value: 1, label: 'mohammed'),
                DropdownMenuEntry(value: 2, label: 'ibrahem'),
                DropdownMenuEntry(value: 3, label: 'ahmed'),
                DropdownMenuEntry(value: 4, label: 'mohammed'),
              ],
              width: widthItem),
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              width: widthItem,
              height: 35,
              child: ElevatedButton(onPressed: () {}, child: Text('search'))),
        ],
      ),
    );
  }
}
