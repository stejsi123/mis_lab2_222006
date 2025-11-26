import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngerdientsList extends StatelessWidget {
  const IngerdientsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
      child: Text('INGREDIENTS',
      style: GoogleFonts.libreCaslonText(
        fontSize: 22,
        fontWeight:FontWeight.bold
      ),),
    );
  }
}

