import 'dart:async';

import 'package:app/lob/playlist.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:stated/stated.dart';
import 'player_state.dart';

class Player extends Stated<PlayerState> with Disposer {
  Player({
    required this.playlist,
  }) {
    addDispose(_player.onPlayerStateChanged.listen(_onPlayerEvent).cancel);
  }

  void _onPlayerEvent(audio.PlayerState state) {
    switch (state) {
      case audio.PlayerState.completed:
        //TODO: move next
        setState();
        break;
      case audio.PlayerState.stopped:
      case audio.PlayerState.playing:
      case audio.PlayerState.paused:
        setState();
        break;
    }
  }

  final Playlist playlist;

  bool get _isPlaying => _player.state == audio.PlayerState.playing;
  final audio.AudioPlayer _player = audio.AudioPlayer();

  bool _isShuffled = false;
  bool _isReplay = false;
  Content? _current;
  final List<Content> _history = <Content>[];

  void togglePlay() {
    if (_isPlaying) {
      _player.pause();
    } else {
      if (_current != null) {
        _player.resume();
      } else {
        playNext();
      }
    }
  }

  Future<void> play([Content? item]) async {
    _pushHistory(_current);

    _current = item;
    if (item == null) {
      _player.stop();
      return;
    }
    audio.Source? source;
    if (item.url.startsWith('music/')) {
      source = audio.AssetSource(item.url);
    } else {
      source = audio.UrlSource(item.url);
    }

    await _player.play(
      source,
      position: const Duration(),
    );
  }

  void toggleShuffle() {
    _isShuffled = !_isShuffled;
    setState();
  }

  void toggleReplay() {
    _isReplay = !_isReplay;
    setState();
  }

  Future<void> playPrevious() async {
    if (_history.isEmpty) {
      return;
    }
    //TODO: figure out a better history circuit
    _current = null;

    final item = _history.removeLast();
    play(item);
  }

  Future<void> playNext() async {
    play(
      playlist.next(
        current: _current,
        random: _isShuffled,
        replay: _isReplay,
      ),
    );
  }

  @override
  PlayerState build() {
    final next = playlist.next(
      current: _current,
      replay: _isReplay,
      random: _isShuffled,
    );

    return PlayerState(
      canPlayPrevious: _history.isNotEmpty,
      canPlay: playlist.items.isNotEmpty,
      canPlayNext: next != null,
      isShuffled: _isShuffled,
      isPlaying: _isPlaying,
      isReplay: _isReplay,
    );
  }

  void _pushHistory(Content? current) {
    if (current == null) {
      return;
    }
    _history.add(current);
  }
}
