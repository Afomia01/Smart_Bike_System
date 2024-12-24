import 'package:flutter/material.dart';
import 'searchMap.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> locations = [
    "Aberden",
    "Abigar Des",
    "Abualo Ct",
    "Aburel Kalmia",
  ];
  String query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        flexibleSpace: Container(
          height: 255,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
            ),
          ),
        ),
        toolbarHeight: 100.0,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              // gradient: const LinearGradient(
              //   colors: [Colors.teal, Colors.greenAccent],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(12),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.black.withOpacity(0.1),
                  //       blurRadius: 5,
                  //       offset: const Offset(0, 3),
                  //     ),
                  //   ],
                  // ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.purple,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Marbella Dr',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              query = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(12),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.black.withOpacity(0.1),
                  //       blurRadius: 5,
                  //       offset: const Offset(0, 3),
                  //     ),
                  //   ],
                  // ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.near_me,
                          color: Colors.purple,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Ab',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              query = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: locations.length,
              itemBuilder: (context, index) {
                if (locations[index]
                    .toLowerCase()
                    .contains(query.toLowerCase())) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(locations[index]),
                        onTap: () {
                          // Handle selection
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapWithRoute()),
                          );
                          print('Selected ${locations[index]}');
                        },
                      ),
                      const Divider(),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
