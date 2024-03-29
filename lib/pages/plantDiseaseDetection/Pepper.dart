import "dart:io";

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:unseco/services/dataProvider.dart';

import '../../services/localProvider.dart';

class PepperDetection extends StatefulWidget {
  @override
  State<PepperDetection> createState() => _PepperDetectionState();
}

class _PepperDetectionState extends State<PepperDetection> {
  final ImagePicker _picker = ImagePicker();
  String selectedImage = '';
  bool plantDisease = false;
  bool response = false;

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
      return Scaffold(
        backgroundColor: Color(0xff06B1BC),
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.transparent,
            title: Text(AppLocalizations.of(context)!.pepperTitle,
                style: GoogleFonts.inter(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            elevation: 0),
        body: SingleChildScrollView(
            child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 15),
                    Container(
                        height: 120,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/images/crops/plantT.jpg'),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.tomatoDesc,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    selectedImage == ''
                        ? GestureDetector(
                            onTap: () => _picker
                                    .pickImage(
                                        source: ImageSource.gallery,
                                        maxWidth: 600,
                                        maxHeight: 600)
                                    .then((value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedImage = value.path;
                                    });
                                  }
                                }),
                            child:
                                Image.asset('assets/images/documentupload.png'))
                        : Container(
                            height: 250,
                            child: Image.file(File(selectedImage))),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        _picker
                            .pickImage(
                                source: ImageSource.camera,
                                preferredCameraDevice: CameraDevice.rear)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              selectedImage = value.path;
                            });
                          }
                        });
                      },
                      child: Container(
                        width: size.width * 0.7,
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 10, left: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined,
                                  color: Colors.white),
                              SizedBox(width: 15),
                              Text(
                                AppLocalizations.of(context)!.useCamera,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black.withOpacity(0.4),
                                          offset: Offset(0, 1),
                                          blurRadius: 3)
                                    ],
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                              )
                            ]),
                        decoration: BoxDecoration(
                            color: Color(0xffFFA030),
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _picker
                            .pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 600,
                                maxHeight: 600)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              selectedImage = value.path;
                            });
                          }
                        });
                      },
                      child: Container(
                        width: size.width * 0.7,
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 10, left: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo, color: Colors.white),
                              SizedBox(width: 15),
                              Text(
                                AppLocalizations.of(context)!.useGallery,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black.withOpacity(0.4),
                                          offset: Offset(0, 1),
                                          blurRadius: 3)
                                    ],
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                              )
                            ]),
                        decoration: BoxDecoration(
                            color: Color(0xffFFA030),
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextButton(
                        onPressed: () {
                          if (selectedImage != '') {
                            var status = '0';
                            dataProvider
                                .uploadDisease(selectedImage, 'tomato')
                                .then((v) => {
                                      print(v['status']),
                                      status = v['status'],
                                      setState(() {
                                        if (status == '1') {
                                          plantDisease = true;
                                        } else {
                                          plantDisease = false;
                                        }
                                        response = true;
                                      })
                                    });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!.err),
                            ));
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color(0xffFFA030),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(AppLocalizations.of(context)!.submitBtn,
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center),
                        ))
                  ]),
            ),
            response
                ? Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        color: Color(0xff000000).withOpacity(0.4)),
                    child: Container(
                      width: size.width - 30,
                      decoration: BoxDecoration(color: Colors.white),
                      child: plantDisease
                          ? Column(
                              children: [
                                Lottie.asset("assets/lottie/disease.json"),
                                Text(
                                    AppLocalizations.of(context)!.plantInfected,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.redAccent)),
                                SizedBox(
                                  height: 30,
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedImage = '';
                                        response = false;
                                      });
                                    },
                                    child: const Text("Continue"))
                              ],
                            )
                          : Column(
                              children: [
                                Lottie.asset("assets/lottie/noDisease.json"),
                                Text(
                                    AppLocalizations.of(context)!
                                        .plantNotInfected,
                                    style: GoogleFonts.inter(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green)),
                                SizedBox(
                                  height: 30,
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedImage = '';
                                        response = false;
                                      });
                                    },
                                    child: Text("Continue"))
                              ],
                            ),
                    ),
                  )
                : Container(),
          ],
        )),
      );
    });
  }
}
