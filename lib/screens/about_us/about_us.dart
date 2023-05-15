import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quran_pak_app/configs/app.dart';
import 'package:quran_pak_app/screens/about_us/widgets/about_us_button.dart';
import 'package:quran_pak_app/utils/assets.dart';
import 'package:quran_pak_app/widgets/app/app_version.dart';
import 'package:quran_pak_app/widgets/app/title.dart';
import 'package:quran_pak_app/widgets/button/app_back_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    App.init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            AppBackButton(),
            CustomTitle(title: 'About Us'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * 0.13),
                  Image.asset(StaticAssets.gradLogo, height: height * 0.2),
                  SizedBox(height: height * 0.02),
                  Text(
                      "The Holy Qur'an App is also available as Open Source on GitHub!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(height: height * 0.02),
                  AboutUsCustomButton(
                    iconData: Iconsax.personalcard,
                    text: 'LinkedIn Profile',
                    onPressed: () => launch(linkedIn),
                  ),
                  AboutUsCustomButton(
                    iconData: Iconsax.code,
                    text: 'GitHub Repo',
                    onPressed: () => launch(repositoryUrl),
                  ),
                  SizedBox(height: height * 0.02),
                  const AppVersion()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String linkedIn = "https://www.linkedin.com/in/muhammad-ali-23790821a/";
  String repositoryUrl = "https://github.com/SeAliijaz/quran_pak_app";
}
