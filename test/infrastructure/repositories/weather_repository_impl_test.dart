import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_prueba_tecnica/features/weather/data/datasources/weather_data_source.dart';
import 'package:weather_app_prueba_tecnica/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app_prueba_tecnica/features/weather/data/models/weather_forecast_model.dart';
import 'package:weather_app_prueba_tecnica/features/weather/data/repositories/weather_repository_impl.dart';

class MockWeatherDataSource extends Mock implements WeatherDataSource {}
class MockWeatherLocalDataSource extends Mock implements WeatherLocalDataSource {}

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherDataSource mockRemoteDataSource;
  late MockWeatherLocalDataSource mockLocalDataSource;

  // Datos de prueba
  final tWeatherModel = WeatherForecastModel(
    location: 'Bogota',
    description: 'Nublado',
    days: [],
    currentCondition: null,
  );

  final tLocation = 'Bogota';
  final tCacheKey = 'weather_location_bogota';

   //Reinicio
  setUp(() {
    mockRemoteDataSource = MockWeatherDataSource();
    mockLocalDataSource = MockWeatherLocalDataSource();
    repository = WeatherRepositoryImpl(
      weatherDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('getWeatherByLocation -', () {

    test('Debe retornar datos remotos y guardarlos en caché cuando la API responde con éxito', () async {
      when(() => mockRemoteDataSource.getWeatherForecast(tLocation))
          .thenAnswer((_) async => tWeatherModel);
      when(() => mockLocalDataSource.cacheWeather(any(), any()))
          .thenAnswer((_) async => true);
      final result = await repository.getWeatherByLocation(tLocation);
      expect(result, tWeatherModel);
      verify(() => mockRemoteDataSource.getWeatherForecast(tLocation)).called(1);
      verify(() => mockLocalDataSource.cacheWeather(tCacheKey, any())).called(1);
    });


    test('Debe retornar los datos del caché local cuando la API falla (Modo Offline exitoso)', () async {
      when(() => mockRemoteDataSource.getWeatherForecast(tLocation))
          .thenThrow(Exception('Error de red'));
      final fakeJsonString = json.encode({
        'resolvedAddress': 'Bogota',
        'description': 'Nublado',
        'days': [],
        'currentConditions': null
      });
      when(() => mockLocalDataSource.getLastCachedWeather(tCacheKey))
          .thenAnswer((_) async => fakeJsonString);
      final result = await repository.getWeatherByLocation(tLocation);
      expect(result, isA<WeatherForecastModel>());
      expect(result.location, 'Bogota');
      verify(() => mockRemoteDataSource.getWeatherForecast(tLocation)).called(1);
      verify(() => mockLocalDataSource.getLastCachedWeather(tCacheKey)).called(1);
    });


    test('Debe lanzar una Excepción cuando la API falla y NO hay nada en el caché local', () async {
      when(() => mockRemoteDataSource.getWeatherForecast(tLocation))
          .thenThrow(Exception('Error de red'));
      when(() => mockLocalDataSource.getLastCachedWeather(tCacheKey))
          .thenAnswer((_) async => null);
      expect(
            () => repository.getWeatherByLocation(tLocation),
        throwsA(isA<Exception>()),
      );
    });
  });
}