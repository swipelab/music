import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:stated/stated.dart';

class Playlist with AsyncInit, ChangeNotifier {
  Playlist({
    required this.name,
    this.path,
  });

  final String name;
  final String? path;

  List<Source> sources = [
    Source(name: 'All'),
    Source(name: 'Folders'),
  ];
  List<MediaAsset> items = [];

  MediaAsset? next({
    MediaAsset? current,
    bool random = false,
    bool replay = false,
  }) {
    final index = nextIndex(
      currentIndex: items.indexWhere((e) => e == current),
      length: items.length,
      random: random,
      replay: replay,
    );

    return index == -1 ? null : items[index];
  }

  static int nextIndex({
    required int currentIndex,
    required int length,
    required bool random,
    required bool replay,
  }) {
    if (length == 0) {
      return -1;
    }

    if (currentIndex == -1) {
      if (length == 1) {
        return 0;
      } else {
        return random ? Random().nextInt(length) : 0;
      }
    } else {
      if (length == 1) {
        return replay ? 0 : -1;
      } else {
        var nextIndex = currentIndex;
        if (random) {
          nextIndex = Random().nextInt(length);
          if (nextIndex == currentIndex) {
            nextIndex++;
          }
        } else {
          nextIndex++;
        }

        if (nextIndex >= length) {
          nextIndex = 0;
        }
        return nextIndex;
      }
    }
  }

  @override
  Future<void> init() async {
    items = [
      MediaAsset(
        Uri.parse(
            'https://cdn.pixabay.com/download/audio/2021/11/01/audio_67c5757bac.mp3?filename=watr-fluid-10149.mp3'),
      ),
      MediaAsset(
        Uri.parse('assets:///music/Scorpions_Wind_Of_Change.mp3'),
      ),
    ];
  }
}

class Source {
  Source({
    required this.name,
  });

  final String name;
}

class MediaAsset {
  MediaAsset(this.url) : name = url.pathSegments.last;

  final String name;

  final Uri url;

  @override
  bool operator ==(Object other) {
    return other is MediaAsset && url == other.url;
  }

  @override
  int get hashCode => url.hashCode;
}
