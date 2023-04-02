import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unseco/pages/deepSoil/deepsoil10.dart';
import 'package:unseco/pages/singleImageSoil.dart';
import 'package:unseco/services/dataProvider.dart';
import 'package:unseco/services/localProvider.dart';

import '../contants.dart';

class SoilMoisturePage extends StatefulWidget {
  SoilMoisturePage({Key? key}) : super(key: key);

  @override
  State<SoilMoisturePage> createState() => _SoilMoisturePageState();
}

class _SoilMoisturePageState extends State<SoilMoisturePage> {
  List soilType = ['Red Soil', 'Black Soil', 'Alluvial Soil'];
  String selectedSoil = 'Red Soil';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<LocaleProvider>(
      builder: (context, provider, snapshot) {
        var lang = provider.locale ?? Localizations.localeOf(context);
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(gradient: bgColor),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    width: size.width,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => {Navigator.of(context).pop()},
                              icon: Icon(Icons.arrow_back_ios_outlined),
                              color: Colors.white),
                          Text(
                            AppLocalizations.of(context)!.heading,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ]),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 2,
                          ),
                          Consumer<DataProvider>(builder: (context, value, w) {
                            return Container(
                              padding: EdgeInsets.only(left: 20),
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                hint: const Text("Select Soil Type"),
                                isExpanded: true,
                                underline: Container(),
                                value: value.soilType,
                                items: soilType
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  value.setSoilType(val.toString());
                                },
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 60,
                          ),
                          Image.asset('assets/images/logo.png'),
                          const SizedBox(
                            height: 60,
                          ),
                          Column(children: [
                            GestureDetector(
                              onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SingleImage()))
                              },
                              child: Container(
                                  height: btnHeight,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset('assets/images/soil1.png'),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .singleImageBtn,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                          overflow: TextOverflow.clip,
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => DeepSoilMoisture10())),
                              child: Container(
                                  height: btnHeight,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset('assets/images/soil2.png'),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .deepAnalysis,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                          overflow: TextOverflow.clip,
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ]),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      )),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
