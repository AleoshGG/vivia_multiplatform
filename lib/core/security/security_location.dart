import 'package:geolocator/geolocator.dart';

class SecurityLocation {

  /// Evalúa la ubicación actual y retorna `true` si detecta un Fake GPS.
  /// Retorna `false` si es una ubicación real, o si no hay permisos/GPS activo.
  static Future<bool> isUsingFakeGps() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Verificar si el servicio de GPS está activado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // 2. Verificar permisos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    try {
      // 3. Obtener la posición actual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 4. Retornar si la ubicación es simulada
      return position.isMocked;
    } catch (e) {
      // Manejo de seguridad en caso de que la obtención de ubicación falle
      return false;
    }
  }
}