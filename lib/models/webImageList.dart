
import 'package:flutter_app_gallery/models/webimage.dart';

class WebImageList{
  final List<WebImage> webimages;

  WebImageList({
    required this.webimages,
  });

  factory WebImageList.fromJson(List<dynamic> parsedJson){
    List<WebImage> images = [];
    images = parsedJson.map((i)=> WebImage.fromJson(i)).toList();
    return WebImageList(
      webimages: images,
    );
  }
}