import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpaper_guru/views/widgets/SarechBar.dart';
import 'package:wallpaper_guru/views/widgets/cat_block.dart';

import '../widgets/CustomAppBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const SearchWallpaper(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 30,
                itemBuilder: ((context, index) => const CatBlock()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
