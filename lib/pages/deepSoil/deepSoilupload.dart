import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeepSoilMoistureTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
            color: Color(0xff06B1BC), backgroundBlendMode: BlendMode.darken),
        child: Column(children: [
          Text('Select Top Soil Image '),
          Row(
            children: [
              Image.asset('assets/images/singleSoil.png'),
              Text(
                'Upload the top level of soil',
                overflow: TextOverflow.clip,
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Image.asset('assets/images/documentupload.png'),
          Container(
            child: Row(children: [
              Icon(Icons.camera_alt_outlined),
              Text('Use Camera')
            ]),
          ),
          Container(
            child: Row(children: [
              Icon(Icons.image_search_sharp),
              Row(
                children: [
                  Text("Select the image from Gallery"),
                  Text('png, jpg')
                ],
              )
            ]),
          ),
          Container(
            child: Text('Start Analysis'),
          )
        ]),
      )),
    );
  }
}
