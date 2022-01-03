// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:eshhenily/shared/components/components.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart'
    show FirebaseVision, FirebaseVisionImage, TextRecognizer, VisionText;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:eshhenily/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  String extractText = "";
  String image = "";
  String code = "";
  String lastCode = "";
  int always = -1;

  setAlways(isAlways) {
    if (isAlways != -1) {
      always = isAlways;
      CacheHelper.setData(key: 'always', value: always);
      emit(AlwaysButtonDialogState());
    }
  }

  restartDialog() {
    always = -1;
    CacheHelper.setData(key: 'always', value: always);
    emit(AlwaysButtonDialogState());
  }

  getCode({
    required String type,
  }) async {
    emit(LoadingState());
    if (always == 0)
      image = (await ImagePicker().pickImage(source: ImageSource.gallery))!
          .path
          .toString();
    else if (always == 1)
      image = (await ImagePicker().pickImage(source: ImageSource.gallery))!
          .path
          .toString();
    else if (last == 0)
      image = (await ImagePicker().pickImage(source: ImageSource.camera))!
          .path
          .toString();
    else if (last == 1)
      image = (await ImagePicker().pickImage(source: ImageSource.gallery))!
          .path
          .toString();
    getTextFromImage(type: type, imagePath: image);
  }

  getTextFromImage({required String imagePath, required String type}) async {
    final FirebaseVisionImage firebaseVisionImage =
        FirebaseVisionImage.fromFilePath(imagePath);
    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
    VisionText? visionText = await recognizer.processImage(firebaseVisionImage);
    getText(visionText.text, type);
    visionText = null;
  }

  // getTextFromImage({required InputImage image, required type}) async {
  //   final textDetector = GoogleMlKit.vision.textDetector();
  //   final RecognisedText recognisedText = await textDetector.processImage(image);
  //   print(recognisedText.text);
  //   getText(recognisedText.text, type);
  // }

  getText(str, type) async {
    for (int i = 0; i < str.length; i++) {
      if (str[i] == '\n') {
        code = '';
        continue;
      }
      if (str[i] == ' ') continue;
      if (str[i].codeUnitAt(0) <= '9'.codeUnitAt(0) &&
          str[i].codeUnitAt(0) >= '0'.codeUnitAt(0) &&
          str[i].codeUnitAt(0) != 32) {
        code += str[i];
        if (code.length >= 15) lastCode = code;
      } else if (str[i].codeUnitAt(0) == 10) {
        code = "";
      }
    }
    if (lastCode != "") {
      code = '${type + lastCode}#';
      lastCode = '';
      print(code);
      Clipboard.setData(ClipboardData(text: code));
      // ShowToast('past the code here', Colors.green);
      launch('tel:$code');
      emit(SuccessState());
    }else{
      ShowToast('try again!', Colors.red);
      emit(ErrorState());
    }
  }

  Map<int, bool> select = {0: true, 1: false};
  int last = 0;

  void selectButtonDialog({required int id}) {
    if (last != id) {
      select[id] = true;
      select[last] = false;
      last = id;
      emit(SelectButtonDialogState());
    }
  }

// bool isDark = false;
// void switchMood({bool? cached}) {
//   if (cached != null) {
//     isDark = cached;
//     emit(SwitchMoodState());
//     return;
//   }
//   isDark = !isDark;
//   CacheHelper.putData(isDark: isDark).then((value) {
//     emit(SwitchMoodState());
//   });
// }
}
