import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecud/app/mvvm/models/audio_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../../../service/firebase_service.dart';

class UploadAudioController extends GetxController {
  final DatabaseMethods _databaseMethods = DatabaseMethods();
  var categoryController = TextEditingController().obs;
  var songNameController = TextEditingController().obs;
  var selectedFile = Rx<File?>(null);
  var songName = ''.obs;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      selectedFile.value = File(result.files.single.path!);
      songName.value = result.files.single.name;
      songNameController.value.text = songName.value;
    }
  }



  Future<bool> uploadFile() async {
    if (selectedFile.value != null &&
        categoryController.value.text.isNotEmpty &&
        songNameController.value.text.isNotEmpty) {
      AudioSongModel audioModel = AudioSongModel(
        songUrl: '',
          songName: songNameController.value.text,
          categoryName: categoryController.value.text,
        file: selectedFile.value,
        thumbnail: '',
        timestamp: Timestamp.fromDate(DateTime.now()),

      );
      bool isUploaded = await _databaseMethods.uploadAudioFile(audioModel);
      return isUploaded;
    } else {
      return false;
    }
  }
}
