import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:wallpaper_guru/controller/api_opr.dart';
import 'package:wallpaper_guru/utils/set_wallpaper.dart';
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
  late List<CategoryModel> catModList;
  bool isLoading = true;

  int page = 1;

  final _controller = ScrollController();
  ValueNotifier<bool> isLast = ValueNotifier(false);

  getCatDetails() async {
    catModList = ApiOperations.getCategoriesList();

    setState(() {
      catModList = catModList;
    });
  }

  getTrendingWallpapers() async {
    trendingWallpaperList = await ApiOperations.getTrendingWallpapers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCatDetails();
    getTrendingWallpapers();
    _controller.addListener(() {
      // you can try _controller.position.atEdge
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 100) {
        //100 is item height
        isLast.value = true;
        goNextPage(page++);
      } else {
        isLast.value = false;
      }
    });
  }

  Future<void> goNextPage(int page) async {
    List<PhotosModel> next = await ApiOperations.nextPage(page);
    setState(() {
      trendingWallpaperList.addAll(next);
    });
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                //! Wallpaper search section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(top: 15),
                  child: SearchWallpaper(searchText: ""),
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
                        itemCount: catModList.length,
                        itemBuilder: ((context, index) => CatBlock(
                              categoryImgSrc: catModList[index].catImgUrl,
                              categoryName: catModList[index].catName,
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
                      controller: _controller,
                      cacheExtent: 5,
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
                      itemBuilder: ((context, index) => FocusedMenuHolder(
                            menuItems: [
                              FocusedMenuItem(
                                title: const Text(
                                  "Home Screen",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailingIcon: const Icon(Icons.home_filled),
                                onPressed: () {
                                  setWallpaper(
                                      trendingWallpaperList[index].imgSrc, 1);
                                },
                              ),
                              FocusedMenuItem(
                                backgroundColor: Colors.black,
                                title: const Text(
                                  "Lock Screen",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailingIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setWallpaper(
                                      trendingWallpaperList[index].imgSrc, 2);
                                },
                              ),
                              FocusedMenuItem(
                                title: const Text(
                                  "Both Screens",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailingIcon: const Icon(Icons.amp_stories_rounded),
                                onPressed: () {
                                  setWallpaper(
                                      trendingWallpaperList[index].imgSrc, 3);
                                },
                              ),
                            ],
                            menuWidth: MediaQuery.of(context).size.width * .5,
                            menuOffset: 12,
                            duration: const Duration(seconds: 0),
                            animateMenuItems: false,
                            openWithTap: true,
                            onPressed: () {},
                            child: Hero(
                              tag: trendingWallpaperList[index].imgSrc,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                // height: 700,
                                // height: MediaQuery.of(context).size.height,

                                width: 50,

                                //! for image decorations
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    trendingWallpaperList[index].imgSrc,
                                  ),
                                ),
                              ),
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
