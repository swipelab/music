import 'dart:async';

import 'package:app/lob/config/config.dart';
import 'package:app/lob/playlist.dart';
import 'package:app/services/media_service.dart';
import 'package:stated/stated.dart';
import 'player_state.dart';

class Player extends Stated<PlayerState> with Disposer {
  Player({
    required this.mediaService,
    required this.playlist,
    required this.config,
  }) {
    mediaService.onCompleted(playNext).disposeBy(this);
    mediaService.subscribe(setState).disposeBy(this);
  }

  final MediaService mediaService;
  final Playlist playlist;

  final Config config;

  Content? _current;
  final List<Content> _history = <Content>[];

  bool get _isShuffled => config.playerIsShuffleOn.value;

  bool get _isReplay => config.playerIsReplayOn.value;

  void togglePlay() {
    if (mediaService.isPlaying) {
      mediaService.pause();
    } else {
      if (_current != null) {
        mediaService.resume();
      } else {
        playNext();
      }
    }
  }

  Future<void> play([Content? item]) async {
    _pushHistory(_current);

    _current = item;
    if (item == null) {
      mediaService.stop();
      return;
    }

    mediaService.play(
      item.url,
      position: const Duration(),
    );
  }

  void toggleShuffle() {
    config.playerIsShuffleOn.value = !_isShuffled;
    setState();
  }

  void toggleReplay() {
    config.playerIsReplayOn.value = !_isReplay;
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
      isPlaying: mediaService.isPlaying,
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
