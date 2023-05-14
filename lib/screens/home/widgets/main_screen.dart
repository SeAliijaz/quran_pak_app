import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_pak_app/app_routes.dart';
import 'package:quran_pak_app/configs/app.dart';
import 'package:quran_pak_app/configs/space.dart';
import 'package:quran_pak_app/providers/app_provider.dart';
import 'package:quran_pak_app/screens/home/widgets/bottom_ayah.dart';
import 'package:quran_pak_app/widgets/app/app_name.dart';
import 'package:quran_pak_app/widgets/button/app_button.dart';
import 'package:quran_pak_app/widgets/calligraphy.dart';
import 'package:quran_pak_app/widgets/quran_rail.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      color: appProvider.isDark ? Colors.grey[850] : Colors.white,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const AppName(),
            const Calligraphy(),
            const QuranRail(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Space.y1!,
                  AppButton(
                    title: 'Surah Index',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.surah),
                  ),
                  Space.y1!,
                  AppButton(
                    title: 'Juzz Index',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.juz),
                  ),
                  Space.y1!,
                  AppButton(
                    title: 'Bookmarks',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.bookmarks),
                  ),
                ],
              ),
            ),
            const AyahBottom(),
          ],
        ),
      ),
    );
  }
}
