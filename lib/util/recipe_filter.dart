import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_tomatos/design/tomato_colors.dart';
import 'package:two_tomatos/screens/search_results_screen.dart';
import 'filters.dart' as filters;

class FilterDialog{
  Widget buildFilterDialog(){
    return AlertDialog(
      content: RecipeFilter(),
    );
  }
}

class RecipeFilter extends StatefulWidget {
  @override
  _RecipeFilterState createState() => _RecipeFilterState();
}

class _RecipeFilterState extends State<RecipeFilter> {
  List<String> selectedFilter = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //cuisines
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Cuisines:"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        createFilterChip(filters.cuisines[0]),
                        createFilterChip(filters.cuisines[1]),
                        createFilterChip(filters.cuisines[2]),
                        createFilterChip(filters.cuisines[3]),
                        createFilterChip(filters.cuisines[4]),
                        createFilterChip(filters.cuisines[5]),
                        createFilterChip(filters.cuisines[6]),
                        createFilterChip(filters.cuisines[7]),
                        createFilterChip(filters.cuisines[8]),
                        createFilterChip(filters.cuisines[9]),
                        createFilterChip(filters.cuisines[10]),
                      ],
                    )
                ),
              ),
            ),
            Divider(color: TomatoColors.tomatoBlack, height: 10.0,),
            // diets
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Diet:"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        createFilterChip(filters.diets[0]),
                        createFilterChip(filters.diets[1]),
                        createFilterChip(filters.diets[2]),
                        createFilterChip(filters.diets[3]),
                        createFilterChip(filters.diets[4]),
                        createFilterChip(filters.diets[5]),

                      ],
                    )
                ),
              ),
            ),
            Divider(color: TomatoColors.tomatoBlack, height: 10.0,),
            //dish type
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Dish Types:"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        createFilterChip(filters.dishTypes[0]),
                        createFilterChip(filters.dishTypes[1]),
                        createFilterChip(filters.dishTypes[2]),
                        createFilterChip(filters.dishTypes[3]),
                        createFilterChip(filters.dishTypes[4]),
                        createFilterChip(filters.dishTypes[5]),
                        createFilterChip(filters.dishTypes[6]),
                      ],
                    )
                ),
              ),
            ),
            Divider(color: TomatoColors.tomatoBlack, height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              RaisedButton(
                  child: Text(
                    'cancel',
                    style: GoogleFonts.robotoCondensed(
                        color: TomatoColors.tomatoWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Navigator.pop(context);
                  }),
              RaisedButton(
                    child: Text('ok', style: GoogleFonts.robotoCondensed(
                        color: TomatoColors.tomatoWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),),
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(builder: (context) => SearchResultsScreen('', selectedFilter));
                      Navigator.push(context, route);               // Navigator.pop(context);

                    }),
              ],
            )
          ],
        ),

    );
  }
  Widget _titleContainer(String myTitle) {
    return Text(
      myTitle,
      style: GoogleFonts.robotoCondensed(
          color: TomatoColors.tomatoBlack,
          fontWeight: FontWeight.bold,
          fontSize: 18),
    );
  }

  Widget createFilterChip(String name){
   return FilterChip(
        label: Text(name),
        labelStyle: GoogleFonts.robotoCondensed(
       color: selectedFilter.contains(name)
           ? TomatoColors.tomatoWhite
           : TomatoColors.tomatoBlack,
       fontWeight: FontWeight.bold,
       fontSize: 16),

        shape: StadiumBorder (
             side: BorderSide (
             color: selectedFilter.contains(name)
                 ? Colors.transparent
                 : TomatoColors.tomatoLightRed,
              width: 1.0,
              ),
              ),
        backgroundColor: Colors.transparent,
        selectedColor: TomatoColors.tomatoLightRed,
        checkmarkColor: TomatoColors.tomatoWhite,
        selected: selectedFilter.contains(name),
        onSelected: (selected){
          setState(() {
            if(selected)
              {
                selectedFilter.add(name);
              }
            else{
              selectedFilter.remove(name);
            }

          });
        });
  }

}
