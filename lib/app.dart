import 'dart:async';

import 'package:app/lob/config/config.dart';
import 'package:app/lob/player/player.dart';
import 'package:app/lob/playlist.dart';
import 'package:app/system/storage.dart';
import 'package:app/system/media.dart';
import 'package:stated/stated.dart';

class App {
  App(this.store);

  factory App.production() {
    final store = Store()
      ..addLazy((e) async => Storage())
      ..addLazy(
        (e) async => Config(
          storage: await e.resolve(),
        ),
      )
      ..addLazy((e) async => Media())
      ..addLazy((e) async => Playlist(name: 'All'))
      ..addLazy(
        (e) async => Player(
          mediaService: await e.resolve(),
          playlist: await e.resolve(),
          config: await e.resolve(),
        ),
      );

    return App(store);
  }

  final Store store;

  Completer<void>? _init;

  Playlist get playlist => store.get<Playlist>();

  Player get player => store.get<Player>();

  Future<void> init() async {
    if (_init == null) {
      _init = Completer();
      await app.store.init();
      _init!.complete();
    } else {
      return _init!.future;
    }
  }
}

late App app;
