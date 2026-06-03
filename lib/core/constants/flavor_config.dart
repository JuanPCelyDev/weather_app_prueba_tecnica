import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../flavors.dart';
class FlavorConfig {
  final String baseUrl;
  final String apiKey;
  final String appName;

  FlavorConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.appName});
}

final flavorConfigProvider = Provider<FlavorConfig>((ref){
  return FlavorConfig(
      baseUrl: F.baseUrl,
      apiKey: F.apiKey,
      appName: F.title,
  );
});