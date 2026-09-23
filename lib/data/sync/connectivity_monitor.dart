import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Monitors connectivity and exposes a calming `Stream<bool>`.
///
/// The app treats "offline" as a normal, safe state — the stream only drives
/// when synchronization is attempted, it never gates core functionality.
class ConnectivityMonitor {
  ConnectivityMonitor({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _sub;
  StreamController<bool>? _controller;

  bool _last = false;
  bool get isOnline => _last;

  Stream<bool> get onlineStream {
    _controller ??= StreamController<bool>.broadcast();
    return _controller!.stream;
  }

  Future<bool> check() async {
    try {
      final results = await _connectivity.checkConnectivity();
      final online = _interpret(results);
      _last = online;
      return online;
    } catch (_) {
      _last = false;
      return false;
    }
  }

  void start() {
    if (_sub != null) return;
    _sub = _connectivity.onConnectivityChanged.listen((results) {
      final online = _interpret(results);
      if (online != _last) {
        _last = online;
        _controller?.add(online);
      }
    });
  }

  void stop() {
    _sub?.cancel();
    _sub = null;
  }

  void _emit(bool value) => _controller?.add(value);

  bool _interpret(List<ConnectivityResult> results) {
    if (results.isEmpty) return true;
    return results.any(
      (r) =>
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.ethernet ||
          r == ConnectivityResult.vpn,
    );
  }

  void debugEmit(bool online) {
    _last = online;
    _emit(online);
  }
}
