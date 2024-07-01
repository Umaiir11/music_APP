import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasecud/app/mvvm/viewmodel/home_controller/home_viewcontroller.dart';
import 'package:firebasecud/app/mvvm/viewmodel/signup_Controller/signup_controller.dart';
import 'package:firebasecud/app/service/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

import '../../models/user_model.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserModel? loginnedUserModel;

  RxBool isloading = false.obs;
  Future<bool> loginUser() async {
    try {
      isloading.value =true;

      String id = randomAlphaNumeric(10);
      UserModel? userModel = UserModel(
        email: emailController.text,
        password: passwordController.text,
        id: id,
      );
      loginnedUserModel = await DatabaseMethods().signInWithEmailAndPassword(userModel);

      if (loginnedUserModel != null) {
        // User found, use the `loginnedUserModel` object
        print('User Name: ${loginnedUserModel?.name}, Email: ${loginnedUserModel?.email}');
      } else {
        // Handle case where user with given email and password is not found
        print('Invalid email or password.');
      }


     // await homeController.getUsers();
      isloading.value =false;

      clear();
      return true;
    } catch (e) {
      print('Error adding new user data:');
      print(e);
      clear();
      isloading.value =false;

      return false;
    }
  }


  clear(){
    emailController.clear();
    passwordController.clear();

  }
}
