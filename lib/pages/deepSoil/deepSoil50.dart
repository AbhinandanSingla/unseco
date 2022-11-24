import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../dataProvider.dart';
import '../resultScreen.dart';
import 'deepsoil10.dart';

class DeepSoilMoisture50 extends StatefulWidget {
  @override
  State<DeepSoilMoisture50> createState() => _DeepSoilMoisture10State();
}

class _DeepSoilMoisture10State extends State<DeepSoilMoisture50> {
  final ImagePicker _picker = ImagePicker();
  String selectedImage = '';

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff06B1BC),
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(AppLocalizations.of(context)!.selectSoil("60"),
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(),
          child: Column(children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => DeepSoilMoisture10())),
              child: Container(
                  height: 120,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/singleSoil.png'),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.selectSoil("60"),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          overflow: TextOverflow.clip,
                        ),
                      )
                    ],
                  )),
            ),
            SizedBox(
              height: 25,
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
                    child: Image.asset('assets/images/documentupload.png'))
                : Container(
                    height: 250, child: Image.file(File(selectedImage))),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                _picker
                    .pickImage(
                        source: ImageSource.camera,
                        preferredCameraDevice: CameraDevice.rear)
                    .then((value) {
                  if (value != null) {
                    dataProvider.addPicture(value, 'top');
                    setState(() {
                      selectedImage = value.path;
                    });
                  }
                });
              },
              child: Container(
                width: size.width * 0.6,
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 10, left: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.camera_alt_outlined, color: Colors.white),
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
            SizedBox(height: 15),
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
                width: size.width * 0.6,
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 10, left: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                if (selectedImage != '') {
                  dataProvider.upload(selectedImage).then((v) => {
                        dataProvider.getMoisture('50', v),
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ResultScreen(
                                percentage: dataProvider.calculateAverage().toString())))
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
                child: Text(AppLocalizations.of(context)!.next,
                    style: GoogleFonts.inter(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center),
              ),
            )
          ]),
        )),
      ),
    );
  }
}
