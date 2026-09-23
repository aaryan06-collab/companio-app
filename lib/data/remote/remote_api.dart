import 'companio_api.dart';
import 'server_client.dart';
import 'server_session.dart';

/// [CompanioApi] backed by the FastAPI server.
///
/// Requires a persisted [ServerSession] (JWT). When there is no session, or
/// the server cannot be reached, [push] throws so the sync queue keeps its
/// records pending and retries on the next sync tick — nothing is lost.
class RemoteApi implements CompanioApi {
  RemoteApi({
    required ServerClient server,
    required ServerSessionStore sessions,
    required String deviceId,
  }) : _server = server,
       _sessions = sessions,
       _deviceId = deviceId;

  final ServerClient _server;
  final ServerSessionStore _sessions;
  final String _deviceId;

  @override
  String get deviceId => _deviceId;

  ServerClient get server => _server;

  @override
  Future<bool> isReachable() => _server.isReachable();

  Future<ServerSession?> _session() async {
    if (!_server.enabled) return null;
    return _sessions.load();
  }

  @override
  Future<Set<String>> push(List<CompanioRecord> records) async {
    final session = await _session();
    if (session == null) {
      throw const ServerUnreachableException('No server session configured');
    }
    return _server.pushRecords(
      records,
      token: session.token,
      deviceId: _deviceId,
    );
  }

  @override
  Future<List<CompanioRecord>> pull() async {
    final session = await _session();
    if (session == null) {
      throw const ServerUnreachableException('No server session configured');
    }
    return _server.pullRecords(token: session.token, deviceId: _deviceId);
  }
}
