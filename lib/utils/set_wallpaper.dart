import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

//! For Set Wallpaper on Home Screen
Future<void> setWallpaper(String imgUrl, int type) async {
  // int location = WallpaperManager.BOTH_SCREEN;

  var file = await DefaultCacheManager().getSingleFile(
    imgUrl,
  );
  await WallpaperManager.setWallpaperFromFile(file.path, type);
}
