import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_pak_app/Routes/app_routes.dart';

class DrawerUtils {
  static const List items = [
    {
      'title': 'Surah Index',
      'icon': Icons.format_list_numbered_outlined,
      'route': AppRoutes.surah,
    },
    {
      'title': 'Juz Index',
      'icon': Icons.list,
      'route': AppRoutes.juz,
    },
    {
      'title': 'Bookmarks',
      'icon': Icons.bookmark_outline,
      'route': AppRoutes.bookmarks,
    },
    {
      'title': 'Help Guide',
      'icon': Icons.help_outline,
      'route': AppRoutes.helpGuide,
    },
    {
      'title': 'Introduction',
      'icon': Icons.info_outline,
      'route': AppRoutes.onboarding,
    },
    {
      'title': 'About Us',
      'icon': FontAwesomeIcons.addressCard,
      'route': AppRoutes.aboutUs,
    },
  ];
}
