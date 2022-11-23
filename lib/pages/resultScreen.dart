import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          Text(
            AppLocalizations.of(context)!.title,
            style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 20.0,
            animation: true,
            percent: 0.7,
            backgroundColor: Color(0xffFF0000).withOpacity(0.25),
            progressColor: Color(0xff00E0FF),
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pin_drop_rounded,
                    size: 90, color: Color(0xff00E0FF)),
                new Text(
                  "75%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: new Text(
                AppLocalizations.of(context)!.soilType('Red'),
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('List of growable Plant ',
              style:
                  GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w500)),
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
              itemCount: 4,
              itemBuilder: (ctx, index) => Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffFFA030)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [
                      Row(
                        children: [
                          Image.asset("assets/images/crops/Rectangle 19.png"),
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
                      Container(
                        width: size.width,
                        height: 2,
                        decoration: BoxDecoration(color: Color(0xff06B1BC)),
                      ),
                      ListTile(
                        title: Text("As per Moisture Level"),
                        trailing:
                            Image.asset('assets/images/icons/shieldtick.png'),
                      ),
                      ListTile(
                        title: Text("+ Weather Report"),
                        trailing: Image.asset('assets/images/icons/close.png'),
                      )
                    ]),
                  ))
        ]),
      )),
    ));
  }
}
