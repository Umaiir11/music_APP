import 'package:firebasecud/app/mvvm/models/user_model.dart';
import 'package:firebasecud/app/mvvm/views/category_songs.dart';
import 'package:firebasecud/app/mvvm/views/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../widgets/custom_dialogBox.dart';
import '../viewmodel/home_controller/home_viewcontroller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  final homeContorller = Get.put(HomeViewController());


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Loggined User Data'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          // Handle back button press here (if needed)
          return true; // Return true to allow back navigation, false otherwise
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name'),
                          Text(homeContorller.logginedUser?.name ?? "")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email'),
                          Text(homeContorller.logginedUser?.email ?? "")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Age'),
                          Text(homeContorller.logginedUser?.age ?? "")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Obx(() {
                return homeContorller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                        itemCount: homeContorller.allcategories?.length,
                        itemBuilder: (context, index) {
                          var category = homeContorller.allcategories?[index];
                          return Card(
                            elevation: 4,
                            child: ListTile(
                              onTap: () async {

                                Get.dialog(
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  barrierDismissible: false,
                                );
                                bool isFetched = await homeContorller.getAllSongs(category ??"");
                                Get.back();
                                if(isFetched){

                                  Get.to(CategorySongs(songs: homeContorller.allsongsList?? []));
                                }
                                else{

                                }

                                print('Tapped category: ${category ?? ""}');
                                homeContorller.categoryName = category;
                              },
                              tileColor: Colors.blueAccent,
                              title: Center(child: Text(category ?? "")),

                              // You can add onTap functionality if needed
                            ),
                          );
                        },
                      ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
