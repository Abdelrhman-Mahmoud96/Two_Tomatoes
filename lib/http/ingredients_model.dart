class IngredientModel{
  String name;
  String image;
  String unit;
  double amount;

  IngredientModel({this.name, this.image, this.unit, this.amount});

//  maybe we will need this
 factory IngredientModel.fromJson(Map<String,dynamic> parsedJson) => IngredientModel(
    name: parsedJson['name'],
    image: parsedJson['image'],
    amount: parsedJson['amount'],
    unit: parsedJson['unit'],
  );

}