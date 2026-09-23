import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Local password hashing: HMAC-SHA256 keyed by a random per-account salt,
/// stored as `base64(salt):base64(digest)`. No plaintext is ever persisted.
abstract final class PasswordHasher {
  static final Random _random = Random.secure();

  static String hash(String password) {
    final salt = List<int>.generate(16, (_) => _random.nextInt(256));
    return _encode(salt, _digest(salt, password));
  }

  static bool verify(String password, String stored) {
    try {
      final separator = stored.indexOf(':');
      if (separator < 0) return false;
      final salt = base64Decode(stored.substring(0, separator));
      return stored == _encode(salt, _digest(salt, password));
    } on Exception {
      return false;
    }
  }

  static List<int> _digest(List<int> salt, String password) =>
      Hmac(sha256, salt).convert(utf8.encode(password)).bytes;

  static String _encode(List<int> salt, List<int> digest) =>
      '${base64Encode(salt)}:${base64Encode(digest)}';
}
