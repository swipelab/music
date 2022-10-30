import 'dart:async';

import 'package:app/lob/player.dart';
import 'package:app/lob/playlist.dart';
import 'package:stated/stated.dart';

class App {
  App(this.store);

  factory App.production() {
    final store = Store()
      ..addLazy((e) async => Playlist(''))
      ..addLazy(
        (e) async => Player(playlist: await e.resolve()),
      );

    return App(store);
  }

  final Store store;

  Completer<void>? _init;

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

final app = App.production();