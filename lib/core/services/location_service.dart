import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<String?> getCurrentLocationString() async {
    bool serviceEnabled;
    LocationPermission permission;

    // se agrega validación para confirmar si se tiene servicio de localización activo
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    // Se valida que tenga permisos activos
    permission = await Geolocator.checkPermission();

    // se piden permisos
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    // se retorna null si el usuario no acepta los permisos
    if (permission == LocationPermission.deniedForever) return null;

    try {
      // se obtiene la posición actual del usuario
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.low,),
      ).timeout(const Duration(seconds: 5), onTimeout: () {
        throw Exception('El GPS tardó demasiado en responder');
      });

      // se retorna latitud y longitud como pide el API
      return '${position.latitude},${position.longitude}';
    } catch (e) {
      // Si el GPS falla, se retorna null para que la app no se quede congelada
      return null;
    }
  }
}

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});