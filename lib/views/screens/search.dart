import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:wallpaper_guru/controller/api_opr.dart';
import 'package:wallpaper_guru/model/photos_model.dart';

import 'package:wallpaper_guru/views/widgets/SarechBar.dart';

import '../../utils/set_wallpaper.dart';
import '../widgets/CustomAppBar.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({
    super.key,
    required this.query,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PhotosModel> searchResults = [];

  int page = 1;
  bool isLoading = true;

  final _controller = ScrollController();
  ValueNotifier<bool> isLast = ValueNotifier(false);

  getSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSearchResults();
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
    List<PhotosModel> next =
        await ApiOperations.searchWallpapersNextPage(widget.query, page);
    setState(() {
      searchResults.addAll(next);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                //! Search Input Section
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SearchWallpaper(searchText: widget.query),
                ),

                //! Wallpaper Section
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(bottom: 10),
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 300,
                      ),
                      itemCount: searchResults.length,
                      itemBuilder: ((context, index) => FocusedMenuHolder(
                            menuItems: [
                              FocusedMenuItem(
                                title: const Text(
                                  "Home Screen",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailingIcon: const Icon(Icons.home_filled),
                                onPressed: () {
                                  setWallpaper(searchResults[index].imgSrc, 1);
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
                                  setWallpaper(searchResults[index].imgSrc, 2);
                                },
                              ),
                              FocusedMenuItem(
                                title: const Text(
                                  "Both Screens",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailingIcon: const Icon(Icons.amp_stories_rounded),
                                onPressed: () {
                                  setWallpaper(searchResults[index].imgSrc, 3);
                                },
                              ),
                            ],
                            menuWidth: MediaQuery.of(context).size.width * .5,
                            menuOffset: 12,
                            duration: const Duration(seconds: 0),
                            animateMenuItems: false,
                            openWithTap: true,
                            onPressed: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 500,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  searchResults[index].imgSrc,
                                  fit: BoxFit.cover,
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
