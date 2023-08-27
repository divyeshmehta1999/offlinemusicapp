import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaomimusicapp/PlayerController.dart';
import 'package:xiaomimusicapp/PlayerScreen.dart';

class SongsList extends StatefulWidget {
  const SongsList({super.key});

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  var controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: controller.songs.length,
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print("index is $index");
              Get.to(PlayerScreen(
                songTitle: controller.songs[index].title,
                songPath: controller.songs![index].uri,
              ));
            },
            child: Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 30, left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.music_note_outlined),
                      Text(controller.songs[index].title)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
