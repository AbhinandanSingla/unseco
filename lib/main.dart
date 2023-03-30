import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unseco/services/dataProvider.dart';
import 'package:unseco/pages/HomePage.dart';
import 'package:unseco/services/LocationProvider.dart';
import 'package:unseco/services/localProvider.dart';

import 'local/locals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        ChangeNotifierProvider<LocationProvider>(
          create: (context) => LocationProvider(),
        ),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, provider, snapshot) => MaterialApp(
          locale: provider.locale,
          title: 'Farma Help',
          debugShowCheckedModeBanner: false,
          supportedLocales: L10n.all,
          localizationsDelegates: const [
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
