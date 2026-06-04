class WeatherForecast {
  final String location;
  final String description;
  final List<WeatherDay> days;


  WeatherForecast({
    required this.location,
    required this.description,
    required this.days,
});

}

class currentCondicion{
  final String  dateTime;
  final double temperature;
  final double conditions;
  final String icon;

  currentCondicion({
    required this.dateTime,
    required this.temperature,
    required this.conditions,
    required this.icon
  });
}


//Se crea una clase adicional para el clima de cada día
class WeatherDay {
  final String dateTime;
  final double maxTemperature;
  final double minTemperature;
  final double temperature;
  final double humidity;
  final String conditions;
  final String icon;



  WeatherDay({
    required this.dateTime,
    required this.maxTemperature,
    required this.minTemperature,
    required this.temperature,
    required this.humidity,
    required this.conditions,
    required this.icon});
}
