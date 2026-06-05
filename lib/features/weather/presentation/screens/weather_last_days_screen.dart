
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/controllers/weather_last_days_controller.dart';
import '../controllers/weather_controller.dart';
import '../extensions/weather_day_icon_extension.dart';

class WeatherLastDaysScreen extends ConsumerWidget{
  const WeatherLastDaysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = TextEditingController();
    final weatherState = ref.watch(weatherLastDaysControllerProvider);


    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          controller: searchController,
          hintText: "Ej. Bogotá, Madrid...",
          leading: Icon(Icons.search),
          enabled: weatherState.isLoading ? false : true,
          onSubmitted: (String textIn){
            ref
                .read(weatherLastDaysControllerProvider.notifier)
                .fetchWeatherDays(textIn, '5');
          },
        ),
      ),
      body: Padding(padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Expanded(child: weatherState.when(
                data: (weather){
                  if(weather == null){
                    return const Center(
                      child: Text("Ingresa una ubicación para ver el clima"),
                    );
                  }

                  return  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        weather.location,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weather.description,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Expanded(

                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: weather.days.length,
                              itemBuilder: (context, index){
                                final day = weather.days[index];
                                return ListTile(
                                  leading: Icon(day.weatherIcon,
                                    color: Colors.green,),
                                  title: Text('${day.temperature}°C - min ${day.minTemperature} °C - max ${day.maxTemperature} °C'),
                                  subtitle: Text('${day.conditions}  ${day.conditions}'),

                                );
                              })
                      ),
                    ],
                  );

                },
                error: (error, _) => Center(
                  child: Text(
                    'Algo salio mal: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                loading:() => const Center(child: CircularProgressIndicator(),))
            ),

          ],
        ),
      ),

    );
  }
  }


