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
  List<Content> items = [];

  Content? get nextItem => items.isEmpty ? null : items.first;

  @override
  Future<void> init() async {
    items = [
      Content(
        'https://cdn.pixabay.com/download/audio/2021/11/01/audio_67c5757bac.mp3?filename=watr-fluid-10149.mp3',
      ),
      Content(
        'music/Scorpions_Wind_Of_Change.mp3',
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

class Content {
  Content(this.url) : name = Uri.parse(url).pathSegments.last;

  final String name;

  final String url;
}
