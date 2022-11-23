import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:unseco/dataProvider.dart';
import 'package:unseco/pages/resultScreen.dart';

class SingleImage extends StatefulWidget {
  @override
  State<SingleImage> createState() => _DeepSoilMoisture10State();
}

class _DeepSoilMoisture10State extends State<SingleImage> {
  final ImagePicker _picker = ImagePicker();
  String selectedImage = '';

  _upload(String file) async {
    String fileName = file.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file,
        filename: fileName,
      ),
    });

    Dio dio = Dio();
    var response = await dio.post(
        "https://technocratss.eastus.cloudapp.azure.com/predict",
        data: data,
        queryParameters: {'soil_type': "black"});
    return response;
  }

  @override
  void initState() {
    Dio dio = Dio();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff06B1BC),
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.selectTop,
              style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          decoration: BoxDecoration(),
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Container(
                height: 100,
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
                        AppLocalizations.of(context)!.selectTop,
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
                ? Image.asset('assets/images/documentupload.png')
                : Container(
                    height: 250, child: Image.file(File(selectedImage))),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                _picker
                    .pickImage(
                        source: ImageSource.camera,
                        preferredCameraDevice: CameraDevice.rear,
                        maxHeight: 600,
                        maxWidth: 600)
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
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _picker.pickImage(source: ImageSource.gallery).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedImage = value.path;
                    });
                  }
                });
              },
              child: Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.image_search_sharp,
                    color: Color(0xff0047FF),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.useGallery,
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff0047FF))),
                      Text('jpg',
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff0047FF)))
                    ],
                  )
                ]),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                if (selectedImage != '') {
                  _upload(selectedImage).then((v) {
                    print(v);
                    return Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ResultScreen(
                              percentage: v.data["moisture"],
                            )));
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
                child: Text(AppLocalizations.of(context)!.startAnal,
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
