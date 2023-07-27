import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'WeatherController.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  final _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/Assets/cloud_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _cityController,
                    style: TextStyle(color: Colors.white), // Text color for the input
                    decoration: InputDecoration(
                      hintText: 'Enter a city name',
                      hintStyle: TextStyle(color: Colors.white70), // Hint text color for the input
                      border: OutlineInputBorder(),
                      fillColor: Colors.white.withOpacity(0.2), // Transparent background for the input field
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await weatherController.fetchWeather(_cityController.text);
                    },
                    child: Text('Search'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Change the button color
                      onPrimary: Colors.white, // Change the text color on the button
                    ),
                  ),
                  SizedBox(height: 16),
                  Obx(() {
                    if (weatherController.isLoading) {
                      return CircularProgressIndicator();
                    } else if (weatherController.error.isNotEmpty) {
                      return Text(
                        weatherController.error,
                        style: TextStyle(color: Colors.red), // Change the error text color
                      );
                    } else if (weatherController.weather.cityName.isNotEmpty) {
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Forecast ${_cityController.text} weather:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Change the text color for the title
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 500,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                final forecast = weatherController.weather.forecast[index * 8];

                                return Card(
                                  color: Colors.grey[800], // Change the card background color
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          DateFormat('yyyy-MM-dd').format(forecast.date),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white, // Change the text color for the date
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${forecast.temperature}°C',
                                                style: TextStyle(
                                                  color: Colors.white, // Change the text color for temperature
                                                ),
                                              ),
                                              Text(
                                                forecast.description,
                                                style: TextStyle(
                                                  color: Colors.white, // Change the text color for description
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Image.network(
                                              'https://openweathermap.org/img/w/${forecast.iconCode}.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                          ),
                        ],
                      );
                    } else {
                      return Text(
                        'Enter a city name to get weather data',
                        style: TextStyle(color: Colors.white), // Change the text color for the message
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
