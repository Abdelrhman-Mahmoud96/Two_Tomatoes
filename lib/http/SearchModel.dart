import 'package:two_tomatos/http/recipe_model.dart';

class SearchModel{
  int totalResults;
  List<RecipeModel> recipes;

  SearchModel(this.totalResults, this.recipes);
}