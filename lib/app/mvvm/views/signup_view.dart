import 'package:firebasecud/app/mvvm/views/home_view.dart';
import 'package:firebasecud/app/mvvm/views/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/customSnackBar.dart';
import '../viewmodel/signup_Controller/signup_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  final signup_Controller = Get.put(SignUpController());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up View'),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(
                    child: Text(
                      'Fill The Form ',
                      style: TextStyle(fontSize: 20),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextFormField(
                    controller: signup_Controller.emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextFormField(
                    controller: signup_Controller.passController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'password',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextFormField(
                    controller: signup_Controller.nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextFormField(
                    controller: signup_Controller.ageController,
                    decoration: InputDecoration(
                      hintText: 'Enter Age',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Age',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextFormField(
                    controller: signup_Controller.locationController,
                    decoration: InputDecoration(
                      hintText: 'Enter Location',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Location',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (signup_Controller.nameController.text == '' ||
                              signup_Controller.ageController.text == '' ||
                              signup_Controller.locationController.text == '')

                          {
                            CustomSnackbar.show(
                              iconData: Icons.warning_amber,
                              title: "Alert",
                              message: "",
                              backgroundColor: Colors.white,
                              iconColor: Colors.redAccent,
                              messageText: " Please fill the fields",
                              messageTextColor: Colors.black,
                            );
                          }

                          else{
                            Get.dialog(
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                              barrierDismissible: false,
                            );

                            bool isAdded = await signup_Controller.addUserData();
                            Get.back();
                            Get.to(()=> LoginView() );

                            if (isAdded) {
                              CustomSnackbar.show(
                                iconData: Icons.check_circle,
                                title: "Alert",
                                message: "",
                                backgroundColor: Colors.white,
                                iconColor: Colors.green,
                                messageText: "SignUp Successfully",
                                messageTextColor: Colors.black,
                              );
                            }
                            else {
                              CustomSnackbar.show(
                                iconData: Icons.warning_amber,
                                title: "Alert",
                                message: "",
                                backgroundColor: Colors.white,
                                iconColor: Colors.redAccent,
                                messageText: " Failed",
                                messageTextColor: Colors.black,
                              );
                            }
                          }

                        },
                        child: Text('Sign Un'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          Get.to(()=> LoginView() );
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent)),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
