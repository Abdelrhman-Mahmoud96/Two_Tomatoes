import 'ingredients_model.dart';

class RecipeModel{
  String title;
  String image;
  String summary;
  int readyInMinutes;
  int servings;
  List<AnalyzedInstruction> analyzedInstruction;
  List<IngredientModel> ingredients;
  List<String> diets;
  List<String> cuisines;
  List<String> dishTypes;

  RecipeModel({
      this.title,
      this.image,
      this.summary,
      this.readyInMinutes,
      this.servings,
      this.analyzedInstruction,
      this.ingredients,
      this.diets,
      this.cuisines,
      this.dishTypes});

 factory RecipeModel.fromJson(Map<String, dynamic> parsedJson) => RecipeModel(
        title: parsedJson['title'],
        image: parsedJson['image'],
        summary: parsedJson['summary'],
        readyInMinutes: parsedJson['readyInMinutes'],
        servings: parsedJson['servings'],
        analyzedInstruction: List<AnalyzedInstruction>.from( parsedJson['analyzedInstructions']
            .map((instruction) => AnalyzedInstruction.fromJson(instruction))),

        ingredients: List<IngredientModel>.from(parsedJson["extendedIngredients"]
            .map((ingredient) => IngredientModel.fromJson(ingredient))),

        diets: List<String>.from(parsedJson['diets'].map((item) => item)),
        cuisines: List<String>.from(parsedJson['cuisines'].map((item) => item)),
        dishTypes: List<String>.from(parsedJson['dishTypes'].map((item) => item)),
      );
}


class AnalyzedInstruction {
  List<Steps> steps;

  AnalyzedInstruction(this.steps);

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> parsedInst) =>
      AnalyzedInstruction(
          List<Steps>.from(
              parsedInst['steps'].map((step) => Steps.fromJson(step)))
      );
}

class Steps {
  int number;
  String step;

  Steps({this.number, this.step});

  factory Steps.fromJson(Map<String, dynamic> parsedStep) =>
      Steps(
          number: parsedStep['number'],
          step: parsedStep['step']
      );

}