import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_pak_app/configs/app_theme.dart';
import 'package:quran_pak_app/providers/app_provider.dart';

class AboutUsCustomButton extends StatelessWidget {
  final String? text;
  final IconData? iconData;
  final void Function()? onPressed;
  const AboutUsCustomButton({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        height: MediaQuery.of(context).size.height * 0.055,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              AppTheme.c!.accent,
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                iconData,
                size: MediaQuery.of(context).size.height * 0.03,
                color: appProvider.isDark ? Colors.black : Colors.white,
              ),
              Text(
                "  $text",
                style: TextStyle(
                  color: appProvider.isDark ? Colors.black : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
