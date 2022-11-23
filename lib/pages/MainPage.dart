import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unseco/pages/deepSoil/deepsoilTop.dart';
import 'package:unseco/pages/singleImageSoil.dart';
import 'package:unseco/services/localProvider.dart';

import '../local/locals.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    _getLocation();
    super.initState();
  }

  void _getLocation() {
    Position position;
    List<Placemark> placemarks;
    _handleLocationPermission().then((value) async => {
          if (value)
            {
              position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high),
              print(
                  '${position.latitude.toString()} ${position.latitude.toString()}'),
              placemarks = await placemarkFromCoordinates(
                  position.latitude, position.longitude),
              setState(() {
                location =
                    '${placemarks[2].street!},${placemarks[2].locality!}';
                print(location[2]);
              })
            }
        });
  }

  String location = "Location";

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _title(String val) {
      switch (val) {
        case 'en':
          return Text(
            'English',
            style: TextStyle(fontSize: 16.0),
          );
        case 'hi':
          return Text(
            'Hindi',
            style: TextStyle(fontSize: 16.0),
          );

        default:
          return Text(
            'English',
            style: TextStyle(fontSize: 16.0),
          );
      }
    }

    Size size = MediaQuery.of(context).size;
    return Consumer<LocaleProvider>(
      builder: (context, provider, snapshot) {
        var lang = provider.locale ?? Localizations.localeOf(context);

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(30),
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xff06B1BC), Color(0xff56D66B)],
                )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(location,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white)),
                        IconButton(
                          onPressed: () {
                            _getLocation();
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: size.width,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: DropdownButton(
                        hint: const Text("Select Language"),
                        isExpanded: true,
                        underline: Container(),
                        value: lang,
                        onChanged: (Locale? val) {
                          provider.setLocale(val!);
                        },
                        items: L10n.all
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: _title(e.languageCode),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalizations.of(context)!.heading,
                      style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => SingleImage()))
                      },
                      child: Container(
                          height: 120,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/soil1.png'),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.singleImageBtn,
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
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => DeepSoilMoistureTop())),
                      child: Container(
                          height: 120,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/soil2.png'),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.deepAnalysis,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                  overflow: TextOverflow.clip,
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                )),
          )),
        );
      },
    );
  }
}
