import 'package:flutter/material.dart';
import 'package:flutter_lab2_222006/models/category.dart';
import 'package:flutter_lab2_222006/models/meal.dart';
import 'package:flutter_lab2_222006/screens/MealDetailScreen.dart';
import 'package:flutter_lab2_222006/services/meal_api_service.dart';
import 'package:flutter_lab2_222006/widgets/appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final MealCategory category;
  const CategoryDetailsScreen({super.key, required this.category});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final MealApiService _apiService = MealApiService();
  final TextEditingController _searchController = TextEditingController();

  List<Meal> _meals = [];
  List<Meal> _filteredMeals = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMeals();

    _searchController.addListener(() {
      _filterMeals(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadMeals() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data =
          await _apiService.fetchMealsByCategory(widget.category.name);
      setState(() {
        _meals = data;
        _filteredMeals = data; 
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


  void _filterMeals(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredMeals = _meals;
      });
      return;
    }
    final lower = query.toLowerCase();
    setState(() {
      _filteredMeals = _meals
          .where((meal) => meal.name.toLowerCase().contains(lower))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        
        child: ClipPath(
          clipper: BottomCurveClipper(),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient:LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black54,Colors.black38]
                )
              ),
            ),
             title: Text(
              widget.category.name,
             style: GoogleFonts.dancingScript
             (fontSize: 45,
             fontWeight: FontWeight.bold
             ),
             ),
          ),
        ),
      ),
      body:
      Column(
        children: [
          Padding(padding: EdgeInsets.all(12.0)),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search meals...',
              prefixIcon: Icon(Icons.search),
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(24)
              )
            ),
          ),
          SizedBox(height:10),
            Expanded(
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
            ),
              
        ],
            
      ),
    
 
      


    );
  }
}

