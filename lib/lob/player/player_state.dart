class PlayerState {
  PlayerState({
    required this.canPlayPrevious,
    required this.canPlay,
    required this.canPlayNext,
    required this.isPlaying,
    required this.isShuffled,
    required this.isReplay,
  });

  final bool canPlayPrevious;
  final bool canPlay;
  final bool canPlayNext;

  final bool isShuffled;
  final bool isPlaying;
  final bool isReplay;
}
