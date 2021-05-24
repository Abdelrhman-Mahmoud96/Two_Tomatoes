import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_tomatos/design/tomato_colors.dart';
import 'package:two_tomatos/http/recipe_model.dart';

class StepsScreen extends StatelessWidget {

  final List<Steps> steps;
  StepsScreen(this.steps);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Instructions', style: GoogleFonts.robotoCondensed(
          color: TomatoColors.tomatoWhite,
          fontWeight: FontWeight.bold,
          fontSize: 24)
      )),

      body: ListView.builder(
          itemCount: steps.length,
          itemBuilder: (context, index){
            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Text('Step ${steps[index].number.toString()}: ', style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: TomatoColors.tomatoDarkRed,
                          fontSize: 20)),
                      title: Text(steps[index].step, style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: TomatoColors.tomatoBlack,
                          fontSize: 20)),
                    ),
                  ),
                )
              ],
            );
      }),
    );
  }
}
