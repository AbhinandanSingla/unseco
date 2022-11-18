import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unseco/dataProvider.dart';
import 'package:unseco/pages/MainPage.dart';
import 'package:unseco/services/localProvider.dart';

import 'local/locals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(
          create: (context) => DataProvider(),
        ),
        ChangeNotifierProvider<LocaleProvider>(
          create: (context) => LocaleProvider(),
        ),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, provider, snapshot) => MaterialApp(
          locale: provider.locale,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          supportedLocales: L10n.all,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          home: MyHomePage(),
        ),
      ),
    );
  }
}
