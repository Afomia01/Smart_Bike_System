import 'package:flutter/material.dart';
import '../pages/weather.dart';
import '../pages/map.dart';
import '../pages/search.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22.0, 44.0, 22.0, 22.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF27EF9E), Color(0xFF0BB4E3)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen()),
                            );
                          },
                          icon: Icon(Icons.search,
                              color: Colors.black, size: 35)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Hello John',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Wanna take a ride today?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  WeatherCard(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Nearby Bikes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Browse Map',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapScreen()),
                          );
                        },
                        icon: Icon(Icons.arrow_forward_ios,
                            color: Colors.black, size: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: 322,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
                        child: Column(
                          children: [
                            Image(
                                image: AssetImage('assets/images/Bitmap.png')),
                            SizedBox(height: 20),
                            Container(
                              width: 196,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF27EF9E),
                                    Color(0xFF0BB4E3)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.0, 1.0],
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Distance",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("150 m",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Text(
                              "Haibike Sduro FullSeven",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Text("1 Available",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600))
                          ],
                        ),
                      )),
                ],
              ),
            )));
  }
}
