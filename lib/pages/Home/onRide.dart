import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:myapp/services/database.dart';
import 'payment.dart';

class BikeRideTracker extends StatefulWidget {
  @override
  _BikeRideTrackerState createState() => _BikeRideTrackerState();
}

class _BikeRideTrackerState extends State<BikeRideTracker> {
  final LatLng startPoint = LatLng(9.0301, 38.7508); // Starting point
  final LatLng currentLocation = LatLng(9.0320, 38.7515); // Current location
  double totalDistance = 0.0; // Total distance covered
  final Distance distance = Distance();

  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  void _calculateDistance() {
    // Calculate the distance between the start and current location
    setState(() {
      totalDistance = distance.as(
        LengthUnit.Meter,
        startPoint,
        currentLocation,
      );
    });
  }

  Future<void> _finishRide() async {
    String bikeId = 'bike123'; // Replace with the actual bike ID
    String newStatus = 'locked'; // New status for the bike lock
    String newCommand = 'unlock'; // New command for the bike lock

    // Update the bike lock status in Firestore
    await DatabaseService().updateBikeLock(bikeId, newStatus, newCommand);

    // Show a Snackbar to inform the user that the ride has finished
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Ride Finished!"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Delay for a short period to allow the Snackbar to be visible
    await Future.delayed(Duration(seconds: 2));

    // Navigate to the PaymentPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
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
      body: Stack(
        children: [
          // Map
          FlutterMap(
            options: MapOptions(
              center: LatLng(9.0310, 38.7510), // Center of the map
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
                  // Marker for the starting location
                  Marker(
                    point: startPoint,
                    builder: (ctx) => Column(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xFF313165),
                          size: 20.0,
                        ),
                        Text(
                          "Start",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 7.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: currentLocation,
                    radius: 15, // Circle radius in meters
                    color: Colors.cyan.withOpacity(0.3),
                  ),
                ],
              ),
            ],
          ),
          // Bottom UI
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF27EF9E), Color(0xFF0BB4E3)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Bike Image
                    Image.asset(
                      'assets/images/Bitmap.png',
                      height: 100.0,
                      width: 100.0,
                    ),
                    // Distance Text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Distance",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        Text(
                          "${totalDistance.toStringAsFixed(2)} m",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Finish Button
                    ElevatedButton(
                      onPressed: _finishRide,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8debde),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text("Finish"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
