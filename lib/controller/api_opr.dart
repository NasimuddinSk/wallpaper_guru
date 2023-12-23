import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper_guru/model/photos_model.dart';

import '../model/category_model.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpaperList = [];
  static List<CategoryModel> cateogryModelList = [];

  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=16"),
      headers: {
        "Authorization": "563492ad6f917000010000011f24dc9322de481baf4a0764131d6952"
      },
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      for (var element in photos) {
        trendingWallpapers.add(
          PhotosModel.fromApiToApp(element),
        );
      }
    });
    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
      headers: {
        "Authorization": "563492ad6f917000010000011f24dc9322de481baf4a0764131d6952"
      },
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      searchWallpaperList.clear();
      for (var element in photos) {
        searchWallpaperList.add(
          PhotosModel.fromApiToApp(element),
        );
      }
    });
    return searchWallpaperList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = ["Cars", "Nature", "Bikes", "Street", "City", "Flowers"];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final random = Random();

      PhotosModel photoModel =
          (await searchWallpapers(catName))[0 + random.nextInt(11 - 0)];
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}
