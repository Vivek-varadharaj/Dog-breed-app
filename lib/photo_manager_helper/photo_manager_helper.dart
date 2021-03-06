import 'package:flutter/material.dart';

// photo manages package used to build the custom gallery
import 'package:photo_manager/photo_manager.dart';

class PhotoManagerHelper {
  // creating a singleton class
  static final PhotoManagerHelper? _manager = PhotoManagerHelper._getManager();
  PhotoManagerHelper._getManager();
  factory PhotoManagerHelper() {
    return _manager!;
  }

  
 // function for fetching photos from gallery
  Future<List<AssetEntity>> fetchPhotos(BuildContext context) async {
    try{
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
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some error occured")));
      return [];
    }
   
  }
}
