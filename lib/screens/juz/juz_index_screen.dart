import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:quran_pak_app/animations/bottom_animation.dart';
import 'package:quran_pak_app/configs/app.dart';
import 'package:quran_pak_app/configs/app_dimensions.dart';
import 'package:quran_pak_app/configs/app_theme.dart';
import 'package:quran_pak_app/configs/app_typography.dart';
import 'package:quran_pak_app/configs/space.dart';
import 'package:quran_pak_app/cubits/juz/cubit.dart';
import 'package:quran_pak_app/providers/app_provider.dart';
import 'package:quran_pak_app/screens/surah/surah_index_screen.dart';
import 'package:quran_pak_app/utils/assets.dart';
import 'package:quran_pak_app/utils/juz.dart';
import 'package:quran_pak_app/widgets/app/title.dart';
import 'package:quran_pak_app/widgets/button/app_back_button.dart';
import 'package:quran_pak_app/widgets/custom_image.dart';
import 'package:quran_pak_app/widgets/flare.dart';

class JuzIndexScreen extends StatefulWidget {
  const JuzIndexScreen({Key? key}) : super(key: key);

  @override
  State<JuzIndexScreen> createState() => _JuzIndexScreenState();
}

class _JuzIndexScreenState extends State<JuzIndexScreen> {
  int _searchedIndex = -1;
  String _searchedJuzName = '';

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final juzCubit = JuzCubit.cubit(context);

    bool hasSearched = _searchedIndex != -1 && _searchedJuzName.isNotEmpty;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Container(
              height: AppDimensions.normalize(20),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                left: AppDimensions.normalize(5),
                right: AppDimensions.normalize(5),
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _searchedIndex = -1;
                      _searchedJuzName = '';
                    });
                  }
                  if (value.isNotEmpty) {
                    if (value.length <= 2) {
                      setState(() {
                        _searchedIndex = int.parse(value);
                        if (_searchedIndex <= JuzUtils.juzNames.length &&
                            _searchedIndex >= 0) {
                          _searchedJuzName =
                              JuzUtils.juzNames[_searchedIndex - 1];
                        }
                      });
                    }
                  }
                },
                decoration: InputDecoration(
                  contentPadding: Space.h,
                  hintText: 'Search Juz Number here...',
                  hintStyle: AppText.b2!.copyWith(
                    color: AppTheme.c!.textSub2,
                  ),
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: AppTheme.c!.textSub2!,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.c!.textSub2!,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.c!.textSub2!,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.28,
              ),
              child: hasSearched
                  ? GestureDetector(
                      onTap: () async {
                        await juzCubit.fetch(
                          JuzUtils.juzNames.indexOf(_searchedJuzName) + 1,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PageScreen(
                              juz: juzCubit.state.data,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            color: appProvider.isDark
                                ? Colors.grey[850]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: appProvider.isDark
                                  ? Colors.white
                                  : Colors.black38,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _searchedJuzName,
                                style: AppText.h2b,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )

                  ///Showing Juz
                  : GridView.builder(
                      itemCount: JuzUtils.juzNames.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return WidgetAnimator(
                          child: GestureDetector(
                            onTap: () async {
                              await juzCubit.fetch(index + 1);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PageScreen(
                                    juz: juzCubit.state.data,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appProvider.isDark
                                      ? Colors.grey[850]
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                    color: appProvider.isDark
                                        ? Colors.white
                                        : Colors.black38,
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      JuzUtils.juzNames[index],
                                      style: AppText.b1b,
                                      textAlign: TextAlign.center,
                                    ),
                                    Space.y!,
                                    Text(
                                      '${index + 1}',
                                      style: AppText.b2b,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            ///Image And App Name And Backbutton
            const AppBackButton(),
            CustomImage(
              opacity: 0.3,
              height: AppDimensions.normalize(60),
              imagePath: StaticAssets.quranRail,
            ),
            const CustomTitle(
              title: "Juzz Index",
            ),

            ///Flare Setting
            if (appProvider.isDark) ...[
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(width, -height),
                bottom: -50,
                flareDuration: const Duration(seconds: 17),
                left: 100,
                height: 60,
                width: 60,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(width, -height),
                bottom: -50,
                flareDuration: const Duration(seconds: 12),
                left: 10,
                height: 25,
                width: 25,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(width, -height),
                bottom: -40,
                left: -100,
                flareDuration: const Duration(seconds: 18),
                height: 50,
                width: 50,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(width, -height),
                bottom: -50,
                left: -80,
                flareDuration: const Duration(seconds: 15),
                height: 50,
                width: 50,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(width, -height),
                bottom: -20,
                left: -120,
                flareDuration: const Duration(seconds: 12),
                height: 40,
                width: 40,
              ),
            ],
          ],
        )),
      ),
    );
  }
}
