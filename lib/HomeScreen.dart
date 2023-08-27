import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaomimusicapp/SongsList.dart';

import 'PlayerController.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.songs.isEmpty) {
          return Center(child: Text("No Songs Found"));
        } else {
          return SongsList();
        }
      }),
    );
  }
}
