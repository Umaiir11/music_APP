import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/customSnackBar.dart';
import '../viewmodel/upload_controller/audio_upload_controller.dart';

class UploadAudioView extends StatelessWidget {
  final UploadAudioController _controller = Get.put(UploadAudioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Audio File'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => TextField(
              controller: _controller.categoryController.value,
              decoration: const InputDecoration(labelText: 'Category Name'),
            )),
            Obx(() => TextField(
              controller: _controller.songNameController.value,
              decoration: const InputDecoration(labelText: 'Song Name'),
              readOnly: true,
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _controller.pickFile,
              child: Text('Select Audio File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Get.dialog(
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  barrierDismissible: false,
                );

                bool isAdded = await _controller.uploadFile();
                Get.back();

                if (isAdded) {
                  CustomSnackbar.show(
                    iconData: Icons.check_circle,
                    title: "Alert",
                    message: "",
                    backgroundColor: Colors.white,
                    iconColor: Colors.green,
                    messageText: "Upload Successfully",
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

              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
