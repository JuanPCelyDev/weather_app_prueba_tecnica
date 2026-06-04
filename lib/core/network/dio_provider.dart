import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/flavor_config.dart';


final dioProvider = Provider<Dio> ((ref) {

  //Se lee la configuración actual
  final config = ref.watch(flavorConfigProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }

    )
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        //parametros que serán agregados por el interceptor de manera automática
        options.queryParameters.addAll({
          'key': config.apiKey,
          'lang': 'es',   //Esto se realiza para el requerimiento de mostrar los datos en idioma español
          'unitGroup': 'metric', //Esto se realiza para el requerimiento de medidas de sistema metrico
        });
       return handler.next(options);
      },

      onResponse: (response, handler){
        return handler.next(response);
      },

      onError: (DioException e, handler ){
        return handler.next(e);
      }
    )
  );
  return dio;
});