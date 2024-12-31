import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myapp/services/database.dart';
import 'package:myapp/models/user.dart';
import 'weather.dart';
import 'map.dart';
import 'search.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch the current user ID (this should be passed down to the Landing page)
    final user = Provider.of<UserModel?>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Eco-Bike',
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )),
        centerTitle: true,
        leading: Image.asset(
          'assets/images/Asset 1.png',
          fit: BoxFit.contain,
          height: 70,
        ),
        flexibleSpace: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0BB4E3), // Reverse the gradient colors
                  Color(0xFF27EF9E),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(22.0, 5.0, 22.0, 0.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF27EF9E), Color(0xFF0BB4E3)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: StreamProvider<UserModel?>.value(
            value: DatabaseService(uid: user?.uid).userData,
            initialData: null,
            child: Consumer<UserModel?>(
              builder: (context, userData, _) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                AssetImage('assets/images/account.jpg'),
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
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello ${userData?.name ?? 'Guest'}',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4.0,
                                      color: Colors.black.withOpacity(0.25),
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              const Text(
                                'Wanna take a ride today?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Add your desired functionality here

                              print("Unlock Bike button tapped!");
                            },
                            child: Container(
                              width: 120,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6.0,
                                    offset: Offset(2, 4),
                                  ),
                                ],
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF27EF9E),
                                    Color(0xFF0BB4E3),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Unlock Bike",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      WeatherCard(),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "Nearby Bikes",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapScreen()),
                              );
                            },
                            child: const Row(children: [
                              Text(
                                "Browse Map",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 18,
                              )
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
                            child: Column(
                              children: [
                                const Image(
                                    image:
                                        AssetImage('assets/images/Bitmap.png')),
                                SizedBox(height: 20),
                                Container(
                                  width: 196,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Distance",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text("150 m",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                const Text(
                                  "Addis Ababa Science and Technology University",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                const Text("1 Available",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          )),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
