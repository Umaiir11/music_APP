import 'package:firebasecud/app/mvvm/models/audio_model.dart';
import 'package:firebasecud/app/mvvm/viewmodel/signup_Controller/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../service/firebase_service.dart';
import '../../models/user_model.dart';
import '../login_controller/login_controller.dart';

class HomeViewController extends GetxController {
  final signUpController = Get.put(LoginController());

  RxBool isLoading = false.obs;
  UserModel? logginedUser;
  List<String>? allcategories;
  List<AudioSongModel>? allsongsList;

  @override
  void onInit() {
    super.onInit();
    getData();
    getAllCategories();
  }

  void getData() {
    logginedUser = signUpController.loginnedUserModel;
    debugPrint(logginedUser?.email);
  }

  String? categoryName;

  Future<void> getAllCategories() async {
    isLoading.value = true;
    allcategories = await DatabaseMethods().getAllCategories();
    isLoading.value = false;
  }

  Future<bool> getAllSongs(String categoryName) async {
    try {
      allsongsList = await DatabaseMethods().getSongsByCategory(categoryName);
      return true;
    } catch (e) {
      print('Error fetching songs: $e');
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
