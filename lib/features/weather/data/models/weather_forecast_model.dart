import '../../domain/entities/weather_forecast.dart';

class WeatherForecastModel extends WeatherForecast{
  WeatherForecastModel({
    required super.location,
    required super.description,
    required super.days});

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json){
    return WeatherForecastModel(
    location: json['resolvedAddress'] ?? '',
    description: json['description'] ?? '',
    days: (json['days'] as List? ?? [])
    .map((day) => WeatherDayModel.fromJson(day))
    .toList());
  }
}

class WeatherDayModel extends WeatherDay {
  WeatherDayModel({
    required super.dateTime,
    required super.maxTemperature,
    required super.minTemperature,
    required super.temperature,
    required super.humidity,
    required super.conditions,
    required super.icon});

  factory WeatherDayModel.fromJson(Map<String, dynamic> json){
    return WeatherDayModel(
        dateTime: json['datetime'] ?? '',
        maxTemperature: (json['tempmax'] as num? ?? 0).toDouble(),
        minTemperature: (json['tempmin'] as num? ?? 0).toDouble(),
        temperature: (json['temp'] as num? ?? 0).toDouble(),
        humidity: (json['humidity'] as num? ?? 0).toDouble(),
        conditions: json['conditions']?? '',
        icon: json['icon']?? '');
  }

}