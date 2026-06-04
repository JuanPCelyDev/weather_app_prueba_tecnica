import '../../domain/entities/weather_forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherRepositoryImpl extends WeatherRepository {

  final WeatherDataSource _weatherDataSource;
  WeatherRepositoryImpl(this._weatherDataSource);

  @override
  Future<WeatherForecast> getWeather(String location) async {
    final weatherModel = await _weatherDataSource.getWeatherForecast(location);
    return weatherModel;
  }

}

final weatherRepositoryProvider = Provider<WeatherRepository>((ref){
  final dataSource = ref.watch(weatherDataSourceProvider);
  return WeatherRepositoryImpl(dataSource);
});