import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Voice interaction layer around platform TTS.
///
/// Graceful fallback everywhere: if the device cannot speak (or speech is
/// disabled), callers receive `false` and continue with text/icon UI.
/// Speech is a help layer, never the only path.
class VoiceService extends ChangeNotifier {
  VoiceService({FlutterTts? tts}) : _tts = tts ?? FlutterTts();

  final FlutterTts _tts;

  bool _available = true;
  bool _speaking = false;
  final double _rate = 0.5;

  bool get available => _available;
  bool get speaking => _speaking;

  /// Hindi default; regional languages can be swapped in later.
  static const List<String> supportedLanguages = [
    'hi-IN',
    'en-IN',
    'en-US',
    'as-IN',
    'bn-IN',
    'mr-IN',
  ];

  Future<void> init({String language = 'hi-IN', bool enabled = true}) async {
    try {
      await _tts.setLanguage(language);
      await _tts.setSpeechRate(_rate);
      await _tts.setVolume(0.9);
      _available = enabled;
    } catch (_) {
      _available = false;
    }
    notifyListeners();
  }

  /// Speaks [text]. Returns false when unavailable so callers can fall back.
  Future<bool> speak(String text, {double? rate}) async {
    if (!_available || text.isEmpty) return false;
    try {
      _speaking = true;
      notifyListeners();
      if (rate != null) await _tts.setSpeechRate(rate);
      final result = await _tts.speak(text);
      return result == 1 || result == 0;
    } catch (_) {
      _available = false;
      return false;
    } finally {
      _speaking = false;
      notifyListeners();
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
    _speaking = false;
    notifyListeners();
  }
}
