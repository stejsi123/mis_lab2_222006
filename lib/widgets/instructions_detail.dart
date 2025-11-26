import 'package:flutter/material.dart';
import 'package:flutter_lab2_222006/models/meal_deatil.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionsCard extends StatelessWidget {
  const InstructionsCard({
    super.key,
    required this.detail,
  });

  final MealDetail detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:  Color(0xFF4D0013),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          detail.instructions,
          style: GoogleFonts.oranienbaum(
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}