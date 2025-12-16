// import 'package:flutter/material.dart';
// import 'package:venuemanagement/register.dart';

// class ViewVenue extends StatefulWidget {
//   const ViewVenue({super.key});

//   @override
//   State<ViewVenue> createState() => _ViewVenueState();
// }

// bool _isLoading = false;

// List venues = [];

// class _ViewVenueState extends State<ViewVenue> {
//   Future<void> get_venue(BuildContext context) async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final response = await dio.get('$baseurl/VenueApi');
//       print(response.data);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         //  ScaffoldMessenger.of(
//         //     context,
//         //   ).showSnackBar(const SnackBar(content: Text('Login successful')));
//         setState(() {
//           venues = response.data;
//         });
//       } else {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('venue fetching failed')));
//       }
//     } catch (e) {
//       print("Login error: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Error: Credentials error')));
//     }

//     setState(() {
//       _isLoading = false; // stop loading
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get_venue(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F5F9),

//       appBar: AppBar(
//         title: const Text(
//           "Venue",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         elevation: 4,
//         shadowColor: Colors.black26,
//       ),

//       body: ListView.builder(
//         itemCount: venues.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

//             child: Card(
//               elevation: 5,
//               shadowColor: Colors.black26,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),

//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),

//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Venue :${venues[index]["venue"]}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),

//                     const SizedBox(height: 6),

//                     Text(
//                       'Capacity:${venues[index]["capacity"]}',
//                       style: const TextStyle(
//                         fontSize: 15,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 6),

//                      Text(
//                       'Facilities:${venues[index]["fecilities"]}',
//                       style: TextStyle(fontSize: 15, color: Colors.black87),
//                     ),

//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:venuemanagement/register.dart';

class ViewVenue extends StatefulWidget {
  const ViewVenue({super.key});

  @override
  State<ViewVenue> createState() => _ViewVenueState();
}

bool _isLoading = false;
List venues = [];
Dio dio = Dio();

class _ViewVenueState extends State<ViewVenue> {
  Future<void> get_venue(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await dio.get('$baseurl/VenueApi');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          venues = response.data;
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Venue fetching failed')));
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error: Credentials error')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    get_venue(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/venue1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'VENUES',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Venue Management App',
              style: TextStyle(color: Color.fromARGB(206, 255, 255, 255)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : ListView.builder(
                      itemCount: venues.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.black26,
                            child: ListTile(
                              leading: const Icon(
                                Icons.business_sharp,
                                color: Colors.white,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  venues[index]['venue'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Capacity :',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        venues[index]['capacity'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Text(
                                        'Facilities :',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        venues[index]['fecilities'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Text(
                                        'Location :',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        venues[index]['Location'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
