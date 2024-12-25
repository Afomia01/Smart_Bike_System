import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Map<String, dynamic>> bikeStations = [
    {"name": "Station 1", "location": LatLng(9.0301, 38.7508)},
    {"name": "Station 2", "location": LatLng(9.0350, 38.7510)},
  ];

  LatLng bikeCurrentLocation = LatLng(9.0355, 38.7520); // Initial bike location

  // Simulate location updates (replace with real Arduino data via API or WebSocket)
  void updateBikeLocation(LatLng newLocation) {
    setState(() {
      bikeCurrentLocation = newLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.greenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FlutterMap(
          options: MapOptions(
            center: bikeCurrentLocation, // Center on Addis Ababa
            zoom: 18.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            // Bike Station Markers
            MarkerLayer(
              markers: bikeStations.map((station) {
                return Marker(
                  point: station["location"] as LatLng,
                  builder: (ctx) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF27EF9E),
                        size: 30.0,
                      ),
                      // Text(
                      //   station["name"],
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 9.0,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      //   textAlign: TextAlign.start,
                      // ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Real-Time Bike Marker
            MarkerLayer(
              markers: [
                Marker(
                  point: bikeCurrentLocation,
                  builder: (ctx) => const Icon(
                    Icons.directions_bike,
                    color: Colors.blue,
                    size: 30.0,
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
