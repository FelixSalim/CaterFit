import 'package:flutter_tts/flutter_tts.dart';

class AccessibilityController {
  static final FlutterTts _tts = FlutterTts();
  static bool isEnabled = false;

  static Future<void> speak(String text) async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.4);
    await _tts.setVolume(1);
    await _tts.awaitSpeakCompletion(true);
    await _tts.speak(text);
  }

  static Future<void> enableAccessibility(bool value) async {
    AccessibilityController.isEnabled = value;
    if (value) speak("Accessibility mode activated");
  }

  static bool getIsEnabled() {
    return AccessibilityController.isEnabled;
  }
}
