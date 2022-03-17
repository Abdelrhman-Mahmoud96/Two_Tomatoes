import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:two_tomatos/design/tomato_colors.dart';
import 'package:two_tomatos/http/ingredients_model.dart';
import 'package:two_tomatos/http/recipe_model.dart';
import 'package:flutter/services.dart';
import 'package:two_tomatos/screens/inreident_screen.dart';
import 'package:two_tomatos/screens/steps_screen.dart';


class RecipeScreen extends StatelessWidget {

  final RecipeModel _recipeModel;
  RecipeScreen(this._recipeModel);
  String _summery = '';
  String _servings = '';
  String _readyInMin = '';
  String _cuisine = '';
  String _diets = '';
  String _dishTypes = '';

  // TODO: 14/05/2021 insert variables in the widgets instead of the raw objects nd the status bar too

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _setValuesFromObject(_recipeModel);
    return Scaffold(
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 260,

            ),
            child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    //recipe image
                    Align(
                      alignment: Alignment.topCenter,
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/image_placeholder.jpg'),
                          image: (_recipeModel.image) == null ?
                          AssetImage('assets/image_placeholder.jpg') as ImageProvider:
                          NetworkImage(_recipeModel.image),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    // recipe title
                    Padding(
                      padding: EdgeInsets.only(top: 160,left: 8, right: 8),
                      child: AutoSizeText(
                        _recipeModel.title,
                        style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.w800,
                            color: TomatoColors.tomatoWhite,
                            backgroundColor: TomatoColors.tomatoFaintRed,
                            fontSize: 26),
                        maxLines: 2,
                      ),
                    )
                  ],
                )
            ),

          ),

          Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                   Wrap(
                     children: [
                       Card(
                           child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Align(
                                   alignment: Alignment.topLeft,
                                   child: Padding(
                                     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                     child: Text('Description: ', style: GoogleFonts.robotoCondensed(
                                         fontWeight: FontWeight.normal,
                                         color: TomatoColors.tomatoDarkRed,
                                         fontSize: 24)
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: EdgeInsets.all(5),
                                   child: AutoSizeText(
                                     _summery,
                                     style: GoogleFonts.robotoCondensed(
                                         fontWeight: FontWeight.normal,
                                         color: TomatoColors.tomatoBlack,
                                         fontSize: 18),

                                   ),
                                 ),

                               ],
                             ),
                           )

                     ],
                   ),
                    Wrap(
                      children: [
                        Card(
                            child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left:5)),
                                          Text('Servings: ', style: GoogleFonts.robotoCondensed(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: TomatoColors.tomatoDarkRed,
                                              fontSize: 20)),
                                          Text(_servings, style: GoogleFonts.robotoCondensed(
                                              fontWeight: FontWeight.normal,
                                              color: TomatoColors.tomatoBlack,
                                              fontSize: 18)),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.symmetric(vertical:5)),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left:5)),
                                          Text('Ready In Minutes: ', style: GoogleFonts.robotoCondensed(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: TomatoColors.tomatoDarkRed,
                                              fontSize: 20)),
                                          Text(_readyInMin, style: GoogleFonts.robotoCondensed(
                                              fontWeight: FontWeight.normal,
                                              color: TomatoColors.tomatoBlack,
                                              fontSize: 18)),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.symmetric(vertical:5)),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(padding: EdgeInsets.only(left:5)),
                                          Text('Cuisines: ', style: GoogleFonts.robotoCondensed(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: TomatoColors.tomatoDarkRed,
                                              fontSize: 20)),

                                          Flexible(
                                            child: Text(_cuisine, style: GoogleFonts.robotoCondensed(
                                                fontWeight: FontWeight.normal,
                                                color: TomatoColors.tomatoBlack,
                                                fontSize: 18),),
                                          )
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.symmetric(vertical:5)),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(padding: EdgeInsets.only(left:5)),
                                          Text('Dish Types: ', style: GoogleFonts.robotoCondensed(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: TomatoColors.tomatoDarkRed,
                                              fontSize: 20)),
                                          Flexible(
                                            child: Text(_dishTypes, style: GoogleFonts.robotoCondensed(
                                                fontWeight: FontWeight.normal,
                                                color: TomatoColors.tomatoBlack,
                                                fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.symmetric(vertical:5)),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(padding: EdgeInsets.only(left:5)),
                                          Text('Diets: ', style: GoogleFonts.robotoCondensed(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: TomatoColors.tomatoDarkRed,
                                              fontSize: 20)),
                                          Flexible(
                                            child: Text(_diets, style: GoogleFonts.robotoCondensed(
                                                fontWeight: FontWeight.normal,
                                                color: TomatoColors.tomatoBlack,
                                                fontSize: 18)),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                            )
                        ),
                      ],
                    ),
                    // ingredients custom button
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: GestureDetector(
                          child: Container(
                            width:330,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(48),
                              color: TomatoColors.tomatoDarkRed,
                              image: DecorationImage(
                                  image:AssetImage("assets/button-ing.png"),
                                  fit:BoxFit.fill
                              ),

                            ),
                            child: Container(),
                          ),
                          onTap: () {
                            List<IngredientModel> ingredients = _recipeModel.ingredients;
                            MaterialPageRoute route = MaterialPageRoute(builder: (context) => IngredientsScreen(ingredients));
                            Navigator.push(context, route);
                          }
                       ),
                    ),
                    // instructions custom button
                    Padding(
                      padding: EdgeInsets.only(left:5, right:5, top:8, bottom: 5),
                      child: GestureDetector(
                        child: Container(
                          width:330,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            color: TomatoColors.tomatoDarkRed,
                            image: DecorationImage(
                                image:AssetImage("assets/button-steps.png"),
                                fit:BoxFit.fill
                            ),

                          ),

                        ),
                          onTap: () {
                            // analyzed instruction json array always has one item
                            List<Steps> steps = _recipeModel.analyzedInstruction[0].steps;
                            MaterialPageRoute route = MaterialPageRoute(builder: (context) => StepsScreen(steps));
                            Navigator.push(context, route);
                          }
                    ),
                      )

                  ],
                ),
              )
          ),
          ]
        )

    );

  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text).documentElement.text;

    return parsedString;
  }

  void _setValuesFromObject(RecipeModel recipeModel)
  {
    if (recipeModel.summary != null || recipeModel.summary.isNotEmpty) {
      _summery = _parseHtmlString(recipeModel.summary);
    } else{
      _summery = 'No Information Found';
    }

    if (recipeModel.servings != null) {
      _servings = recipeModel.servings.toString();
    } else{
      _servings = 'No Information Found';
    }

    if (recipeModel.readyInMinutes != null) {
      _readyInMin = recipeModel.readyInMinutes.toString();
    } else{
      _readyInMin = 'No Information Found';
    }
    if (recipeModel.cuisines?.length != 0) {
      _cuisine = recipeModel.cuisines.join(", ");
    } else{
      _cuisine = 'No Information Found';
    }
    if (recipeModel.diets?.length != 0) {
      _diets = _recipeModel.diets.join(", ");
    } else{
      _diets = 'No Information Found';
    }
    if (recipeModel.dishTypes.length != 0) {
      _dishTypes = recipeModel.dishTypes.join(", ");
    } else{
      _dishTypes = 'No Information Found';
    }

  }
}
