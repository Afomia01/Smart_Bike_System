import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherCard extends StatefulWidget {
  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String temperature = "--";
  String condition = "Loading...";
  String location = "Fetching...";
  String date = "Loading date...";

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    fetchCurrentDate();
  }

  Future<void> fetchWeatherData() async {
    const apiKey =
        'cafa1d069dfe43dbaca164146241912'; // Replace with your OpenWeatherMap API key
    const city = 'Addis Abeba'; // Replace with your desired city
    const apiUrl =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      pragma('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          temperature = '${data['current']['temp_c'].toStringAsFixed(1)}°C';
          condition = data['current']['condition']['text'];
          location = data['location']['name'];
        });
        print('location: $location');
      } else {
        setState(() {
          condition = "Error fetching data";
        });
      }
    } catch (e) {
      setState(() {
        condition = "Failed to fetch data";
      });
    }
  }

  void fetchCurrentDate() {
    final now = DateTime.now();
    setState(() {
      date =
          "${now.day} ${_getMonthName(now.month)}, ${_getWeekdayName(now.weekday)}";
    });
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    return weekdays[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 300,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.greenAccent, Colors.tealAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getWeatherIcon(
                    double.tryParse(temperature.replaceAll('°C', '')) ?? 0),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          temperature,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          condition,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        location,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                width: double.infinity,
                height: 53,
                decoration: BoxDecoration(
                  color: Color(0xFFd1ffef),
                  border: Border.all(color: Color(0xFFd1ffef), width: 1),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Text(
                  date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getWeatherIcon(double temp) {
  if (temp > 30) {
    return Icon(
      Icons.wb_sunny, // Hot weather icon
      color: Colors.orange,
      size: 80,
    );
  } else if (temp > 20) {
    return Icon(
      Icons.cloud, // Mild weather icon
      color: Colors.blue,
      size: 80,
    );
  } else if (temp > 10) {
    return Icon(
      Icons.cloud_queue, // Cool weather icon
      color: Colors.grey,
      size: 80,
    );
  } else {
    return Icon(
      Icons.ac_unit, // Cold weather icon
      color: Colors.lightBlueAccent,
      size: 80,
    );
  }
}
