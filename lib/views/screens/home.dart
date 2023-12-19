import 'package:flutter/cupertino.dart';
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300,
                ),
                itemCount: 16,
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
                          "https://images.pexels.com/photos/19536238/pexels-photo-19536238/free-photo-of-a-view-of-a-city-street-with-buildings-and-a-clock-tower.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
