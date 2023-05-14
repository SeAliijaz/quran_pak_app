import 'package:flutter/material.dart';
import 'package:quran_pak_app/configs/app.dart';
import 'package:quran_pak_app/configs/app_theme.dart';
import 'package:quran_pak_app/configs/app_typography.dart';
import 'package:quran_pak_app/configs/space.dart';

class AyahBottom extends StatelessWidget {
  const AyahBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "\"Indeed, It is We who sent down the Qur'an\nand indeed, We will be its Guardian\"",
            textAlign: TextAlign.center,
            style: AppText.b2!.copyWith(
              color: AppTheme.c!.text,
            ),
          ),
          Space.y!,
          Text(
            "Surah Al-Hijr\n",
            style: AppText.l1!.copyWith(
              color: AppTheme.c!.text,
            ),
          ),
        ],
      ),
    );
  }
}
