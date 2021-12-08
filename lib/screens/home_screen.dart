import 'dart:typed_data';

import 'package:dog_breed_app/screens/add_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

// home screen containing a button and an appbar

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          'Pick an Image',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final permitted = await PhotoManager.requestPermission();
            if (!permitted) return;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddImageScreen()));
          },
          child: Text("Add Image"),
          style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 60)),
        ),
      ),
    );
  }
}

// building custom gallery using the package Photomanager

class AssetThumbnail extends StatelessWidget {
  AssetThumbnail(this.asset);

  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List?>(
      future: asset.thumbData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null)
          return Container(
              height: 40, width: 40, child: CircularProgressIndicator());
        // If there's data, display it as an image
        return Image.memory(bytes, fit: BoxFit.cover);
      },
    );
  }
}
