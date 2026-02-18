import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  bool _isMusicEnabled = true;
  bool _isSfxEnabled = true;
  double _musicVolume = 0.7;
  double _sfxVolume = 1.0;

  Future<void> initialize() async {
    try {
      await FlameAudio.audioCache.loadAll([
        'music/background_music.mp3',
        'sfx/collect.mp3',
        'sfx/explosion.mp3',
        'sfx/jump.mp3',
      ]);
      print('Audio initialized successfully');
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  void playBackgroundMusic() {
    if (_isMusicEnabled) {
      try {
        FlameAudio.bgm.play('music/background_music.mp3', volume: _musicVolume);
      } catch (e) {
        print('Error playing BGM: $e');
      }
    }
  }

  void stopBackgroundMusic() {
    try {
      FlameAudio.bgm.stop();
    } catch (e) {
      print(e);
    }
  }

  void playSfx(String fileName) {
    if (_isSfxEnabled) {
      try {
        FlameAudio.play('sfx/$fileName', volume: _sfxVolume);
      } catch (e) {
        print('Error playing SFX: $e');
      }
    }
  }

  void toggleMusic() {
    _isMusicEnabled = !_isMusicEnabled;
    if (_isMusicEnabled) {
      playBackgroundMusic();
    } else {
      stopBackgroundMusic();
    }
  }

  void toggleSfx() {
    _isSfxEnabled = !_isSfxEnabled;
  }
}
