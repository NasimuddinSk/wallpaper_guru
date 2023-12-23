import 'package:flutter/material.dart';
import 'package:wallpaper_guru/controller/api_opr.dart';
import 'package:wallpaper_guru/model/photos_model.dart';

import 'package:wallpaper_guru/views/widgets/SarechBar.dart';

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

  getSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSearchResults();
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
      body: Column(
        children: [
          //! Search Input Section
          Container(
            margin: const EdgeInsets.only(bottom: 15, top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SearchWallpaper(),
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
                itemBuilder: ((context, index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amberAccent,
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
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
