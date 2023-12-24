import 'package:flutter/material.dart';
import 'package:wallpaper_guru/views/screens/search.dart';

class SearchWallpaper extends StatefulWidget {
  String? searchText;
  SearchWallpaper({super.key, required this.searchText});

  @override
  State<SearchWallpaper> createState() => _SearchWallpaperState();
}

class _SearchWallpaperState extends State<SearchWallpaper> {
  TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(78, 192, 192, 192),
        border: Border.all(color: const Color.fromARGB(15, 1, 0, 0)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(query: value),
                    ));
              },
              controller: _searchController,
              decoration: const InputDecoration(
                errorMaxLines: 1,
                hintText: "Search Wallpapers",
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchScreen(query: _searchController!.text),
                  ));
            },
            child: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
