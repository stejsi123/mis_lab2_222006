class MealDetail {
  final String id;
  final String name;
  final String thumbnail;
  final String instructions;
  final String? youtubeUrl;
  final List<String> ingredients;

  MealDetail(
    {required this.id, 
    required this.name, 
    required this.thumbnail, 
    required this.instructions, 
    this.youtubeUrl, 
    required this.ingredients});
      factory MealDetail.fromJson(Map<String, dynamic> json) {
    // collect ingredients + measures (up to 20 in API)
    final List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ing = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ing != null &&
          ing.toString().trim().isNotEmpty) {
        final partMeasure = (measure != null && measure.toString().trim().isNotEmpty)
            ? '$measure '
            : '';
        ingredients.add('$partMeasure$ing'.trim());
      }
    }

return MealDetail(
  id: json['idMeal'] as String,
  name: json['strMeal'] as String,
  thumbnail: json['strMealThumb'] as String,
  instructions:(json['strInstructions'] ?? '') as String,
  youtubeUrl: json['strYoutube'] as String?,
  ingredients: ingredients,

);
      }
}