import 'package:flutter/material.dart';
import 'package:wallpaper_guru/views/screens/search.dart';

class SearchWallpaper extends StatelessWidget {
  SearchWallpaper({super.key});

  final TextEditingController _searchController = TextEditingController();

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
                      builder: (context) =>
                          SearchScreen(query: _searchController.text),
                    ));
              },
              controller: _searchController,
              decoration: const InputDecoration(
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
                        SearchScreen(query: _searchController.text),
                  ));
            },
            child: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
