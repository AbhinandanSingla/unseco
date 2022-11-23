import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:unseco/pages/MainPage.dart';

class ResultScreen extends StatelessWidget {
  final String percentage;
  const ResultScreen(
      {super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.title,
              style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => MyHomePage()),
                    (route) => false);
              },
            )),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(right: 30, left: 30),
            child: Column(children: [
              SizedBox(height: 20),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 20.0,
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                percent: double.parse(percentage) / 100,
                backgroundColor: Color(0xffFF0000).withOpacity(0.25),
                progressColor: Color(0xff00E0FF),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/icons/drop.png'),
                    new Text(
                      '${double.parse(percentage).toStringAsFixed(0)}%',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                  ],
                ),
                footer: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: new Text(
                    AppLocalizations.of(context)!.soilType('Red'),
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('List of growable Plant ',
                  style: GoogleFonts.inter(
                      fontSize: 30, fontWeight: FontWeight.w500)),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20, right: 10),
                width: size.width,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    )),
                child: Row(children: [
                  Text(
                    "Search the plant here",
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
              SizedBox(height: 40),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (ctx, index) => Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffFFA030)),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(children: [
                          Row(
                            children: [
                              Image.asset(
                                  "assets/images/crops/Rectangle 19.png"),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rice",
                                      style: GoogleFonts.inter(fontSize: 20)),
                                  SizedBox(height: 10),
                                  Text("Level Needed: 80%")
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: size.width,
                            height: 2,
                            decoration: BoxDecoration(color: Color(0xff06B1BC)),
                          ),
                          ListTile(
                            title: Text("As per Moisture Level"),
                            trailing: Image.asset(
                                'assets/images/icons/shieldtick.png'),
                          ),
                          ListTile(
                            title: Text("+ Weather Report"),
                            trailing:
                                Image.asset('assets/images/icons/close.png'),
                          )
                        ]),
                      ))
            ]),
          )),
        ));
  }
}
