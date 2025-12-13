import 'package:flutter/material.dart';
import 'package:flutter_lab2_222006/models/meal.dart';
import 'package:flutter_lab2_222006/screens/MealDetailScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteMealScreen
 extends StatelessWidget {
  final List<Meal>favoriteMeals;
  const FavoriteMealScreen
  ({super.key,
  required this.favoriteMeals
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Recepies',
          style: GoogleFonts.dancingScript(
            fontSize: 32,
            fontWeight:FontWeight.bold

          ),
        )
      ),
      body: favoriteMeals.isEmpty?
      Center(
        child: Text('Add your favorite recipe',
        textAlign:TextAlign.center,
        style:GoogleFonts.merienda(fontSize: 18)),
      ):
      
      ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (context,index)
      {
        final meal=favoriteMeals[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              meal.thumbnail,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            )
          ),
          title: Text(meal.name,
          style:GoogleFonts.merienda(
            fontSize: 16,
            fontWeight: FontWeight.bold
          )),
          onTap:() {
            Navigator.push(context, MaterialPageRoute(builder:(_) =>Mealdetailscreen(meal: meal) ,));
          },

        );
      })
    );
  }
}