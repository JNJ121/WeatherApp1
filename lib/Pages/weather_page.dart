import 'package:flutter/material.dart';
import 'package:weatherapp/Services/weather_service.dart';
import 'package:weatherapp/models/weather_models.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('7ad627e2a30483e558c875d5d942c8d1');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weaher for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch (e) {
      print(e);
    }
  }

  // weather animations
  //hi
  // init state
  void initSate() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // city name
        Text(_weather?.cityName ?? "loading city.."),

        //temperature
        Text('${_weather?.temperature.round()}°C')
      ],
    )));
  }
}
