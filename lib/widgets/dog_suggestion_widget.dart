import 'package:flutter/material.dart';

class DogSuggestionWidget extends StatelessWidget {
  final dynamic dogsList;
  //data type is not known thas why i used dynamic.
  final dynamic dog;
  DogSuggestionWidget(this.dogsList, this.dog);

  @override
  Widget build(BuildContext context) {
    double confidence = (dogsList["confidence"] * 100);
    confidence = confidence.round().toDouble();
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
    
      alignment: Alignment.center,
                
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                      width: 60,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                          // converting the index got from model to string and showing 
                          // the corresponding picture of the dog
                      child: Image.asset("assets/" + dogsList["index"].toString() + ".jpg", fit: BoxFit.cover)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // uses regular expression to avoid the index
                        // from the dog's name.
                        Text(
                          "${dogsList["label"]}"
                              .replaceAll(RegExp(r'[0-9]'), ''),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: size.width / 2.5,
                                child: LinearProgressIndicator(
                                  value: confidence / 100,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                  color: Colors.black,
                                )),
                           
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text("$confidence %"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:15.0),
                    child: Icon(Icons.check_circle,color:Colors.grey),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
