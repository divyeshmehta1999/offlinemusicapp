import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaomimusicapp/PlayerController.dart';

class PlayerScreen extends StatefulWidget {
  final String songTitle;
  var songPath;
  PlayerScreen({super.key, required this.songTitle, required this.songPath});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  var controller = Get.put(PlayerController());
  bool isPlaying = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/headphones.png",
              height: 450,
              width: 450,
            ),
            Text(
              widget.songTitle,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            Slider(
                value: 0,
                min: Duration(seconds: 0).inSeconds.toDouble(),
                max: Duration(minutes: 4).inSeconds.toDouble(),
                onChanged: (newValue) {}),
            IconButton(
              onPressed: () {
                //controller.playSong(widget.songPath);
                setState(() {
                  isPlaying = !isPlaying; // Toggle play/pause state
                  controller.playSong(widget.songPath);
                });
              },
              icon: Center(
                child: Icon(
                  controller.audioPlayer.playing
                      ? Icons.pause_circle
                      : Icons.play_circle_fill_outlined,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
