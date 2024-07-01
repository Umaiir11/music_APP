import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasecud/app/mvvm/viewmodel/home_controller/home_viewcontroller.dart';
import 'package:firebasecud/app/service/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

import '../../../service/firebase_auth.dart';
import '../../models/user_model.dart';

class SignUpController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController gender = TextEditingController();

  RxBool isloading = false.obs;
  UserModel? SigunUser;


  Future<bool> addUserData() async {
    try {
      isloading.value =true;
      UserModel signUpModel = UserModel(
        email: emailController.text,
        password: passController.text ,
      );
     final UserCredential? userCredential= await FirebaseAuthHelper().signUpWithEmailAndPassword(signUpModel);

     if(userCredential == null){
       debugPrint('failed');
     }


     else{

       UserModel userModel = UserModel(
         email: userCredential.user?.email,
         password: passController.text ,
         name: nameController.text,
         age: ageController.text,
         location: locationController.text,
         id: userCredential.user?.uid,
       );

       await DatabaseMethods().addUserDataa(userModel);
       debugPrint('Added successfully');
      // SigunUser= await DatabaseMethods().fetchUserById(userModel.id ?? "N/A");       isloading.value =false;

       clear();
       return true;
     }
      isloading.value =false;
      return false;
    } catch (e) {
      print('Error adding new user data:');
      print(e);
      clear();
      isloading.value =false;

      return false;
    }
  }


  clear(){
    nameController.clear();
    ageController.clear();
    locationController.clear();

  }
}
