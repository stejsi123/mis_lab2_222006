import 'package:flutter/material.dart';
import 'package:flutter_lab2_222006/models/category.dart';
import 'package:flutter_lab2_222006/models/meal.dart';
import 'package:flutter_lab2_222006/services/meal_api_service.dart';
import 'package:flutter_lab2_222006/widgets/appbar.dart';
import 'package:flutter_lab2_222006/widgets/meal_grid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_lab2_222006/screens/Favorites.dart';


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
  final Set<String>_favoriteMealIds={};
bool _isFavorite(Meal meal) => _favoriteMealIds.contains(meal.id);
  void _toggleFavorite(Meal meal) {
    setState(() {
      if (_favoriteMealIds.contains(meal.id)) {
        _favoriteMealIds.remove(meal.id);
      } else {
        _favoriteMealIds.add(meal.id);
      }
    });
  }
    List<Meal> get _favoriteMeals =>
      _meals.where((m) => _favoriteMealIds.contains(m.id)).toList();


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
             actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(_) =>FavoriteMealScreen(favoriteMeals: _favoriteMeals),));
              }, icon:Icon(Icons.favorite))
             ],
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
            GridViewWidget(filteredMeals: _filteredMeals,
            onToggleFavorite: _toggleFavorite,
            isFavorite:_isFavorite),
              
        ],
            
      ),
    
 
      


    );
  }
}

