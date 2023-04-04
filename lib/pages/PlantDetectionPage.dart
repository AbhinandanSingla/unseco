import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unseco/pages/plantDiseaseDetection/Pepper.dart';
import 'package:unseco/pages/plantDiseaseDetection/Tomato.dart';

import '../contants.dart';

class PlantDetectionPage extends StatelessWidget {
  const PlantDetectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            color: Colors.teal),
                        Text(
                          AppLocalizations.of(context)!.plantDiseaseTitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal),
                        ),
                      ]),
                ),
                SvgPicture.asset("assets/images/HomePage/plantDiseaseMain.svg",
                    height: 250),
                Column(
                  children: [
                    Text(AppLocalizations.of(context)!.cropList,
                        style: GoogleFonts.openSans(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => TomatoDetection())),
                      child: Container(
                        height: btnHeight,
                        decoration: BoxDecoration(
                            color: Color(0xffFFA6A6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Container(
                              height: btnHeight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .tomatoTitle,
                                            style: GoogleFonts.inter(
                                                fontSize: 20)),
                                      ),
                                    ]),
                              ),
                            ),
                            Positioned(
                                top: 20,
                                left: 20,
                                child: Image.asset(
                                    "assets/images/crops/leaf.png")),
                            Positioned(
                                top: -20,
                                right: 0,
                                child: Container(
                                  width: size.width * 0.4,
                                  height: btnHeight + 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          bottomLeft: Radius.circular(100)),
                                      color:
                                          Color(0xffFF5959).withOpacity(0.4)),
                                )),
                            Positioned(
                                top: 30,
                                right: 30,
                                child: Image.asset(
                                    "assets/images/crops/tomato.png"))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => PepperDetection())),
                      child: Container(
                        height: btnHeight,
                        decoration: BoxDecoration(
                            color: Color(0xff9DED89),
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Container(
                              height: btnHeight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .pepperTitle,
                                            style: GoogleFonts.inter(
                                              fontSize: 20,
                                            )),
                                      ),
                                    ]),
                              ),
                            ),
                            Positioned(
                                top: 20,
                                left: 20,
                                child: Image.asset(
                                    "assets/images/crops/leaf.png")),
                            Positioned(
                                top: -20,
                                right: 0,
                                child: Container(
                                  width: size.width * 0.4,
                                  height: btnHeight + 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          bottomLeft: Radius.circular(100)),
                                      color:
                                          Color(0xff53c636).withOpacity(0.4)),
                                )),
                            Positioned(
                                top: 30,
                                right: 4,
                                child: Image.asset(
                                    "assets/images/crops/chili.png"))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ],
            )),
      )),
    );
  }
}
