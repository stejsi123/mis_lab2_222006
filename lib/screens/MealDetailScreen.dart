import 'package:flutter/material.dart';
import 'package:flutter_lab2_222006/models/meal.dart';
import 'package:flutter_lab2_222006/models/meal_deatil.dart';
import 'package:flutter_lab2_222006/services/meal_api_service.dart';
import 'package:flutter_lab2_222006/widgets/ingridients_detail.dart';
import 'package:flutter_lab2_222006/widgets/instructions_detail.dart';
import 'package:google_fonts/google_fonts.dart';


class Mealdetailscreen extends StatefulWidget {
  final Meal meal;
  const Mealdetailscreen({super.key, required this.meal});

  @override
  State<Mealdetailscreen> createState() => _MealdetailscreenState();
}

class _MealdetailscreenState extends State<Mealdetailscreen> {
  final MealApiService _apiService=MealApiService();
  MealDetail?_detail;
  bool _isLoading=true;
  String? _error;
  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final detail = await _apiService.fetchMealDetail(widget.meal.id);
      setState(() {
        _detail = detail;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  if (_error != null || _detail == null) {
    return Scaffold(
      body: Center(child: Text('Failed to load meal details')),
    );
  }
    final detail=_detail!;
    return Scaffold(
      body:
      SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRect(
              child:Image.network(
                widget.meal.thumbnail,
              height: 300,
              width: double.infinity,
              fit:BoxFit.cover
              )
            ),
            Padding(padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                Text(
                  detail.name,
                  style:GoogleFonts.dancingScript(
                    fontSize:37,
                    fontWeight:FontWeight.bold,
                  )
                )
              ]
            )
            ),
            if(detail.youtubeUrl!=null && detail.youtubeUrl!.trim().isNotEmpty)
            Padding(padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Icon(Icons.language,
                size:20,
               ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SelectableText(
                      detail.youtubeUrl!,
                      maxLines: 1,
                    style: const TextStyle(
                        color:Color(0xFF4D0013),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                 Icon(Icons.people, size:20),
                Text(' 2 servings',
                style: GoogleFonts.varela(
                  fontSize: 15,
                  color: Color(0xFF4D0013)
                ),
                ),

                

            ],),
            
            ),
            
            InstructionsCard(detail: detail),

IngerdientsList(),
SizedBox(height: 10),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ...detail.ingredients.map((item){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item,
            style: GoogleFonts.condiment(
              fontSize: 16,
              height: 1.3
            ),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Divider(
                height: 14,
                thickness: 0.8,
                color: Colors.grey.shade300,
              ),
            )
          ],
        ),
      );
    }),
  ],
)



                          
          ],

        )
      )
      
        
      
    );
  }
}

