import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:soilnutrientanalyzer/repo/crop_repo.dart';
import 'bloc/crop_dropdown_bloc.dart';
import 'generated/l10n.dart';
import 'screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<LanguageCubit>(
        create: (context) => LanguageCubit(
          TranslateRepo.crops,
          TranslateRepo.soliType('English'),
        ),
        child: Home(),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Humidity Analyzer',
      localeResolutionCallback: (Locale locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale.languageCode) {
            CurrentLocale.locale = supportedLocaleLanguage.languageCode;
            return supportedLocaleLanguage;
          }
        }
        CurrentLocale.locale = supportedLocales.first.languageCode;
        return supportedLocales.first;
      },
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

class CurrentLocale {
  static String locale;
}
