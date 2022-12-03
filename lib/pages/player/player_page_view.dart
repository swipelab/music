import 'package:app/app.dart';
import 'package:app/pages/player/widgets/bottom_player.dart';
import 'package:app/pages/player/widgets/playlist_manager.dart';
import 'package:flutter/material.dart';

class PlayerPageView extends StatefulWidget {
  const PlayerPageView({super.key});

  @override
  State<PlayerPageView> createState() => _PlayerPageViewState();
}

class _PlayerPageViewState extends State<PlayerPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/app-icon.png',
          width: 48,
        ),
      ),
      body: PlayerManager(
        playlist: app.playlist,
        player: app.player,
      ),
      bottomNavigationBar: PlayerControls(
        player: app.player,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
