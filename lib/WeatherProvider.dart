import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_1/WeatherController.dart';

final weatherControllerProvider = Provider<WeatherController>((ref) {
  return WeatherController();
});