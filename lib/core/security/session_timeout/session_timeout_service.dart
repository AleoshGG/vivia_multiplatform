import 'dart:async';
import 'package:flutter/material.dart';
import 'session_timeout_config.dart';

class SessionTimeoutService {
  static final SessionTimeoutService _instance = SessionTimeoutService._internal();
  factory SessionTimeoutService() => _instance;
  SessionTimeoutService._internal();

  Timer? _timer;
  bool _isActive = false;
  VoidCallback? _onTimeout;

  void start({required VoidCallback onTimeout}) {
    _onTimeout = onTimeout;
    _isActive = true;
    _resetTimer();
  }

  void resetActivity() {
    if (!_isActive) return;
    _resetTimer();
  }

  void stop() {
    _isActive = false;
    _timer?.cancel();
    _timer = null;
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(SessionTimeoutConfig.timeoutDuration, _handleTimeout);
  }

  void _handleTimeout() {
    if (!_isActive) return;
    stop();
    _onTimeout?.call();
  }
}