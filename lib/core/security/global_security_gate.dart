import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivia_multiplatform/core/security/security_provider.dart';
import 'package:vivia_multiplatform/shared/widgets/fake_gps_alert.dart';
import 'package:vivia_multiplatform/core/navigation/navigation_service.dart';

/// Gate global que monitorea amenazas de seguridad persistentes (Fake GPS)
/// en toda la aplicación.
class GlobalSecurityGate extends StatelessWidget {
  final Widget child;

  const GlobalSecurityGate({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SecurityProvider>(
      builder: (context, security, _) {
        if (security.isFakeGpsDetected) {
          // Bloqueo inmediato en caso de Fake GPS
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final navContext = NavigationService.navigatorKey.currentContext;
            if (navContext != null) {
              FakeGpsAlert.show(navContext);
            }
          });
        }
        return child;
      },
    );
  }
}
