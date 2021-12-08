import 'package:flutter/material.dart';

class DogSuggestionWidget extends StatelessWidget {
  final dynamic dogsList;
  //data type is not known thas why i used dynamic.
  final dynamic dog;
  DogSuggestionWidget(this.dogsList, this.dog);

  @override
  Widget build(BuildContext context) {
    double co = (dogsList["confidence"] * 100);
    co = co.round().toDouble();
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      child: Row(
        children: [
          Column(children: [
            Container(
                alignment: Alignment.center,
                height: size.height * 0.07,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 60,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.file(dog, fit: BoxFit.cover)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      value: co / 100,
                                      backgroundColor:
                                          Colors.black.withOpacity(0.5),
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("$co %"),
                              ],
                            )
                          ],
                        ),
                      ),
                      Icon(Icons.check_circle)
                    ],
                  ),
                )),
          ]),
        ],
      ),
    );
  }
}
