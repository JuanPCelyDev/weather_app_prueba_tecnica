class WeatherForecast {
  final String location;
  final String description;
  CurrentCondition? currentCondition;
  final List<WeatherDay> days;

  WeatherForecast({
    required this.location,
    required this.description,
    required this.days,
    this.currentCondition,
  });
}

class CurrentCondition {
  final String dateTime;
  final double temperature;
  final String conditions;
  final String icon;

  CurrentCondition({
    required this.dateTime,
    required this.temperature,
    required this.conditions,
    required this.icon,
  });
}

//Se crea una clase adicional para el clima de cada día
class WeatherDay {
  final String dateTime;
  final double maxTemperature;
  final double minTemperature;
  final double temperature;
  final String conditions;
  final String icon;
  final List<WeatherHour> hours;

  WeatherDay({
    required this.dateTime,
    required this.maxTemperature,
    required this.minTemperature,
    required this.temperature,
    required this.conditions,
    required this.hours,
    required this.icon,
  });
}

class WeatherHour {
  final String dateTime;
  final double temperature;
  final String conditions;
  final String icon;

  WeatherHour({
    required this.dateTime,
    required this.temperature,
    required this.conditions,
    required this.icon,
  });
}
