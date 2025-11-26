import 'package:flutter/material.dart';
import 'package:flutter_lab2_222006/models/meal.dart';
import 'package:flutter_lab2_222006/screens/MealDetailScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required List<Meal> filteredMeals,
  }) : _filteredMeals = filteredMeals;

  final List<Meal> _filteredMeals;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
      padding: EdgeInsets.all(12.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, 
      childAspectRatio: 0.9,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8),
      itemCount:_filteredMeals.length,
      itemBuilder:(context,index)
      {
        final meal=_filteredMeals[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>Mealdetailscreen(meal:meal)));
          },
          child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 11,
              child: Image.network(
    meal.thumbnail,
    fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.black.withValues(alpha:2.5),
        ],
      ),
    ),
              ),
            ),
    
            
            Positioned(
              left: 10,
              bottom: 10,
              right: 10,
              child: Text(
    meal.name,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style:GoogleFonts.libreCaslonText(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      shadows: [
        Shadow(
          blurRadius: 4,
          color: Colors.black,
        )
      ],
    ),
              ),
            ),
          ],
        ),
    
      
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
    children: [
      Icon(Icons.slow_motion_video_outlined, size: 17),
      SizedBox(height: 2),
      Text('Cook', style: GoogleFonts.libreCaslonDisplay(fontSize:13, fontWeight: FontWeight.w700)),
    ],
              ),
              Column(
    children: [
      Icon(Icons.favorite_border_outlined, size: 17),
      SizedBox(height: 2),
      Text('Favorite', style: GoogleFonts.libreCaslonDisplay(fontSize: 13, fontWeight: FontWeight.w700)),
    ],
              ),
              Column(
    children: [
      Icon(Icons.library_books_outlined, size: 17),
      SizedBox(height: 2),
      Text('Notes', style: GoogleFonts.libreCaslonDisplay(fontSize: 13,fontWeight: FontWeight.w700)),
    ],
              ),
            ],
          ),
        ),
      ],
    ),
    
       
        );
      }
        ),
    );
  }
}

