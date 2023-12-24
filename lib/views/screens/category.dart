import 'package:flutter/material.dart';
import 'package:wallpaper_guru/views/widgets/CustomAppBar.dart';

import '../../controller/api_opr.dart';
import '../../model/photos_model.dart';

class CategoryScreen extends StatefulWidget {
  final String catName;
  final String catImgUrl;

  const CategoryScreen({super.key, required this.catImgUrl, required this.catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotosModel> categoryResults;
  bool isLoading = true;

  int page = 1;

  final _controller = ScrollController();
  ValueNotifier<bool> isLast = ValueNotifier(false);

  getCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCatRelWall();
    super.initState();
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
      categoryResults.addAll(next);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
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
                Stack(
                  children: [
                    Image.network(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        widget.catImgUrl),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black38,
                    ),
                    Positioned(
                      left: 120,
                      top: 60,
                      child: Column(
                        children: [
                          Text(
                            widget.catName,
                            style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: double.infinity,
                    child: GridView.builder(
                        controller: _controller,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 300,
                          crossAxisCount: 2,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: categoryResults.length,
                        itemBuilder: ((context, index) => GridTile(
                              child: InkWell(
                                onTap: () {},
                                child: Hero(
                                  tag: categoryResults[index].imgSrc,
                                  child: Container(
                                    height: 800,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        height: 800,
                                        width: 50,
                                        fit: BoxFit.cover,
                                        categoryResults[index].imgSrc,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
                  ),
                )
              ],
            ),
    );
  }
}
