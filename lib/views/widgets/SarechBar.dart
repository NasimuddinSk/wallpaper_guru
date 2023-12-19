import 'package:flutter/material.dart';

class SearchWallpaper extends StatelessWidget {
  const SearchWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(66, 192, 192, 192),
        border: Border.all(color: const Color.fromARGB(33, 1, 0, 0)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
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
            onTap: () {},
            child: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
