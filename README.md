# Weather App - Prueba Técnica

Una aplicación móvil para consultar el pronóstico del clima, 
construida con **Flutter** bajo los principios de **Arquitectura Limpia (Clean Architecture)**. 
El proyecto cuenta con soporte multi-entorno (**Flavors**), 
manejo de estado reactivo con **Riverpod**, 
una estrategia robusta de **caché offline-first** y 
**pruebas automatizadas** (unitarias y de widgets).

---

## 📌 Características Principales

- **Búsqueda en Tiempo Real:** Consulta del clima detallado de cualquier ubicación mediante integración con API de visualcrossing.
- **Últimos 5 días** Consulta el detalle de los ultimos 5 días de cualquier ubicación mediante integración con API de visualcrossing
- **Modo Offline:** Sistema de almacenamiento local. Si el usuario pierde la conexión a internet, la aplicación recupera instantáneamente el último 
clima consultado.
- **Monitoreo de Conectividad Global:** Integración de un banner dinámico (`GlobalConnectivityBanner`) que notifica al usuario en tiempo real los cambios en el estado de su red.
- **Arquitectura de Grado de Producción:** Estricta separación de responsabilidades para garantizar un código mantenible, desacoplado y altamente testeable.

---

## Arquitectura del Proyecto

El proyecto sigue los lineamientos de **Clean Architecture**, dividiendo el código en capas independientes

```text
lib/
│
├── core/                           # Configuraciones globales, temas, widgets comunes y utilidades
│   ├── flavors.dart                # Configuración de entornos de ejecución (Flavors)
│   ├── connectivity_provider.dart    # Provider para validar estado de conexión del usuario
│   ├── constants/
│   │    └── flavor_config.dart      # Modelo y proveedor de configuración de variables de entorno (BaseURL, API Key)
│   ├── network/
│   │    └── dio_provider.dart       # Configuración del cliente HTTP
│   ├──widgets/
│   │    └── connectivity_banner.dart # Banner global de conectividad reactivo
│   └──services/
│       └── location_service.dart    # Configurucación de permisos y localización del usuario
│
├── features/                       # Arquitectura estructurada por características (Feature-First)
│   └── weather/                    # Módulo independiente encargado de la lógica de clima
│       │
│       ├── data/                   # Capa de Datos (Infraestructura, APIs y Persistencia Local)
│       │   ├── datasources/        # Fuentes de datos crudos (Remoto con API y Local con Caché)
│       │   │   ├── weather_data_source.dart
│       │   │   └── weather_local_data_source.dart
│       │   ├── models/             # Data Transfer Objects (DTOs) y serialización (JSON Parsing)
│       │   │   └── weather_forecast_model.dart
│       │   └── repositories/       # Implementación concreta del contrato del repositorio (Une API + Caché)
│       │       └── weather_repository_impl.dart
│       │
│       ├── domain/                 # Capa de Dominio
│       │   ├── entities/           # Modelos de negocio 
│       │   │   └── weather_forecast.dart
│       │   └── repositories/       # Contratos/Interfaces abstractas
│       │       └── weather_repository.dart
│       │
│       └── presentation/           # Capa de Presentación (Interfaz de usuario y gestión de estado reactivo)
│           ├── controllers/        # Controladores de estado (Riverpod Notifiers) encargados de la lógica visual
│           │   ├── favorites_controller.dart
│           │   ├── weather_controller.dart
│           │   └── weather_last_days_controller.dart
│           ├── extensions/         # Extensiones de Dart para formateo estético y mapeo de íconos según clima
│           │   ├── weather_day_icon_extension.dart
│           │   ├── weather_hour_icon_extension.dart
│           │   └── weather_icon_extension.dart
│           ├── screens/            # Vistas principales y completas del módulo
│           │   ├── weather_last_days_screen.dart
│           │   └── weather_screen.dart
│           └── widgets/            # Componentes visuales modulares y reutilizables
│               ├── weather_carousel_card.dart
│               ├── weather_day_card.dart
│               └── weather_info_card.dart
```
🛠️ Tecnologías y Paquetes Utilizados
Flutter SDK
- **Flutter Riverpod (^3.3.1)**: Para el manejo de estado global, inyección de dependencias reactiva y control de flujos asíncronos.
- **Dio(^5.9.2)** Cliente HTTP avanzado elegido por su robustez, soporte nativo para interceptores, manejo eficiente de errores y facilidad de configuración
- **Connectivity Plus (^7.1.1)**: Para el monitoreo constante del estado de red en el dispositivo.
- **Mocktail**: Para la creación de Mocks deterministas y robustos en la suite de pruebas.
- **Flutter Test SDK**: Framework base de testing para pruebas unitarias y de widgets.
- **shared_preferences(^2.5.5)**:Utilizado para persistir de forma rápida y eficiente las estructuras JSON del clima, permitiendo la resiliencia offline de la app y capturar los datos de favoritos.
- **geolocator(^14.0.2)**: Encargado de la gestión de permisos nativos y de la obtención precisa de las coordenadas geográficas
- **jiffy(^6.4.5)**: Librería especializada elegida para la manipulación, traducción y formateo estético de fechas y horas
- **flutter_flavorizr(^2.5.0)** Herramienta de automatización empleada para generar y configurar de forma limpia los Flavors nativos tanto en Android (Gradle) como en iOS (XCode Schemes)


##Configuración del API Key (Paso Obligatorio)

Para que la aplicación pueda consultar los datos del clima en tiempo real, es necesario configurar un API Key visualcrossing.

Por motivos de seguridad, las credenciales no están hardcodeadas en el repositorio. Sigue estos pasos para configurarla:

1. Abre el archivo de configuración del Flavor lib/core/flavors.dart
2. Localiza la variable API_KEY_DEV para entorno desarrollo o API_KEY_PROD para entorno producción
3. Reemplaza el valor de prueba por tu API Key personal:
   ```dart
   // Ejemplo en lib/core/flavors.dart
   static String get apiKey{
    switch (appFlavor) {
      case Flavor.dev:
        return API_KEY_DEV; // 👈 Inserta tu llave aquí
      case Flavor.prod:
        return API_KEY_PROD;
    }
Guía de Comandos Requeridos

Ejecutar en Entorno de Desarrollo (Recomendado para revisar la prueba):
- flutter run --flavor dev

Ejecutar en Entorno de Producción:
- flutter run --flavor prod

Ejecución y Control de Pruebas (Testing)
- flutter test

Instalar dependencias 
- flutter pub get

