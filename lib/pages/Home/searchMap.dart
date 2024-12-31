import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapWithRoute extends StatefulWidget {
  @override
  _MapWithRouteState createState() => _MapWithRouteState();
}

class _MapWithRouteState extends State<MapWithRoute> {
  final LatLng startPoint = LatLng(9.0301, 38.7508); // Example start
  final LatLng endPoint = LatLng(9.0350, 38.7510); // Example end
  List<LatLng> routePoints = []; // Points for the polyline route
  double? distance; // Distance in kilometers
  double? duration; // Duration in minutes
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRoute(); // Fetch the route on initialization
  }

  Future<void> fetchRoute() async {
    const String apiKey =
        '5b3ce3597851110001cf6248b38dd87ca9b24bab9012393904a1fe25'; // Replace with your API key
    final String url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${startPoint.longitude},${startPoint.latitude}&end=${endPoint.longitude},${endPoint.latitude}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final properties = data['features'][0]['properties'];
        final List<dynamic> coordinates =
            data['features'][0]['geometry']['coordinates'];

        // Convert coordinates to LatLng format
        setState(() {
          routePoints = coordinates
              .map((coord) => LatLng(coord[1], coord[0])) // Swap lat/lng
              .toList();
          distance = properties['segments'][0]['distance'] /
              1000; // Convert to kilometers
          duration =
              properties['segments'][0]['duration'] / 60; // Convert to minutes
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch route: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching route: $e');
      setState(() {
        isLoading = false; // Stop loading even if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Asset 1.png',
          fit: BoxFit.contain,
          height: 50, // Adjust logo size as needed
        ),
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF0BB4E3), // Reverse the gradient colors
                Color(0xFF27EF9E),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : FlutterMap(
              options: MapOptions(
                center: startPoint,
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: startPoint,
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        color: Colors.green,
                        size: 30.0,
                      ),
                    ),
                    Marker(
                      point: endPoint,
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
                if (routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routePoints,
                        color: Colors.teal,
                        strokeWidth: 4.0,
                      ),
                    ],
                  ),
              ],
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.greenAccent, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Per 30 mins",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "\$0.50",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Distance",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  distance != null
                      ? "${distance!.toStringAsFixed(2)} km"
                      : "0 km",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Estimated Time",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  duration != null
                      ? "${duration!.toStringAsFixed(2)} mins"
                      : "0 mins",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
