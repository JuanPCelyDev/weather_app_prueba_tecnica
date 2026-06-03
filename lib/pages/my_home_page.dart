import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/flavor_config.dart'; // Ajusta la ruta según tu proyecto

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Leemos la configuración del Flavor usando Riverpod
    final config = ref.watch(flavorConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(config.appName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Estas en el ambiente: ${config.appName}'),
            const SizedBox(height: 10),
            Text('API URL: ${config.baseUrl}'),
            const SizedBox(height: 10),
            Text('API Key cargada: ${config.apiKey}'),
          ],
        ),
      ),
    );
  }
}