import 'dart:io';
import 'package:flutter/material.dart';

// screens and widgets from project
import 'package:dog_breed_app/screens/home_screen.dart';
import 'package:dog_breed_app/widgets/dog_suggestion_widget.dart';


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
    // removing suggestion that doesn't have 50% confidence
    dogsWithConfidence50.removeWhere((doggy) => doggy["confidence"] < 0.5);
    dogsWithConfidence50.removeWhere((doggy) => doggy["index"]==20);
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, 
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
       dogsWithConfidence50.length !=0 ? Container(
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
        ),) :  Container(
         margin: EdgeInsets.only(top: 20),
    
      alignment: Alignment.center,
      child: Row(
      children: [
        Container(
          height: 60,
          width: 60,
          child: Image.asset("assets/20.jpeg")),
          SizedBox(width: 30,),
        Text("No Match")
      ],
    ),),

        //  giving appropriate messages according to the 
        // suggestions we have
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
              : Container(),
               SizedBox(
            height: 10,
          ),
               Center(
        child: ElevatedButton(
          onPressed: () async {
            // pushes back to home screen and pops all othe routes
                 Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false,
                        );
          },
          child: Text("Done"),
          style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 80)),
        ),
      ),
        ],),
      ),
    );
  }
}
