import 'package:photo_manager/photo_manager.dart';

class PhotoManagerHelper {
  // creating a singleton class
  static final PhotoManagerHelper? _manager = PhotoManagerHelper._getManager();
  PhotoManagerHelper._getManager();
  factory PhotoManagerHelper() {
    return _manager!;
  }

  
 // function for fetching photos from gallery
  Future<List<AssetEntity>> fetchPhotos() async {
    final albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        filterOption: FilterOptionGroup(
            videoOption: FilterOption(
                durationConstraint:
                    DurationConstraint(max: Duration(microseconds: 0)))));
    final recentAlbum = albums.first;
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 30,
    );
    return recentAssets;
  }
}
