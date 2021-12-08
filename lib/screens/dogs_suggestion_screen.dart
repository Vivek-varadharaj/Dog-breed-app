import 'dart:io';

import 'package:dog_breed_app/widgets/dog_suggestion_widget.dart';
import 'package:flutter/material.dart';

class DogsSuggestionScreen extends StatefulWidget {
 final File dog;
 final List dogsList;
  DogsSuggestionScreen(this.dog, this.dogsList);

  @override
  State<DogsSuggestionScreen> createState() => _DogsSuggestionScreenState();
}

class _DogsSuggestionScreenState extends State<DogsSuggestionScreen> {
  List dogsWithConfidence50 = [];
  @override
  void initState() {
    dogsWithConfidence50 = new List<dynamic>.from(widget.dogsList);

    super.initState();
    dogsWithConfidence50.removeWhere((doggy) => doggy["confidence"] < 0.5);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.dogsList);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Suggestions",
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            width: size.width * 0.9,
            child: Image.file(
              widget.dog,
              fit: BoxFit.cover,
            ),
            height: size.height * 0.25,
          ),
          SizedBox(
            height: 30,
          ),
        Container(
           padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.1
            ),),
          child: Column(
          children: [
             ...dogsWithConfidence50
              .map((doggy) => DogSuggestionWidget(doggy, widget.dog))
              .toList(),
          ],
        ),) ,
          SizedBox(
            height: 10,
          ),
          dogsWithConfidence50.length == 2
              ? Text("We have only two suggestions")
              : Container(),
          dogsWithConfidence50.length == 0
              ? Text("We have no suggestions")
              : Container(),
          dogsWithConfidence50.length == 1
              ? Text("We have only 1 suggestion")
              : Container()
        ]),
      ),
    );
  }
}
