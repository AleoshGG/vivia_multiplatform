import 'package:flutter/material.dart';
import 'session_timeout_service.dart';

class UserActivityDetector extends StatelessWidget {
  final Widget child;
  const UserActivityDetector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => SessionTimeoutService().resetActivity(),
      onPointerMove: (_) => SessionTimeoutService().resetActivity(),
      child: child,
    );
  }
}