import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_pak_app/configs/app_typography_ext.dart';
import 'package:quran_pak_app/screens/about_us/widgets/about_us_custom_button.dart';
import 'package:quran_pak_app/widgets/app/app_version.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../configs/app.dart';
import '../../configs/app_theme.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../utils/assets.dart';
import '../../utils/links.dart';
import '../../widgets/app/title.dart';
import '../../widgets/button/app_back_button.dart';

class AboutUsAppScreen extends StatelessWidget {
  const AboutUsAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: const <Widget>[
            AppBackButton(),
            CustomTitle(title: 'About US'),
            ShareInfo()
          ],
        ),
      ),
    );
  }
}

class ShareInfo extends StatelessWidget {
  const ShareInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
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
              style: Theme.of(context).textTheme.caption),
          SizedBox(height: height * 0.05),
          AboutUsCustomButton(
            iconData: FontAwesomeIcons.github,
            text: 'GitHub Repo',
            onPressed: () =>
                launch("https://github.com/SeAliijaz/Quran-Pak-App"),
          ),
          SizedBox(height: height * 0.02),
          AboutUsContainer(
            guideNo: 1,
            title: "Developer's Info",
            guideDescription:
                "Name: ${Links.dev['name']} \nEmail: ${Links.dev['email']} \nGitHub: ${Links.dev['github']}",
          ),
          SizedBox(height: height * 0.02),
          Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          const AppVersion(),
          Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class AboutUsContainer extends StatelessWidget {
  final String title;
  final String? guideDescription;
  final int guideNo;

  const AboutUsContainer(
      {Key? key,
      required this.guideNo,
      required this.title,
      required this.guideDescription})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Space.all(),
      child: Column(
        children: <Widget>[
          Text(
            "\n$guideNo. $title",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Space.y1!,
          Text(
            guideDescription!,
            textAlign: TextAlign.center,
            style: AppText.b1!.cl(AppTheme.c!.text!),
          ),
        ],
      ),
    );
  }
}
