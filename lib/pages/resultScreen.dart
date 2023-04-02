import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:unseco/pages/MainPage.dart';
import 'package:unseco/services/dataProvider.dart';
import 'package:unseco/services/localProvider.dart';

class ResultScreen extends StatefulWidget {
  final String percentage;

  ResultScreen({super.key, required this.percentage});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List crops = [];
  Map weatherIcon = {
    'sun': 'assets/weatherIcon/sun.png',
    'rain': 'assets/weatherIcon/rain.png',
    'humidity': 'assets/weatherIcon/cloud.png'
  };
  bool loading = true;

  Future getWeather(cropName) async {
    Dio dio = Dio();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.coordinates['lat'];
    dataProvider.coordinates['long'];
    Response data = await dio.get(
        'http://20.204.143.35:5000/predict-future-moisture',
        queryParameters: {
          'moisture': double.parse(widget.percentage).toStringAsFixed(0),
          'soil_type': dataProvider.soilType.split(' ')[0].toLowerCase(),
          'crop_name': cropName.toString().toLowerCase(),
          'lat': dataProvider.coordinates['lat'],
          'lng': dataProvider.coordinates['long']
        });
    print(
        "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print(double.parse(widget.percentage).toStringAsFixed(0));
    print(
      dataProvider.soilType.split(' ')[0].toLowerCase(),
    );
    print(cropName);
    print(
      dataProvider.coordinates['lat'].toString(),
    );
    print(dataProvider.coordinates['long'].toString());
    return data.data;
  }

  getCrops(soilType) async {
    Dio dio = Dio();
    Response d = await dio
        .get('http://20.204.143.35:5000/eligible-crops', queryParameters: {
      'soilMoisture': double.parse(widget.percentage).toStringAsFixed(0),
      'soil_type': soilType.split(' ')[0].toLowerCase(),
    });
    print(d.data);
    return d.data;
  }

  langTranslator({context}) {
    final language =
        Provider.of<LocaleProvider>(context, listen: false).locale ??
            Localizations.localeOf(context);

    for (var element in crops) {
      print(element);
      element.forEach((key, value) {
        value.toString().translate(to: language.toString()).then((value) {
          setState(() {
            element.update(key, (v) => value.text);
          });
        });
      });
    }
    print(crops);
  }

  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<DataProvider>(context, listen: false);
    getCrops(provider.soilType)
        .then((v) => setState(() => {loading = false, crops = v}))
        .then((val) => langTranslator(context: context));
    super.initState();
  }

  var count = 1;
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
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
                    MaterialPageRoute(builder: (ctx) => SoilMoisturePage()),
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
                percent: double.parse(widget.percentage) / 100,
                backgroundColor: Color(0xffFF0000).withOpacity(0.25),
                progressColor: Color(0xff00E0FF),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/icons/drop.png'),
                    new Text(
                      '${double.parse(widget.percentage).toStringAsFixed(0)}%',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                  ],
                ),
                footer: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: new Text(
                    AppLocalizations.of(context)!
                        .soilType(dataProvider.soilType),
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              '${double.parse(widget.percentage).toStringAsFixed(0)}' == '0'
                  ? Container()
                  : Text('List of growable Plant ',
                      style: GoogleFonts.inter(
                          fontSize: 30, fontWeight: FontWeight.w500)),
              SizedBox(height: 20),
              Stack(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: crops.length,
                      itemBuilder: (ctx, index) {
                        getWeather(
                          '${crops[index]['name'].toString().toUpperCase()}',
                        );
                        if (crops.length == 0) {
                          return Container(
                            child: Lottie.asset('assets/lottie/plants.json'),
                          );
                        }
                        return FutureBuilder(
                            future: getWeather(
                                '${crops[index]['name'].toString().toUpperCase()}'),
                            builder: (ctx, snap) {
                              if (snap.data == null) {
                                return Container();
                              }
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading Data .....");
                              }
                              print(snap.data);
                              return Consumer<DataProvider>(
                                  builder: (context, snapshot, v) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10, top: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffFFA030)),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Color(0xffFFA800)),
                                              ),
                                              SizedBox(width: 5),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Color(0xffD1D9DA)),
                                              ),
                                              SizedBox(width: 5),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Color(0xff00BF9A)),
                                              )
                                            ]),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            // Image.asset(
                                            //     "assets/images/crops/Rectangle 19.png"),
                                            SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${crops[index]['name'].toString().toUpperCase()}',
                                                    overflow: TextOverflow.fade,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                SizedBox(height: 10),
                                                Text(
                                                    "Level Needed: ${crops[index]['minmoisture']}/${crops[index]['maxmoisture']}%",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        line(size),
                                        ListTile(
                                          title: Text("As per Moisture Level"),
                                          trailing: Image.asset(
                                              'assets/images/icons/shieldtick.png'),
                                        ),
                                        ListTile(
                                          title: Text("+ Weather Report"),
                                          trailing: Image.asset(
                                              'assets/images/icons/shieldtick.png'),
                                        ),
                                        snapshot.selectedIndex == index
                                            ? Column(
                                                children: [
                                                  Container(
                                                    child: Column(children: [
                                                      line(size),
                                                      SizedBox(
                                                        height: 20,
                                                      )
                                                    ]),
                                                  ),
                                                  Text(
                                                      '5DAY - WEATHER  FORECAST',
                                                      style: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(height: 10),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffD9D9D9),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9)),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children:
                                                              List.generate(
                                                            5,
                                                            (index) {
                                                              DateTime now =
                                                                  new DateTime
                                                                      .now();
                                                              var date = now
                                                                  .add(Duration(
                                                                      days:
                                                                          index))
                                                                  .day
                                                                  .toString();
                                                              if (now.day
                                                                      .toString() ==
                                                                  date) {
                                                                date = 'Today';
                                                              } else {
                                                                date =
                                                                    '${date}Nov';
                                                              }
                                                              return Column(
                                                                children: [
                                                                  Text(date),
                                                                  Image.asset(
                                                                      'assets/weatherIcon/sun.png'),
                                                                  Text(
                                                                      "${snap.data[index]['temp'].toString()}º")
                                                                ],
                                                              );
                                                            },
                                                          ))),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      '5DAY - SoilMoisture FORECAST',
                                                      style: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(height: 15),
                                                  Row(children: [
                                                    Image.asset(
                                                        'assets/images/icons/Vector (2).png'),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        'No irrigation Required',
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                  ]),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(children: [
                                                    Image.asset(
                                                        'assets/images/icons/waterDrop.png'),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text('Irrigation Required',
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                  ]),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                                  0xffD9D9D9)
                                                              .withOpacity(0.8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      padding: EdgeInsets.only(
                                                          top: 20, bottom: 20),
                                                      child: Table(
                                                          children:
                                                              List.generate(5,
                                                                  (index) {
                                                        DateTime now =
                                                            new DateTime.now();
                                                        var date = now
                                                            .add(Duration(
                                                                days: index))
                                                            .day
                                                            .toString();
                                                        if (now.day
                                                                .toString() ==
                                                            date) {
                                                          date = 'Today';
                                                        } else {
                                                          date = '${date}Nov';
                                                        }
                                                        return TableRow(
                                                            children: [
                                                              tableCell(Text(
                                                                  date,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700))),
                                                              tableCell(Image.asset(
                                                                  'assets/weatherIcon/sun.png')),
                                                              tableCell(Text(
                                                                  "${snap.data[index]['moisture'].toString()}%",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700))),
                                                              tableCell(
                                                                  Container(
                                                                width: 100,
                                                                height: 5,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                2),
                                                                        gradient:
                                                                            LinearGradient(
                                                                                colors: [
                                                                              Color(0xff56D66B),
                                                                              Color(0xffCACD2B),
                                                                              Color(0xffFFA800),
                                                                            ])),
                                                              )),
                                                              tableCell(snap.data !=
                                                                          null &&
                                                                      snap.data[
                                                                              index]
                                                                          [
                                                                          'required_irrigation']
                                                                  ? Image.asset(
                                                                      'assets/images/icons/waterDrop.png')
                                                                  : Image.asset(
                                                                      'assets/images/icons/blueTick.png')),
                                                            ]);
                                                      }))),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        GestureDetector(
                                          onTap: () => {
                                            if (snapshot.selectedIndex == index)
                                              {snapshot.setIndex(-1)}
                                            else
                                              {snapshot.setIndex(index)}
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                color: Color(0xffFFA030),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text(
                                                snapshot.selectedIndex == index
                                                    ? "Close"
                                                    : 'Get Weather Report',
                                                style: GoogleFonts.inter(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ]),
                                );
                              });
                            });
                      }),
                  loading
                      ? Container(
                          child: Column(
                          children: [
                            // Lottie.asset('assets/lottie/plants.json',
                            //     height: 80),
                            Text(
                              "Loading Data Please Wait",
                              style: GoogleFonts.inter(fontSize: 20),
                            )
                          ],
                        ))
                      : Container()
                ],
              )
            ]),
          )),
        ));
  }

  SizedBox tableCell(Widget v) {
    return SizedBox(
        height: 30,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [v]));
  }

  Container line(Size size) {
    return Container(
      width: size.width * 0.8,
      height: 2,
      decoration: BoxDecoration(color: Color(0xff06B1BC)),
    );
  }
}
