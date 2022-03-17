import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:two_tomatos/http/SearchModel.dart';
import 'package:two_tomatos/http/recipe_model.dart';

class HttpHelper{

 HttpHelper._internal();
 static final HttpHelper httpHelper = HttpHelper._internal();

 factory HttpHelper(){
   return httpHelper;
  }

  Map<String,String> _searchProperties = {
    'info': '&addRecipeInformation=true',
    'ingredients': '&fillIngredients=true',
    'instruction': '&instructionsRequired=true',
    'number': '&number=',
    'offset': '&offset=',
    'query': '&query=',
    'cuisine': '&cuisine=',
    'diet': '&diet=',
    'type': '&type=',
    'time': '&maxReadyTime='
  };

  Map<String,String> _imageSizes = {
    "small" : "100x100",
    'medium': '250x250',
    'large': '500x500'
  };

  final String _apiKey = '?apiKey=781f38a2eb8e4fb899775426a943ad0b';
  // for ingredients only
  final String _urlImages = 'https://spoonacular.com/cdn/ingredients_';
  final String _urlBaseRecipeSearch = 'https://api.spoonacular.com/recipes/complexSearch';
  final String _urlRandomRecipes = 'https://api.spoonacular.com/recipes/random';

  Future<List<RecipeModel>> getRandomRecipes(int numbOfRecipes) async
  {
    final String link = _urlRandomRecipes +
        _apiKey +
        _searchProperties['info'] +
        _searchProperties['ingredients'] +
        _searchProperties['instruction'] +
        _searchProperties['number'] + numbOfRecipes.toString();

    http.Response response = await http.get(Uri.parse(link));
    if(response.statusCode == HttpStatus.ok)
      {

        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // because the data are written in this format :
      // {
      //     recipes: [
      //       {
      //         key1: value1,
      //         key2: value2,
      //         key3: value3,
      //       }

      //       {
      //         key1: value1,
      //         key2: value2,
      //         key3: value3,
      //       }
      //     ]
      // }
      // which make the json response returns a map instead of a list of <dynamic>
       return List<RecipeModel>.from(jsonResponse["recipes"].map((item) => RecipeModel.fromJson(item)));

      }
    else{
      print('something went wrong !');
      return null;
    }

  }

  Future<SearchModel> searchRecipes(int numOfRecipes, int offset, String query) async{
    final String link = _urlBaseRecipeSearch +
        _apiKey +
        _searchProperties['query'] + query +
        _searchProperties['info'] +
        _searchProperties['ingredients'] +
        _searchProperties['instruction'] +
        _searchProperties['number'] + numOfRecipes.toString() +
        _searchProperties['offset'] + offset.toString();

    http.Response response = await http.get(Uri.parse(link));
    if(response.statusCode == HttpStatus.ok)
    {

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      int totalResults = jsonResponse['totalResults'];
      List<RecipeModel> recipes =  List<RecipeModel>.from(jsonResponse["results"].map((item) => RecipeModel.fromJson(item)));
      return SearchModel(totalResults, recipes);

    }
    else{
      print('something went wrong !');
      return SearchModel(0, List.empty());
    }

  }

  Future<SearchModel> searchRecipesWithFilter(int numOfRecipes, int offset, List<String> cuisines, List<String> diets, List<String> dishTypes) async{
    String cuisinesString = cuisines.join(',');
    String dietsString = diets.join(',');
    String dishTypeString = dishTypes.join(',');

    final String link = _urlBaseRecipeSearch +
       _apiKey +
       _searchProperties['cuisine'] + cuisinesString +
       _searchProperties['diet'] + dietsString +
       _searchProperties['type'] + dishTypeString +
       _searchProperties['info'] +
       _searchProperties['ingredients'] +
       _searchProperties['instruction'] +
       _searchProperties['number'] + numOfRecipes.toString() +
       _searchProperties['offset'] + offset.toString();
      print(link);

   http.Response response = await http.get(Uri.parse(link));
   if(response.statusCode == HttpStatus.ok)
   {

     Map<String, dynamic> jsonResponse = jsonDecode(response.body);
     int totalResults = jsonResponse['totalResults'];
     List<RecipeModel> recipes = List<RecipeModel>.from(jsonResponse["results"].map((item) => RecipeModel.fromJson(item)));
     return SearchModel(totalResults, recipes);

   }
   else{
     print('something went wrong !');
     return SearchModel(0, List.empty());
   }

 }

  String getIngImageUrl(String name, String size){
    String url = _urlImages + _imageSizes[size] + '/'+ name;
    return url;
  }

}