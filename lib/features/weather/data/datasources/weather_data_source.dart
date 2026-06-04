import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/weather_forecast_model.dart';

abstract class WeatherDataSource {
  Future<WeatherForecastModel> getWeatherForecast(String location);
}

class WeatherDataSourceImplm extends WeatherDataSource{
  final Dio _dio;

  WeatherDataSourceImplm(this._dio);

  @override
  Future<WeatherForecastModel> getWeatherForecast(String location) async {
    try{
      final response = await _dio.get('/$location');

      if(response.statusCode == 200 && response.data != null){
        return WeatherForecastModel.fromJson(response.data);
      }else {
        throw Exception('Error al obtener los datos del clima');
      }
    }on DioException catch(e){
      throw Exception('Fallo en la petición de red: ${e.message}');
    }
  }
}

//Se crea provider que buscara el cliente HTTP en dio_provider y se lo pasa a WeatherDataSourceImplm
final weatherDataSourceProvider = Provider<WeatherDataSource>((ref){
  final dio = ref.watch(dioProvider);

  return WeatherDataSourceImplm(dio);
});