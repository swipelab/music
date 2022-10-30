import 'package:flutter/cupertino.dart';
import 'package:stated/stated.dart';

class Playlist with AsyncInit, ChangeNotifier {
  Playlist(this.path);

  final String path;

  List<Content> items = [];

  Content? get nextItem => items.isEmpty ? null : items.first;

  @override
  Future<void> init() async {
    items = [
      Content(
        'https://cdn.pixabay.com/download/audio/2021/11/01/audio_67c5757bac.mp3?filename=watr-fluid-10149.mp3',
      ),
    ];
  }
}

class Content {
  Content(this.url);

  final String url;
}
