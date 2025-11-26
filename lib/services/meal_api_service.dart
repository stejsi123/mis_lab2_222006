import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_deatil.dart';
class MealApiService {
  static const String _baseUrl='https://www.themealdb.com/api/json/v1/1/categories.php';
  Future<List<MealCategory>> fetchCategories() async{
   final uri= Uri.parse(_baseUrl);
   final response= await http.get(uri);
   if(response.statusCode==200)
   {
    final data=json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> categoriesJson=data['categories'];
    return categoriesJson
    .map((json)=>MealCategory.fromJson(json))
    .toList();

   }
   else
   {
    throw Exception('Failed to load categories. Status: ${response.statusCode}');
   }
  }
  Future<List<Meal>> fetchMealsByCategory(String category) async{
   final uri= Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
   final response= await http.get(uri);
   if(response.statusCode==200)
   {
    final data=json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic>? mealsJson=data['meals'];
   if (mealsJson == null) return [];
      return mealsJson.map((json) => Meal.fromJson(json)).toList();
   }
   else
   {
    throw Exception('Failed to load meals. Status: ${response.statusCode}');
   }
  }
    Future<MealDetail?> fetchMealDetail(String id) async{
   final uri= Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id');
   final response= await http.get(uri);
   if(response.statusCode==200)
   {
    final data=json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic>? mealsJson=data['meals'];
   if (mealsJson == null || mealsJson.isEmpty) return null;
   return MealDetail.fromJson(mealsJson.first);
   }
   else
   {
    throw Exception('Failed to load meals. Status: ${response.statusCode}');
   }
  }
  Future<Meal?> fetchRandomMeal() async {
  final url = Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final meals = jsonData['meals'];

    if (meals != null && meals.isNotEmpty) {
      return Meal.fromJson(meals[0]);
    }
  }

  return null;
}

}