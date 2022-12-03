import 'package:flutter/foundation.dart';
import 'package:stated/stated.dart';

import 'package:audioplayers/audioplayers.dart' as audio;

class Media extends ChangeNotifier with Disposable, Disposer, AsyncInit {
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
    Uri url, {
    Duration? position,
  }) {
    audio.Source? source;
    if (url.scheme == 'assets') {
      source = audio.AssetSource(url.path.substring(1));
    } else if (url.scheme == 'http' || url.scheme == 'https') {
      source = audio.UrlSource(url.toString());
    } else if (url.scheme == 'files') {
      source = audio.DeviceFileSource(url.toFilePath());
    }
    if (source == null) {
      return;
    }
    _player.play(source, position: position).ignore();
  }
}
