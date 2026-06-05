import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/controllers/weather_controller.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/extensions/weather_hour_icon_extension.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/extensions/weather_icon_extension.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/screens/weather_last_days_screen.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/widgets/weather_carousel_card.dart';
import 'package:weather_app_prueba_tecnica/features/weather/presentation/widgets/weather_info_card.dart';
import '../../../../core/flavors.dart';
import '../controllers/favorites_controller.dart';

class WeatherScreen extends ConsumerWidget{
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = TextEditingController();
    final weatherState = ref.watch(weatherControllerProvider);
    final favorites = ref.watch(favoritesProvider);


    return Scaffold(
      appBar: AppBar(
        title: Text('App Clima Flutter ${F.title}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
            child: SearchBar(
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
              leading: Icon(Icons.search),
              title: Text('Ultimos 5 días'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherLastDaysScreen()),
                );
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
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
        child: Column(
          children: [
            favorites.isEmpty ? const Center(
              child: Text(
                'Aún no tienes ciudades favoritas.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : SizedBox(
              height: 120,
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final location = favorites[index];
                final current = location.currentCondition;
                return WeatherCarouselCard(
                    title: location.location,
                    description: current.conditions,
                    temperature: current.temperature.toString(),
                    icon: current.weatherIcon,
                    color: Colors.white,
                );
              },
            ),
            ),
            Expanded(child: weatherState.when(
                data: (weather){
                  final isFavorite = favorites.any((fav) => fav.location == weather?.location);
                  if(weather == null){
                    return const Center(
                      child: Text("Ingresa una ubicación para ver el clima"),
                    );
                  }

                  return  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text(
                            weather.location,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.star : Icons.star_border,
                              color: isFavorite ? Colors.amber : Colors.grey,
                              size: 32,
                            ),
                            onPressed: () {
                              // agregar o quitar de favoritos
                              ref.read(favoritesProvider.notifier).toggleFavorite(weather);
                            },
                          ),
                        ],
                        ),
                        WeatherInfoCard(
                            title: weather.currentCondition.conditions,
                            temperature: '${weather.currentCondition.temperature}°C',
                            rangetemp: 'min ${weather.days.first.minTemperature}°C - max ${weather.days.first.maxTemperature}°C',
                            timeInfo: weather.currentCondition.dateTime,
                            icon: Icon(weather.currentCondition.weatherIcon)
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                           height: 150,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: weather.days.first.hours.length,
                                itemBuilder: (context, index){
                                  final hour = weather.days.first.hours[index];
                                  return WeatherCarouselCard(
                                      title: hour.dateTime,
                                      description: hour.conditions,
                                      temperature: hour.temperature.toString(),
                                      icon: hour.weatherIcon,
                                      color: Colors.blue);
                                })

                        )
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