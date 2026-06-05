import '../entities/weather_forecast.dart';

abstract class WeatherRepository {
  Future<WeatherForecast> getWeatherByLocation(String location);
  Future<WeatherForecast> getWeatherLastDays(String location, String days);
}