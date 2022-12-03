import 'package:app/lob/player/player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stated/stated.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({
    required this.player,
    Key? key,
  }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder.value(
      listenable: player,
      builder: (context, player, _) {
        final state = player.value;
        return Material(
          // color: const Color(0x22000000),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 18,
                  icon: Icon(
                    FontAwesomeIcons.shuffle,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                  selectedIcon: const Icon(FontAwesomeIcons.shuffle),
                  isSelected: state.isShuffled,
                  onPressed: player.toggleShuffle,
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.backwardStep),
                  onPressed: player.playPrevious,
                ),
                IconButton(
                  iconSize: 64,
                  icon: Icon(
                    FontAwesomeIcons.solidCirclePlay,
                    color: Theme.of(context).primaryColor,
                  ),
                  selectedIcon: const Icon(FontAwesomeIcons.solidCirclePause),
                  isSelected: player.value.isPlaying,
                  onPressed: player.togglePlay,
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.forwardStep),
                  onPressed: player.playNext,
                ),
                IconButton(
                  iconSize: 18,
                  icon: Icon(
                    FontAwesomeIcons.repeat,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                  selectedIcon: const Icon(FontAwesomeIcons.repeat),
                  isSelected: state.isReplay,
                  onPressed: player.toggleReplay,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
