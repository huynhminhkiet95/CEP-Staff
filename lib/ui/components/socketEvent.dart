/// todo
class SocketIOEvent {
  /// Fired upon a connection including a successful reconnection.
  static const connect = 'connect';

  /// Fired upon a connection error.
  static const connectError = 'connect_error';

  /// Fired upon a connection timeout.
  static const connectTimeout = 'connect_timeout';

  /// Fired when an error occurs.
  static const error = 'error';

  /// todo
  static const connecting = 'connecting';

  /// Fired upon a successful reconnection.
  static const reconnect = 'reconnect';

  /// Fired upon a reconnection attempt error.
  static const reconnectError = 'reconnect_error';

  /// todo
  static const reconnectFailed = 'reconnect_failed';

  /// Fired upon an attempt to reconnect.
  static const reconnectAttempt = 'reconnect_attempt';

  /// Fired upon an attempt to reconnect.
  static const reconnecting = 'reconnecting';

  /// Fired when a ping packet is written out to the server.
  static const ping = 'ping';

  /// Fired when a pong is received from the server.
  static const pong = 'pong';

  static const notification = 'notification';

  static const clientRequest = 'client-request';
  static const server_response = 'server_response';
  static const update_fleetId = 'update_fleetId';
  
}
