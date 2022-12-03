import 'package:app/app.dart';
import 'package:app/lob/playlist.dart';
import 'package:flutter/material.dart';

class MediaAssetTile extends StatelessWidget {
  const MediaAssetTile(
    this.state, {
    super.key,
  });

  final MediaAsset state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/app-icon.png'),
      title: Text(
        state.name,
      ),
      onTap: () => app.player.play(state),
    );
  }
}
