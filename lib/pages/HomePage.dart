import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:unseco/pages/MainPage.dart';

import '../contants.dart';
import '../local/locals.dart';
import '../services/LocationProvider.dart';
import '../services/localProvider.dart';
import 'PlantDetectionPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, String> strings = {'location': 'Loading Location...'};

  @override
  void initState() {
    // TODO: implem                ent initState
    super.initState();
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider
        .getLocation(context)
        .then((v) => {strings['location'] = locationProvider.location});
  }

  final translator = GoogleTranslator();

  langTranslator({language}) {
    strings.forEach((key, value) {
      value.translate(to: language.toString()).then((value) {
        setState(() {
          strings.update(key, (v) => value.text);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
      var lang = provider.locale ?? Localizations.localeOf(context);

      return Scaffold(
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(gradient: bgColor),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<LocationProvider>(
                            builder: (ctx, v, snap) => Expanded(
                                  child: Text(strings['location'].toString(),
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.white)),
                                )),
                        SizedBox(width: 30),
                        IconButton(
                          onPressed: () {
                            locationProvider.getLocation(context);
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: size.width - 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        hint: const Text("Select Language"),
                        isExpanded: true,
                        underline: Container(),
                        value: lang,
                        onChanged: (Locale? val) {
                          provider.setLocale(val!);
                          langTranslator(language: val);
                        },
                        items: L10n.all
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: localeProvider
                                      .localeTitle(e.languageCode),
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset("assets/logo/logo.png")),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset("assets/images/logo.png"),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => SoilMoisturePage()))
                      },
                      child: Container(
                        width: size.width - 30,
                        height: btnHeight,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                  "assets/images/HomePage/soilMoisture.png"),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .soilMoistureDetector,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                  overflow: TextOverflow.clip,
                                ),
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => PlantDetectionPage()))
                      },
                      child: Container(
                        width: size.width - 30,
                        height: btnHeight,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                  "assets/images/HomePage/plantDisease.png"),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .plantDiseaseDetector,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                  overflow: TextOverflow.clip,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0,
                )
              ]),
        )),
      );
    });
  }
}
