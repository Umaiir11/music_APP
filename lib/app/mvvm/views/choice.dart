import 'package:firebasecud/app/mvvm/views/signup_view.dart';
import 'package:firebasecud/app/mvvm/views/upload_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceView extends StatefulWidget {
  const ChoiceView({super.key});

  @override
  State<ChoiceView> createState() => _ChoiceViewState();
}

class _ChoiceViewState extends State<ChoiceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
                onPressed:(){
                  Get.to(UploadAudioView());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent),
                child: const Text('Admin')),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed:(){
                  Get.to(SignUpView());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent),
                child: const Text('User')),

          ],
        ),
      ),

    );
  }
}
