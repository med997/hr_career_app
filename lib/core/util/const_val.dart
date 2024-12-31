import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';


const String BaseUrl = "https://supabase.weteekapp.com:4433";
const String BaseStorageUrl = "https://supabase.weteekapp.com:4433/storage/v1/object/";
// const String BaseStorageUrl = "https://iijcwjoiodsgprwjztas.supabase.co/storage/v1/object/";
const String GustEmail = "gustUser@weteekapp.com";
const String VersionFor = "YE"; //or SA
const String FcmWebKeyPair = "BPaPxgy_jKqb35xtkHOFbPfD25kCEp3ACdJdLQBA8d4bbg7zVmYbYozAa4CgB-2yvBM1Sr-ZNpGHZleC--W4fUM";
const String AnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNzM0MTIzNjAwLAogICJleHAiOiAxODkxODkwMDAwCn0.4vph19YvMqf9BQ9p7MfuLlHUGtJ9mg0tjM0okasK2Xs';
// const String AnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlpamN3am9pb2RzZ3Byd2p6dGFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM0MjMzOTksImV4cCI6MjAzODk5OTM5OX0.iSr1P_qOOsrpYtSswlD4Je83GZRpAzeaa7TqDB3mzWc';
final navUserItem = <NavigationDestination>[
  NavigationDestination(
    icon: const Icon(Icons.work_outline, color: primaryColor,),
    selectedIcon: const Icon(Icons.work, color: primaryColor),
    label: 'Jobs'.tr(),
  ),
  NavigationDestination(
    icon: const Icon(Icons.bookmark_added_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.bookmark_added, color: primaryColor,),
    label: 'Tender'.tr(),
  ),
  NavigationDestination(
    icon: const Icon(Icons.search_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.search, color: primaryColor,),
    label: 'Search'.tr(),
  ),
  NavigationDestination(
    icon: const Icon(Icons.person_2_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.person_2, color: primaryColor,),
    label: 'Profile'.tr(),
  ),
  NavigationDestination(
    icon: const Icon(Icons.notifications_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.notifications, color: primaryColor,),
    label: 'Notification'.tr(),
  ),
];
final navRailUserItem = <NavigationRailDestination>[
  NavigationRailDestination(
    icon: const Icon(Icons.work_outline, color: primaryColor,),
    selectedIcon: const Icon(Icons.work, color: primaryColor),
    label: const Text('Jobs').tr(),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.bookmark_added_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.bookmark_added, color: primaryColor,),
    label: const Text('Tender').tr(),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.search_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.search, color: primaryColor,),
    label: const Text('Search').tr(),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.person_2_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.person_2, color: primaryColor,),
    label: const Text('Profile').tr(),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.notifications_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.notifications, color: primaryColor,),
    label: const Text('Notification').tr(),
  ),
];
final navUserCompanyItem = <NavigationDestination>[
  NavigationDestination(
    icon: const Icon(Icons.home_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.home, color: primaryColor,),
    label: 'Home'.tr(),
  ),
  NavigationDestination(
    icon: const Icon(Icons.work_outline, color: primaryColor,),
    selectedIcon: const Icon(Icons.work, color: primaryColor),
    label: 'Jobs'.tr(),
  ),
  NavigationDestination(
    icon: const Icon(Icons.bookmark_added_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.bookmark_added, color: primaryColor,),
    label: 'Tender'.tr(),
  ),
  NavigationDestination(
    icon: const Icon(Icons.person_2_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.person_2, color: primaryColor,),
    label: 'Profile'.tr(),
  ),
];
final navRailUserCompanyItem = <NavigationRailDestination>[
  NavigationRailDestination(
    icon: const Icon(Icons.home_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.home, color: primaryColor,),
    label: const Text('Home').tr(),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.work_outline, color: primaryColor,),
    selectedIcon: const Icon(Icons.work, color: primaryColor),
    label: const Text('Jobs').tr(),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.bookmark_added_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.bookmark_added, color: primaryColor,),
    label: const Text('Tender').tr(),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.person_2_outlined, color: primaryColor,),
    selectedIcon: const Icon(Icons.person_2, color: primaryColor,),
    label: const Text('Profile').tr(),
  ),

];
