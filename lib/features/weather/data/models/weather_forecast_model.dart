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
    currentCondition: json['currentConditions'] != null ? WeatherCurrenConditionModel.fromJson(
      json['currentConditions'] as Map<String, dynamic>,
    ) : null
    );

  }

  Map<String, dynamic> toJson() {
    return {
      'resolvedAddress' : location,
      'description': description,
      'days' : days.map((day) => (day as WeatherDayModel).toJson()).toList(),
      'currentConditions': (currentCondition as WeatherCurrenConditionModel?)?.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'datetime' : dateTime,
      'temp': temperature,
      'conditions': conditions,
      'icon': icon,
    };
  }

}
class WeatherDayModel extends WeatherDay {
  WeatherDayModel({
    required super.dateTime,
    required super.maxTemperature,
    required super.minTemperature,
    required super.temperature,
    required super.conditions,
    required super.hours,
    required super.icon});

  factory WeatherDayModel.fromJson(Map<String, dynamic> json){
    return WeatherDayModel(
        dateTime: json['datetime'] ?? '',
        maxTemperature: (json['tempmax'] as num? ?? 0).toDouble(),
        minTemperature: (json['tempmin'] as num? ?? 0).toDouble(),
        temperature: (json['temp'] as num? ?? 0).toDouble(),
        conditions: json['conditions'] ?? '',
        hours: (json['hours'] as List? ?? [])
        .map((hour) => WeatherHourModel.fromJson(hour))
        .toList(),
        icon: json['icon']?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'datetime' : dateTime,
      'tempmax' : maxTemperature,
      'tempmin' : minTemperature,
      'temp': temperature,
      'conditions': conditions,
      'hours': hours.map((hour) => (hour as WeatherHourModel).toJson()).toList(),
      'icon': icon,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'datetime' : dateTime,
      'temp': temperature,
      'conditions': conditions,
      'icon': icon,
    };
  }

}