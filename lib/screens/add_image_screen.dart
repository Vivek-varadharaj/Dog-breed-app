import 'dart:io';

import 'package:dog_breed_app/classifier/classifier.dart';
import 'package:dog_breed_app/photo_manager_helper/photo_manager_helper.dart';
import 'package:dog_breed_app/screens/dogs_suggestion_screen.dart';
import 'package:dog_breed_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  Classifier? _classifier ;
  PhotoManagerHelper? photos;
  List<AssetEntity> images = [];
  void getImages(context) async {
    images = await photos!.fetchPhotos(context);
    setState(() {});
  }

  ImagePicker _picker = ImagePicker();
  File? _image;
  List<dynamic> _outputs=[];
  pickImage(BuildContext context) async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    var outPut = await _classifier!.classifyImage(File(image.path,),context);
    setState(() {
      _outputs = outPut;
    });
  }
  
  bool?
      _loading; 

  @override
  void initState() {
    super.initState();
     _classifier = Classifier();
    _loading = true;

    _classifier!.loadModel(context).then((value) {
      setState(() {
        _loading = false;
      });
    });
    photos = PhotoManagerHelper();
   
    getImages(context);
    _classifier!.loadModel(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          "Pick Image",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            child: GestureDetector(
                onTap: () async {
                  await pickImage(context);
                  if(_image == null){
                    return null;
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DogsSuggestionScreen(_image!, _outputs)));
                },
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.black,
                  size: 100,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: images.length,
              itemBuilder: (_, index) {
                print(images);

                return GestureDetector(
                    onTap: () async {
                      File? image = await images[index].file;
                      List<dynamic> outPut =
                          await _classifier!.classifyImage(image!, context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DogsSuggestionScreen(image, outPut)));
                    },
                    child: AssetThumbnail(images[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
