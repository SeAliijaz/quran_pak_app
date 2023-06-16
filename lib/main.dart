import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:quran_pak_app/app_routes.dart';
import 'package:quran_pak_app/cubits/bookmarks/cubit.dart';
import 'package:quran_pak_app/cubits/chapter/cubit.dart';
import 'package:quran_pak_app/cubits/juz/cubit.dart';
import 'package:quran_pak_app/models/ayah/ayah.dart';
import 'package:quran_pak_app/models/chapter/chapter.dart';
import 'package:quran_pak_app/models/juz/juz.dart';
import 'package:quran_pak_app/providers/app_provider.dart';
import 'package:quran_pak_app/providers/onboarding_provider.dart';
import 'package:quran_pak_app/screens/about_us/about_us.dart';
import 'package:quran_pak_app/screens/bookmarks/bookmarks_screen.dart';
import 'package:quran_pak_app/screens/home/home_screen.dart';
import 'package:quran_pak_app/screens/juz/juz_index_screen.dart';
import 'package:quran_pak_app/screens/onboarding/onboarding.dart';
import 'package:quran_pak_app/screens/splash/splash.dart';
import 'package:quran_pak_app/screens/surah/surah_index_screen.dart';
import 'package:url_strategy/url_strategy.dart';

import 'configs/core_theme.dart' as theme;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  /// hive
  await Hive.initFlutter();

  Hive.registerAdapter<Juz>(JuzAdapter());
  Hive.registerAdapter<Ayah>(AyahAdapter());
  Hive.registerAdapter<Chapter>(ChapterAdapter());

  await Hive.openBox('app');
  await Hive.openBox('data');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ///Multiple Providers
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => JuzCubit()),
        BlocProvider(create: (_) => ChapterCubit()),
        BlocProvider(create: (_) => BookmarkCubit()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: ((context, value, child) {
          /*
          A constant that is true if the application was compiled in release mode.
          More specifically, this is a constant that is true if the application was compiled in Dart with the '-Ddart.vm.product=true' flag.
          Since this is a const value, it can be used to indicate to the compiler that a particular block of code will not be executed in release mode, and hence can be removed.
          Generally it is better to use [kDebugMode] or assert to gate code, since using [kReleaseMode] will introduce differences between release and profile builds, which makes performance testing less representative.
          */
          return kReleaseMode
              ? MaterialApp(
                  title: 'The Holy Qur\'an',
                  debugShowCheckedModeBanner: false,
                  theme: theme.themeLight,
                  darkTheme: theme.themeDark,
                  themeMode: value.themeMode,
                  home: Builder(
                    builder: (context) => HomeScreen(
                      maxSlide: MediaQuery.of(context).size.width * 0.835,
                    ),
                  ),
                  initialRoute: AppRoutes.splash,
                  routes: <String, WidgetBuilder>{
                    AppRoutes.juz: (context) => const JuzIndexScreen(),
                    AppRoutes.splash: (context) => const SplashScreen(),
                    AppRoutes.surah: (context) => const SurahIndexScreen(),
                    AppRoutes.aboutUs: (context) => AboutUsScreen(),
                    AppRoutes.bookmarks: (context) => const BookmarksScreen(),
                    AppRoutes.onboarding: (context) => const OnboardingScreen(),
                    AppRoutes.home: (context) => HomeScreen(
                          maxSlide: MediaQuery.of(context).size.width * 0.835,
                        ),
                  },
                )
              /*
              A constant that is true if the application was compiled in debug mode.
              More specifically, this is a constant that is true if the application was not compiled with '-Ddart.vm.product=true' and '-Ddart.vm.profile=true'.
              Since this is a const value, it can be used to indicate to the compiler that a particular block of code will not be executed in debug mode, and hence can be removed.
              An alternative strategy is to use asserts, as in:
              assert(() {
              // ...debug-only code here...
              return true;
              }());
              */

              /// --->>> DEBUG MODE RESULT <<<--- \\\
              : Text(
                  "Your Application is in Debug Mode",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                );
        }),
      ),
    );
  }
}
