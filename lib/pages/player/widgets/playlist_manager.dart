import 'package:app/lob/player/player.dart';
import 'package:app/lob/playlist.dart';
import 'package:app/pages/player/widgets/media_asset_tile.dart';
import 'package:flutter/material.dart';

class PlayerManager extends StatelessWidget {
  const PlayerManager({
    required this.playlist,
    required this.player,
    Key? key,
  }) : super(key: key);

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
              (context, i) => MediaAssetTile(playlist.items[i]),
              childCount: playlist.items.length,
            ),
          ),
        ),
      ],
    );
  }
}
