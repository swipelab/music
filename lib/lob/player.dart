import 'package:app/lob/playlist.dart';
import 'package:just_audio/just_audio.dart' as ja;

class Player {
  Player({
    required this.playlist,
  });

  final Playlist playlist;
  final ja.AudioPlayer _player = ja.AudioPlayer();

  Future<void> play() async {
    final item = playlist.nextItem;
    if (item == null) {
      return;
    }
    await _player.setUrl(item.url);
    await _player.play();
  }
}
