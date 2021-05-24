import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

List<Widget> tomatoSliderImages (){

  String _urlString = 'https://spoonacular.com/';
  List<String> images = [];
  images.add('assets/cover.jpg');
  images.add('assets/coverfood.jpg');
  images.add('assets/coverapi.jpg');

  final List<Widget> imageSliders = images.map((item) => InkWell(
    onTap: () {
      if(item.contains('coverapi.jpg'))
        {
          LaunchURL.launchUrl(_urlString);
        }
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(item, height: 500, width: 1000.0 ),
            ],
          )
      ),
    ),
  )).toList();

  return imageSliders;
}

class LaunchURL {
  static void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}