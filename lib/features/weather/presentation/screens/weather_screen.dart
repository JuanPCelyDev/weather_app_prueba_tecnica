import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/controllers/weather_controller.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/extensions/weather_icon_extension.dart';

class WeatherScreen extends ConsumerWidget{
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = TextEditingController();
    final weatherState = ref.watch(weatherControllerProvider);


    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          controller: searchController,
          hintText: "Ej. Bogotá, Madrid...",
          leading: Icon(Icons.search),
          enabled: weatherState.isLoading ? false : true,
          onSubmitted: (String textIn){
            ref
                .read(weatherControllerProvider.notifier)
                .fetchWeather(textIn);
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Weather Flutter App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                // Acción al presionar Inicio
                Navigator.pop(context); // Cierra el menú
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favoritos'),
              onTap: () {
                // Acción al presionar Configuración
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Acerca de'),
              onTap: () {
                // Acción al presionar Configuración
                Navigator.pop(context);
              },
            ),
          ],
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