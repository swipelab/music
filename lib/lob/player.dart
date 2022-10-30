import 'package:app/lob/playlist.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:flutter/cupertino.dart';
import 'package:stated/stated.dart';

class Player extends Disposable with ChangeNotifier, Disposer {
  Player({
    required this.playlist,
  }) {
    playlist.subscribe(notifyListeners).disposeBy(this);
  }

  final Playlist playlist;
  final audio.AudioPlayer _player = audio.AudioPlayer();

  Future<void> play([Content? content]) async {
    final item = content ?? playlist.nextItem;
    if (item == null) {
      return;
    }

    if (item.url.startsWith('music/')) {
      await _player.play(audio.AssetSource(item.url));
    } else {
      await _player.play(audio.UrlSource(item.url));
    }
  }
}
