import '../../domain/entities/weather_forecast.dart';

class WeatherForecastModel extends WeatherForecast{
  WeatherForecastModel({
    required super.location,
    required super.description,
    required super.days,
    required super.currentCondition,
    });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json){
    return WeatherForecastModel(
    location: json['resolvedAddress'] ?? '',
    description: json['description'] ?? '',
    days: (json['days'] as List? ?? [])
    .map((day) => WeatherDayModel.fromJson(day))
    .toList(),
    currentCondition: WeatherCurrenConditionModel.fromJson(
      json['currentConditions'] as Map<String, dynamic>,
    ),
    );

  }
}


class WeatherCurrenConditionModel extends CurrentCondition{
  WeatherCurrenConditionModel({
    required super.dateTime,
    required super.temperature,
    required super.conditions,
    required super.icon});

  factory WeatherCurrenConditionModel.fromJson(Map<String, dynamic> json){
    return WeatherCurrenConditionModel(
        dateTime: json['datetime'] ?? '',
        temperature: (json['temp'] as num? ?? 0).toDouble(),
        conditions: json['conditions'] ?? '',
        icon: json['icon'] ?? '');
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
    required super.hours,
    required super.icon});

  factory WeatherDayModel.fromJson(Map<String, dynamic> json){
    return WeatherDayModel(
        dateTime: json['datetime'] ?? '',
        maxTemperature: (json['tempmax'] as num? ?? 0).toDouble(),
        minTemperature: (json['tempmin'] as num? ?? 0).toDouble(),
        temperature: (json['temp'] as num? ?? 0).toDouble(),
        humidity: (json['humidity'] as num? ?? 0).toDouble(),
        conditions: json['conditions'] ?? '',
        hours: (json['hours'] as List? ?? [])
        .map((hour) => WeatherHourModel.fromJson(hour))
        .toList(),
        icon: json['icon']?? '');
  }

}

class WeatherHourModel extends WeatherHour{
  WeatherHourModel({
    required super.dateTime,
    required super.temperature,
    required super.conditions,
    required super.icon});


  factory WeatherHourModel.fromJson(Map<String, dynamic> json){
    return WeatherHourModel(
        dateTime: json['datetime'] ?? '',
        temperature: (json['temp'] as num? ?? 0).toDouble(),
        conditions: json['conditions']?? '',
        icon: json['icon'] ?? '');
  }

}