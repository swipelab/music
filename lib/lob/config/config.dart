import 'package:app/lob/config/config_field.dart';
import 'package:app/services/storage.dart';

class Config {
  Config({
    required this.storage,
  }) {
    playerIsShuffleOn = ConfigField.boolean(
      key: () => 'player.is_shuffle_on',
      storage: storage,
    );
    playerIsReplayOn = ConfigField.boolean(
      key: () => 'player.is_replay_on',
      storage: storage,
    );
  }

  late ConfigField<bool> playerIsShuffleOn;
  late ConfigField<bool> playerIsReplayOn;

  final Storage storage;
}
