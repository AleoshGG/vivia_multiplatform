import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SecurityProvider with ChangeNotifier {
  bool _isFakeGpsDetected = false;
  StreamSubscription<Position>? _positionSubscription;

  bool get isFakeGpsDetected => _isFakeGpsDetected;

  SecurityProvider() {
    _initSecurityTracking();
  }

  Future<void> _initSecurityTracking() async {
    // 1. Verificar si el servicio está activo y tenemos permisos
    bool hasPermissions = await _handlePermissions();
    if (!hasPermissions) return;

    // 2. Iniciar escucha reactiva de la ubicación
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0, // Detectar cualquier cambio, por mínimo que sea
      ),
    ).listen(
      (Position position) {
        _validatePosition(position);
      },
      onError: (error) {
        // En caso de error (ej. desactivan el GPS), podríamos marcar como seguro 
        // o manejar según la política de la empresa.
        debugPrint('Error en el stream de seguridad: $error');
      },
    );
  }

  Future<bool> _handlePermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }
    
    if (permission == LocationPermission.deniedForever) return false;

    return true;
  }

  void _validatePosition(Position position) {
    if (_isFakeGpsDetected != position.isMocked) {
      _isFakeGpsDetected = position.isMocked;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }
}
