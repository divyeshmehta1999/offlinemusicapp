import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  final songs = <SongModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  playSong(String? uri) {
    try {
      if (audioPlayer.playing) {
        audioPlayer.pause();
      } else {
        audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
        audioPlayer.play();
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  // playSong(String? uri) {
  //   if (uri != null) {
  //     audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
  //     audioPlayer.play();
  //   } else {
  //     print("URI is null");
  //   }
  // }
  //
  // pauseSong(String? uri) {
  //   if (uri != null) {
  //     audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
  //     audioPlayer.pause();
  //   } else {
  //     print("URI is null");
  //   }
  // }

  Future<void> checkPermission() async {
    var permissionStatus = await Permission.accessMediaLocation.request();
    if (permissionStatus.isGranted) {
      await queryAudio();
      print("permission granted");
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
      isLoading.value = false;
      print("permission denied");
    } else {
      isLoading.value = false;
      print("permission denied");
    }
  }

  Future<void> queryAudio() async {
    try {
      final queriedSongs = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL,
      );
      songs.assignAll(queriedSongs);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      // Handle error during audio query
    }
  }
}
