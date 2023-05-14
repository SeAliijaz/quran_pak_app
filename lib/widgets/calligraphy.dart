import 'package:flutter/material.dart';
import 'package:quran_pak_app/configs/app_dimensions.dart';
import 'package:quran_pak_app/utils/assets.dart';

class Calligraphy extends StatelessWidget {
  const Calligraphy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
      right: width * 0.01,
      top: height * 0.045,
      child: Image.asset(
        StaticAssets.gradLogo,
        height: AppDimensions.normalize(75),
      ),
    );
  }
}
