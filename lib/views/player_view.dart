import 'package:app/app.dart';
import 'package:app/lob/player/player.dart';
import 'package:app/lob/playlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({
    required this.playlist,
    required this.player,
    super.key,
  });

  final Playlist playlist;
  final Player player;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            children: playlist.sources
                .map(
                  (e) => Expanded(
                    child: TextButton(
                      child: Text(e.name),
                      onPressed: () {},
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        AnimatedBuilder(
          animation: playlist,
          builder: (context, _) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => ContentTile(playlist.items[i]),
              childCount: playlist.items.length,
            ),
          ),
        ),
      ],
    );
  }
}

class ContentTile extends StatelessWidget {
  const ContentTile(
    this.meta, {
    super.key,
  });

  final Content meta;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/app-icon.png'),
      title: Text(
        meta.name,
      ),
      onTap: () => app.player.play(meta),
    );
  }
}
