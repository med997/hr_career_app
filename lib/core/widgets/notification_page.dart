import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/notifications_widget.dart';
import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';
import 'package:hr_career_platform/features/notification/domain/entities/notification.dart';
import 'package:hr_career_platform/features/notification/presentation/bloc/notification_cubit.dart';

import '../../features/auth/domain/entities/auth.dart';
import '../strings/failures.dart';
import '../util/responsive.dart';
import 'err_widget.dart';

class NotificationPage extends StatefulWidget {
  final Auth auth;

  NotificationPage({
    super.key,
    required this.auth,
  });

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<NotificationCubit>()
        .getNotificationByUuid(widget.auth.userAuth!.id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => context
            .read<NotificationCubit>()
            .getNotificationByUuid(widget.auth.userAuth!.id),
        child: Column(children: [
          ToggleBtnWidget(
            options: const ['Not read', 'Archived'],
          ),
          BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
            builder: (context, stateToggleBtn) {
              return BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return LoadingWidget();
                  } else if (state is NotificationFetchedState) {
                    final notification = stateToggleBtn.selectedTab == 0
                        ? state.notification
                            .where((ntf) => ntf.isArchive != true)
                            .toList()
                        : state.notification
                            .where((ntf) => ntf.isArchive == true)
                            .toList();
                    return Responsive(
                        mobile: _buildMobileLayout(notification),
                        tablet:
                            _buildTabletDesktopLayout(notification, 2, context),
                        desktop: _buildTabletDesktopLayout(
                            notification, 3, context));
                  } else if (state is NotificationErrorState) {
                    String imgUrl = state.msg == OFFLINE_FAILURE_MESSAGE
                        ? 'assets/imgs/conectErr.png'
                        : 'assets/imgs/ServerErr.png';
                    return ErrWidget(
                        imgUrl: imgUrl,
                        errorText: state.msg,
                        clickedReload: () {
                          context
                              .read<NotificationCubit>()
                              .getNotificationByUuid(widget.auth.userAuth!.id);
                        });
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          ),
        ]),
      ),
    );
  }

  Widget _buildMobileLayout(List<NotificationApp> notifications) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shrinkWrap: true,
        itemCount: notifications.length ?? 0,
        itemBuilder: (context, i) {
          NotificationApp notification = notifications[i];
          DateTime time = DateTime.parse(notification.createdAt);
          return Slidable(
            enabled: !notification.isArchive!,
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    context
                        .read<NotificationCubit>()
                        .updateNotification(notification.id!);
                  },
                  backgroundColor: primaryColor,
                  icon: Icons.archive,
                  label: 'Archive',
                )
              ],
            ),
            child: ListTile(
              shape: const Border(
                  bottom: BorderSide(width: 0.1, color: primaryTransparent)),
              leading: const Icon(
                Icons.notifications,
                color: primaryTransparent,
              ),
              title: Text(
                notification.title,
                style: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.w500),
              ),
              trailing: Text(
                '${time.hour}:${time.minute}',
                style: const TextStyle(color: primaryColor, fontSize: 12),
              ),
              subtitle: Text(notification.body,
                  style: TextStyle(
                    color: primaryColor.withOpacity(0.7),
                  )),
            ),
          );
        });
  }

  Widget _buildTabletDesktopLayout(List<NotificationApp> notifications,
      int columnCount, BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / columnCount - 50;
    if (Responsive.isDesktop(context))
      itemWidth = MediaQuery.of(context).size.width / columnCount - 100;
    return Wrap(children: [
      ...notifications.map((ntf) {
        DateTime time = DateTime.parse(ntf.createdAt);
        return SizedBox(
          width: itemWidth,
          child: ListTile(
            shape: const Border(
                bottom: BorderSide(width: 0.1, color: primaryTransparent)),
            leading: const Icon(
              Icons.notifications,
              color: primaryTransparent,
            ),
            title: Text(
              ntf.title,
              style: const TextStyle(
                  color: primaryColor, fontWeight: FontWeight.w500),
            ),
            trailing: Wrap(
              children: [
                Text(
                  '${time.hour}:${time.minute}',
                  style: const TextStyle(color: primaryColor, fontSize: 12),
                ),
                !ntf.isArchive! ?  IconButton(
                  onPressed: () {
                    context
                                  .read<NotificationCubit>()
                                  .updateNotification(ntf.id!);
                  },
                  icon: Icon(Icons.archive,color: primaryColor,),): SizedBox()
              ],
            ),
            subtitle: Text(ntf.body,
                    style: TextStyle(
                      color: primaryColor.withOpacity(0.7),
                    )),
          ),
        );
      })
    ]);
  }
}
