import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';

Container nextBtn(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
        color: Color(0xffFFA030), borderRadius: BorderRadius.circular(15)),
    child: Text(AppLocalizations.of(context)!.next,
        style: GoogleFonts.inter(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center),
  );
}
