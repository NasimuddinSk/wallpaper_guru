import 'package:flutter/material.dart';
import 'package:wallpaper_guru/controller/api_opr.dart';
import 'package:wallpaper_guru/views/widgets/SarechBar.dart';
import 'package:wallpaper_guru/views/widgets/cat_block.dart';

import '../../model/category_model.dart';
import '../../model/photos_model.dart';
import '../widgets/CustomAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotosModel> trendingWallpaperList = [];
  late List<CategoryModel> CatModList;
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = await ApiOperations.getCategoriesList();
    setState(() {
      CatModList = CatModList;
    });
  }

  getTrendingWallpapers() async {
    trendingWallpaperList = await ApiOperations.getTrendingWallpapers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    getTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ! Custom appbar section
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: CustomAppBar(
          word1: "Wallpaper",
          word2: "Guru",
        ),
      ),
      body: Column(
        children: [
          //! Wallpaper search section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(top: 15),
            child: SearchWallpaper(),
          ),

          //! wallpaper category section
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 5,
            ),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: CatModList.length,
                  itemBuilder: ((context, index) => CatBlock(
                        categoryImgSrc: CatModList[index].catImgUrl,
                        categoryName: CatModList[index].catName,
                      ))),
            ),
          ),

          //! wallpaper view section
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: GridView.builder(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300,
                ),
                itemCount: trendingWallpaperList.length,
                itemBuilder: ((context, index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amberAccent,
                      ),
                      // height: 700,
                      // height: MediaQuery.of(context).size.height,

                      width: 50,

                      //! for image decorations
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            fit: BoxFit.cover, trendingWallpaperList[index].imgSrc),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
