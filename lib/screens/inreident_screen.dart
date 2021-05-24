import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_tomatos/design/tomato_colors.dart';
import 'package:two_tomatos/http/http_helper.dart';
import 'package:two_tomatos/http/ingredients_model.dart';

class IngredientsScreen extends StatelessWidget {

  final List<IngredientModel> ingredients;
  IngredientsScreen(this.ingredients);
  HttpHelper _httpHelper = HttpHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Recipe Instructions',
              style: GoogleFonts.robotoCondensed(
                  color: TomatoColors.tomatoWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 24))),

      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 3
          ),
          itemCount: ingredients.length,
          itemBuilder: (context, index){
            return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    // recipe image
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: FadeInImage(
                        width: 150,
                        height: 100,
                        placeholder: AssetImage('assets/image_placeholder.jpg'),
                        image: (ingredients[index].image) == null ?
                        AssetImage('assets/image_placeholder.jpg') :
                        NetworkImage(_httpHelper.getIngImageUrl(ingredients[index].image, 'small')),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    // ingredient name
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:8),
                          child: AutoSizeText(
                            ingredients[index].name,
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                            maxLines: 2,
                          ),

                        )
                    ),
                    // amount in unit
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:8),
                          child: AutoSizeText(
                            ingredients[index].amount.toString() +" "+ingredients[index].unit,
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 14
                            ),
                            maxLines: 2,
                          ),
                        )
                    )

                  ],
                ),
              );

          }),
    );
  }
}
