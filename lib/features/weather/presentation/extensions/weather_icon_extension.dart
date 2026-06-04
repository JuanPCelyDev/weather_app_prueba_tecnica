import 'package:flutter/material.dart';
import '../../domain/entities/weather_forecast.dart';

extension WeatherDayIcon on WeatherDay {
  IconData get weatherIcon {
    switch (icon) {
      case 'clear-day': return Icons.wb_sunny_rounded;
      case 'partly-cloudy-day': return Icons.wb_cloudy_rounded;
      case 'rain': return Icons.cloudy_snowing;
      case 'clear-night': return Icons.nights_stay_rounded;
      case 'snow': return Icons.ac_unit_rounded;
      case 'wind': return Icons.air_rounded;
      case 'cloudy': return Icons.cloud_rounded;
      case 'partly-cloudy-night': return Icons.cloudy_snowing;
      default: return Icons.wb_cloudy_rounded;
    }
  }
}