// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  String imgUrl;
  FullScreen({
    super.key,
    required this.imgUrl,
  });

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  //! For Set Wallpaper on Home Screen
  Future<void> setWallpaperHome() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(
      widget.imgUrl,
    );
    bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  //! For Set Wallpaper on Lock Screen
  Future<void> setWallpaperLock() async {
    int location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(
      widget.imgUrl,
    );
    bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  //! For Set Wallpaper on Both Screen
  Future<void> setWallpaperBoth() async {
    int location = WallpaperManager.BOTH_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(
      widget.imgUrl,
    );
    bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .92,
              left: MediaQuery.of(context).size.width * .05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setWallpaperHome();
                    },
                    icon: const Icon(
                      Icons.home_filled,
                      size: 26,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setWallpaperLock();
                    },
                    icon: const Icon(
                      Icons.lock,
                      size: 26,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Lock",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setWallpaperBoth();
                    },
                    icon: const Icon(
                      Icons.amp_stories_rounded,
                      size: 26,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Both",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
