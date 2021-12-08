import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:tflite/tflite.dart';

class Classifier {

  // creating a singleton class

  // static final Classifier? _classifier = Classifier._getClassifier();
  // Classifier._getClassifier();

  // factory Classifier() {
  //   return _classifier!;
  // }

  final String _model = "assets/model_unquant.tflite";
  final String _text = "assets/labels.txt";
  loadModel() async {
   
    await Tflite.loadModel(
      model: _model,
      labels: _text,
    );
  }

  
   // function for identifying the dog breed and returning
  //  list of outputs
  classifyImage(File image) async {
   
   try{ var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      imageStd: 255,
      imageMean: 125,
    );
    return output;
  } catch(e){
    print ("error");
  }
  }
}
