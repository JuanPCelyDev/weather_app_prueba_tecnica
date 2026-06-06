import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/controllers/weather_last_days_controller.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/widgets/weather_day_card.dart';
import '../controllers/weather_controller.dart';
import '../extensions/weather_day_icon_extension.dart';
import '../extensions/weather_icon_extension.dart';
import '../widgets/weather_info_card.dart';


class WeatherLastDaysScreen extends ConsumerStatefulWidget {
  const WeatherLastDaysScreen({super.key});

  @override
  ConsumerState<WeatherLastDaysScreen> createState() => _WeatherLastDaysScreenState();
}
class _WeatherLastDaysScreenState extends ConsumerState<WeatherLastDaysScreen> {

  late final TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentHomeWeather = ref.read(weatherControllerProvider).value;

      if (currentHomeWeather != null) {
        searchController.text = currentHomeWeather.location;
        ref.read(weatherLastDaysControllerProvider.notifier)
            .fetchWeatherDays(currentHomeWeather.location, '4');
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final weatherState = ref.watch(weatherControllerProvider);
    final weatherStateLastDays = ref.watch(weatherLastDaysControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Últimos 5 días'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
              child: SearchBar(
          controller: searchController,
          hintText: "Ej. Bogotá, Madrid...",
          leading: Icon(Icons.search),
          enabled: weatherStateLastDays.isLoading ? false : true,
          onSubmitted: (String textIn) {
            ref.read(weatherControllerProvider.notifier).fetchWeather(textIn);
            ref
                .read(weatherLastDaysControllerProvider.notifier)
                .fetchWeatherDays(textIn, '4');
          },
        ),
            ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            weatherState.when(
                data: (weather) {
                  if (weather == null) {
                    return const Center(
                      child: Text("Ingresa una ubicación para ver el clima"),
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Text(
                        weather.location,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WeatherInfoCard(
                          title: weather.currentCondition!.conditions,
                          temperature: '${weather.currentCondition!.temperature}°C',
                          rangetemp: 'min ${weather.days.first.minTemperature}°C - max ${weather.days.first.maxTemperature}°C',
                          timeInfo: weather.currentCondition!.dateTime,
                          icon: Icon(weather.currentCondition!.weatherIcon)
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Últimos 5 días',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),                    ],
                  );
                },
                error: (error, _) => Center(
                  child: Text(
                    'Algo salio mal: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            Expanded(
              child: weatherStateLastDays.when(
                data: (weather) {
                  if (weather == null) {
                    return SizedBox.shrink();
                  }

                  return
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: weather.days.length,
                          itemBuilder: (context, index) {
                            final day = weather.days[index];
                            return WeatherDayCard(
                                dateTime: day.dateTime,
                                description: day.conditions,
                                temperature: day.temperature.toString(),
                                maxTemperature: day.maxTemperature.toString(),
                                minTemperature: day.minTemperature.toString(),
                                icon: day.weatherIcon);
                          },
                        ),
                      );
                },
                error: (error, _) => Center(
                  child: Text(
                    'Algo salio mal: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
