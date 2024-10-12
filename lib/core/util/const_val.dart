import 'package:flutter/material.dart';

import '../app_theme.dart';


const String BaseUrl = "https://iijcwjoiodsgprwjztas.supabase.co";
const String BaseStorageUrl = "https://iijcwjoiodsgprwjztas.supabase.co/storage/v1/object/";
const String AnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlpamN3am9pb2RzZ3Byd2p6dGFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM0MjMzOTksImV4cCI6MjAzODk5OTM5OX0.iSr1P_qOOsrpYtSswlD4Je83GZRpAzeaa7TqDB3mzWc';
const navUserItem = <NavigationDestination>[
  NavigationDestination(
    icon: Icon(Icons.work_outline, color: primaryColor,),
    selectedIcon: Icon(Icons.work, color: primaryColor),
    label: 'Jobs',
  ),
  NavigationDestination(
    icon: Icon(Icons.bookmark_added_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.bookmark_added, color: primaryColor,),
    label: 'Tender',
  ),
  NavigationDestination(
    icon: Icon(Icons.search_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.search, color: primaryColor,),
    label: 'Search',
  ),
  NavigationDestination(
    icon: Icon(Icons.person_2_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.person_2, color: primaryColor,),
    label: 'Profile',
  ),
  NavigationDestination(
    icon: Icon(Icons.notifications_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.notifications, color: primaryColor,),
    label: 'Notification',
  ),
];
const navRailUserItem = <NavigationRailDestination>[
  NavigationRailDestination(
    icon: Icon(Icons.work_outline, color: primaryColor,),
    selectedIcon: Icon(Icons.work, color: primaryColor),
    label: Text('Jobs'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.bookmark_added_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.bookmark_added, color: primaryColor,),
    label: Text('Tender'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.search_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.search, color: primaryColor,),
    label: Text('Search'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.person_2_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.person_2, color: primaryColor,),
    label: Text('Profile'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.notifications_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.notifications, color: primaryColor,),
    label: Text('Notification'),
  ),
];
const navUserCompanyItem = <NavigationDestination>[
  NavigationDestination(
    icon: Icon(Icons.home_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.home, color: primaryColor,),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(Icons.work_outline, color: primaryColor,),
    selectedIcon: Icon(Icons.work, color: primaryColor),
    label: 'Jobs',
  ),
  NavigationDestination(
    icon: Icon(Icons.bookmark_added_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.bookmark_added, color: primaryColor,),
    label: 'Tender',
  ),
  NavigationDestination(
    icon: Icon(Icons.person_2_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.person_2, color: primaryColor,),
    label: 'Profile',
  ),
];
const navRailUserCompanyItem = <NavigationRailDestination>[
  NavigationRailDestination(
    icon: Icon(Icons.home_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.home, color: primaryColor,),
    label: Text('Home'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.work_outline, color: primaryColor,),
    selectedIcon: Icon(Icons.work, color: primaryColor),
    label: Text('Jobs'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.bookmark_added_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.bookmark_added, color: primaryColor,),
    label: Text('Tender'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.person_2_outlined, color: primaryColor,),
    selectedIcon: Icon(Icons.person_2, color: primaryColor,),
    label: Text('Profile'),
  ),

];
