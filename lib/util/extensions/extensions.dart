import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextStyler on Text {
  // Theme States
  Text withStyle({double? fontSize}) {
    return Text(
      data ?? '',
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: const Color.fromARGB(221, 92, 92, 92),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text withHeadStyle({double? fontSize}) {
    return Text(
      data ?? "",
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: fontSize ?? 18,
        color: const Color.fromARGB(234, 0, 0, 0),
      ),
    );
  }
}

extension IconStyle on Icon {
  Icon withIconStyle({double? iconSize}) {
    return Icon(
      icon ?? Icons.abc,
      size: iconSize ?? 30,
      color: const Color.fromARGB(221, 33, 33, 33),
    );
  }
}
