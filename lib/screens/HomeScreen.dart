import 'package:flutter/material.dart';
import 'package:flutter_lab2_222006/models/category.dart';
import 'package:flutter_lab2_222006/screens/CategoryDetailsScreen.dart';
import 'package:flutter_lab2_222006/screens/MealDetailScreen.dart';
import 'package:flutter_lab2_222006/services/meal_api_service.dart';
import 'package:flutter_lab2_222006/widgets/appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class TheMeal extends StatefulWidget {
  const TheMeal({super.key});

  @override
  State<TheMeal> createState() => _TheMealState();
}
class _TheMealState extends State<TheMeal> {
  Future<void> _openRandomMeal() async {
  try {
    final data = await _apiService.fetchRandomMeal();
    if (data == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Mealdetailscreen(meal: data),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to load random recipe")),
    );
  }
}

  final MealApiService _apiService=MealApiService();
  final TextEditingController _searchController= TextEditingController();
  List<MealCategory>_categories=[];
  List<MealCategory>_filteredCategories=[];
  bool _isLoading=true;
  String?_error;
  @override
  void initState()
  {
    super.initState();
    _loadCategories();
    _searchController.addListener((){
      _filterCategories(_searchController.text);
    });

  }
  Future<void> _loadCategories()async{
    setState(() {
      _isLoading=true;
      _error=null;
    });
    try{
      final data=await _apiService.fetchCategories();
      setState(() {
        _categories=data;
        _filteredCategories=data;
      });
    }
    catch(e){
      setState(() {
        _error=e.toString();
      });

    } finally{
      setState(() {
        _isLoading=false;
      });
    }
  }
    void _filterCategories(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredCategories = _categories;
      });
      return;
    }

    final lowerQuery = query.toLowerCase();

    setState(() {
      _filteredCategories = _categories.where((cat) {
        return cat.name.toLowerCase().contains(lowerQuery);
      }).toList();
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
                  colors: [Colors.black45,Colors.black12]
                )
              ),
            ),
             title: Text(
              'Meal Categories',
              
             style: GoogleFonts.dancingScript
             (fontSize: 45,
             fontWeight: FontWeight.bold,
             color: Color(0xFF4D0013)
             ), 
             ),
             actions:[ IconButton(onPressed: _openRandomMeal, icon: Icon(Icons.fastfood_outlined))]
          ),
        ),
      ),
      
      body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search category',
                prefixIcon:Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                filled: true,
                fillColor: Colors.white
              ),
            ),
          ),
    
      
      Expanded(
        child: ListView.builder(
          itemCount: _filteredCategories.length, 
          itemBuilder: (context,index){
            final category=_filteredCategories[index];
        
            return InkWell(
              onTap: ()
              {
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>CategoryDetailsScreen(category:category)));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [
                    Color(0xFF800020),
                    Colors.black45, 
                  ],
                  begin: Alignment.topLeft,
                  end:Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha:0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    )
                  ],
                ),
              
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape:BoxShape.circle,
                          
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 8,
                              offset: const Offset(0, 1)
                            )
                          ]
                        ),
                        padding: const EdgeInsets.all(4), 
                          child: ClipOval(
                            child: Image.network(
                            category.thumbnail,
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                             ),
                             ),
                      
                      ),
                    
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(category.name,
                            style: GoogleFonts.libreCaslonDisplay(//oranienbaum
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            ),
                          
                        
                    
                      SizedBox(height: 1),
                      
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(category.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.merienda(
                                fontSize: 14,
                              color:Colors.black,
                              height: 1.4),
                         ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
              
              
                        ),
                      ),
              ),
            );
          }
        ),
      )
        ]
      )
    );
  }
}



