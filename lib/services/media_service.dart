import 'package:flutter/foundation.dart';
import 'package:stated/stated.dart';

import 'package:audioplayers/audioplayers.dart' as audio;

class MediaService extends ChangeNotifier with Disposable, Disposer, AsyncInit {
  late audio.AudioPlayer _player;

  bool get isPlaying => _player.state == audio.PlayerState.playing;

  VoidCallback onCompleted(Future<void> Function() callback) {
    return _player.onPlayerComplete.listen((_) => callback).cancel;
  }

  @override
  Future<void> init() async {
    _player = audio.AudioPlayer();
    _player.onPlayerStateChanged
        .listen((_) => notifyListeners())
        .cancel
        .disposeBy(this);

    audio.AudioPlayer.global.setGlobalAudioContext(
      audio.AudioContextConfig().build(),
    );
  }

  void pause() => _player.pause();

  void resume() => _player.resume();

  void stop() => _player.stop();

  void play(
    String url, {
    Duration? position,
  }) {
    audio.Source? source;
    if (url.startsWith('music/')) {
      source = audio.AssetSource(url);
    } else {
      source = audio.UrlSource(url);
    }
    _player.play(source, position: position).ignore();
  }
}
