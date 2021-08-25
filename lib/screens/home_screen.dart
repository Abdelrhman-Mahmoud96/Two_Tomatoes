import 'dart:async';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_tomatos/design/tomato_colors.dart';
import 'package:two_tomatos/design/tomato_slider_images.dart';
import 'package:two_tomatos/http/http_helper.dart';
import 'package:two_tomatos/http/recipe_model.dart';
import 'file:///C:/Users/DELL/AndroidStudioProjects/two_tomatos/lib/util/recipe_filter.dart';
import 'package:two_tomatos/screens/recipe_screen.dart';
import 'package:two_tomatos/screens/search_results_screen.dart';




class HomeScreen extends StatefulWidget {

  final bool isConnected;

  HomeScreen(this.isConnected);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message ='';
  bool isConnected = false;
  List<Widget> carouselImages = [];
  int _current = 0;
  HttpHelper _httpHelper;
  List<RecipeModel> recipeList;
  int _numOfRecipes = 12;
  Widget _searchBar = Text('Recipes');
  Icon _visibleIcon = Icon(Icons.search);
  String query = '';

  List<String> selectedCountList = [];
  var _streamController = StreamController<List>.broadcast();

  @override
  void initState() {
    isConnected =  (widget.isConnected) ? true : false;
    carouselImages = tomatoSliderImages();
    _httpHelper = HttpHelper();
    if(isConnected == true){
      _loadRecipes(_numOfRecipes).then((value) {
        recipeList = value;
        _streamController.sink.add(recipeList);
      });

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchBar,
        actions: [
          // search
          IconButton(
              icon: _visibleIcon,
              onPressed: (){
                setState(() {
                  if(_visibleIcon.icon == Icons.search)
                    {
                      _visibleIcon = Icon(Icons.cancel);
                      _searchBar = TextField(
                        textInputAction: TextInputAction.search,
                        cursorColor: TomatoColors.tomatoWhite,
                        showCursor: true,
                        decoration: InputDecoration(fillColor: TomatoColors.tomatoBlack, hintText: 'Enter your Meal Name...', hintStyle: GoogleFonts.robotoCondensed(
                            fontSize: 20),),
                        style: GoogleFonts.robotoCondensed(
                            color: TomatoColors.tomatoWhite,
                            fontSize: 20),
                        onSubmitted: (text){
                          MaterialPageRoute route = MaterialPageRoute(builder: (context) => SearchResultsScreen(text,List.empty()));
                          Navigator.push(context, route);
                        },
                      );
                    }
                  else{
                    setState(() {
                      _visibleIcon = Icon(Icons.search);
                      _searchBar = Text('Recipes');
                    });
                  }
                });
              }
          ),
          // filter
          IconButton(
              icon: Icon(Icons.filter_alt_outlined),
              onPressed: (){
               showDialog(context: context, builder: (context) => FilterDialog().buildFilterDialog());
               //  MaterialPageRoute route = MaterialPageRoute(builder: (context) => RecipeFilter());
               //  Navigator.push(context, route);
              }
          ),

        ],
      ),
      body: Container(
      child: (isConnected) ? mainWidget(context) : Align(alignment: Alignment.center, child: noInternet(context)),

    ));
  }

  Future retryConnection() async {
      isConnected = await checkConnection();

      if (isConnected) {
        setState(() {
          isConnected = true;
          _loadRecipes(_numOfRecipes).then((value) {
            recipeList = value;
            _streamController.sink.add(recipeList);
          });
        });
      }
      else {
        setState(() {
          isConnected = false;

        });
      }
  }

  Widget noInternet(BuildContext context){
    var screenSize = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 10,top: screenSize.height/3),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/no_internet.png', width: 100, height: 100,),
                Text('No internet Connection'),
                Padding(padding: EdgeInsets.only(top: 20)),
                RaisedButton(
                    child: Text('Try Again') ,
                    onPressed: () => retryConnection())
              ],
          ),
      )

    );
  }

  Widget mainWidget(BuildContext context) {
    // var screenHeightSize = MediaQuery.of(context).size.height;
    return EasyRefresh.custom(
      footer: BezierBounceFooter(),
      slivers: [
        // adapter widget because CustomScrollView only works with sliver type widgets
        SliverToBoxAdapter(
          child: Column(
            children: [
              // carousel slider
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CarouselSlider(
                    items: carouselImages,
                    options: CarouselOptions(
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason)
                        {
                          setState(() {
                            _current = index;
                          });

                        }
                    ),
                  ),
                  // for dot indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: carouselImages.map((item) {
                      int index = carouselImages.indexOf(item);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                  // banner
                  Align(
                    child: Container(
                      padding: EdgeInsets.only(top: 7, left: 4, right: 4),
                      child: Image.asset('assets/banner.jpg', fit: BoxFit.fill,),
                    ),
                  ),
                ],
              ),
              // recipes grid view
              StreamBuilder(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 3,),

                        itemBuilder: (context, index)
                        { return GestureDetector(
                            onTap: (){
                              MaterialPageRoute route = MaterialPageRoute(builder: (context) => RecipeScreen(snapshot.data[index]));
                              Navigator.push(context, route);
                            },
                            child: Card(
                              // elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  // recipe image
                                  FadeInImage(
                                    placeholder: AssetImage('assets/image_placeholder.jpg'),
                                    image: (snapshot.data[index].image) == null ?
                                    AssetImage('assets/image_placeholder.jpg') :
                                    NetworkImage(snapshot.data[index].image),
                                    fit: BoxFit.fill,
                                  ),

                                  // recipe title
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5,left:5,right: 5),
                                        child: AutoSizeText(
                                          snapshot.data[index].title,
                                          style: GoogleFonts.robotoCondensed(fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          maxFontSize: 12,
                                        ),
                                      )
                                  )

                                ],
                              ),
                            ),
                          );
                        },

                      );
                    }
                    else if (snapshot.hasError) {
                      print('something went wrong');
                      return Container();
                    }
                  // loading indicator
                  return Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                TomatoColors.tomatoBlack)),
                      )
                  );
                },
              ),
              // more button
              // Align(
              //     alignment: Alignment.bottomRight,
              //     child: Padding(
              //       padding: EdgeInsets.only(right: 5),
              //       child: RaisedButton.icon(
              //         icon: Text(' More Recipes'),
              //         label: Icon(Icons.arrow_forward_ios),
              //         onPressed: () {},
              //
              //       ),
              //     )
              // )
            ],
          ),
        )
      ],
      onLoad: () async {
        checkConnection().then((result) {
          if (result == true) {
            setState(() {
              _loadRecipes(_numOfRecipes).then((value) {
                recipeList.insertAll(recipeList.length, value);
                print(recipeList.length);
                _streamController.sink.add(recipeList);
              });
            });
          }
          else {
            setState(() {
              _showSnakeBar(context);

            });
          }
        });



      },

    );
  }


  Future<List<RecipeModel>> _loadRecipes(int numberOfRecipes) async{
    List<RecipeModel> recipes =  await _httpHelper.getRandomRecipes(numberOfRecipes);
    return recipes;
  }

  Future<bool> checkConnection() async{
    bool result = false;
    try {
      final connectionResult = await InternetAddress.lookup('example.com');
      if (connectionResult.isNotEmpty &&
          connectionResult[0].rawAddress.isNotEmpty) {
        result = true;
      }

    } on SocketException catch (_) {
        print('still no internet connection or disconnected');
    }
    return result;
  }

  void _showSnakeBar(BuildContext context){
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('No Internet Connection'),
      ),
    );

  }



  @override
  void dispose() {
        super.dispose();
        _streamController.close();
  }

}

