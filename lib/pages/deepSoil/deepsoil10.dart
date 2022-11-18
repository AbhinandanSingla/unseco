import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:unseco/dataProvider.dart';

import 'deepSoil20.dart';

class DeepSoilMoisture10 extends StatefulWidget {
  @override
  State<DeepSoilMoisture10> createState() => _DeepSoilMoisture10State();
}

class _DeepSoilMoisture10State extends State<DeepSoilMoisture10> {
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
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(),
          child: Column(children: [
            Text('Select Top Soil Image ',
                style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            SizedBox(
              height: 30,
            ),
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
                          "Upload the top"
                          "\n level of soil",
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
              height: 30,
            ),
            selectedImage == ''
                ? Image.asset('assets/images/documentupload.png')
                : Container(height: 250, child: Image.asset(selectedImage)),
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
                    'Use Camera',
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
                    dataProvider.addPicture(value, 'top');
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
                      Text("Select the image from Gallery",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff0047FF))),
                      Text('png, jpg',
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => DeepSoilMoisture20()));
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Color(0xffFFA030),
                    borderRadius: BorderRadius.circular(15)),
                child: Text('Next',
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
