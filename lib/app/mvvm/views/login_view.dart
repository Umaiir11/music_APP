import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/customSnackBar.dart';
import '../viewmodel/login_controller/login_controller.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginContorller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
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
                  controller: loginContorller.emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                  controller: loginContorller.passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (loginContorller.emailController.text == '' ||
                            loginContorller.passwordController.text == '') {
                          CustomSnackbar.show(
                            iconData: Icons.warning_amber,
                            title: "Alert",
                            message: "",
                            backgroundColor: Colors.white,
                            iconColor: Colors.redAccent,
                            messageText: " Please fill the fields",
                            messageTextColor: Colors.black,
                          );
                        } else {
                          Get.dialog(
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                            barrierDismissible: false,
                          );

                          bool isAdded = await loginContorller.loginUser();
                          Get.back();
                          Get.to(()=> HomeView() );
                          if (isAdded) {
                            CustomSnackbar.show(
                              iconData: Icons.check_circle,
                              title: "Alert",
                              message: "",
                              backgroundColor: Colors.white,
                              iconColor: Colors.green,
                              messageText: "Login Successful",
                              messageTextColor: Colors.black,
                            );
                          } else {
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
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent)),
                ),
              )
            ],
          )),
    );
  }
}
