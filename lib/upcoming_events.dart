// import 'package:flutter/material.dart';
// import 'package:venuemanagement/register.dart';

// class UpcomingEvents extends StatefulWidget {
//   const UpcomingEvents({super.key});

//   @override
//   State<UpcomingEvents> createState() => _UpcomingEventsState();
// }

// bool _isLoading = false;

// List events = [];

// class _UpcomingEventsState extends State<UpcomingEvents> {
//   Future<void> get_event(BuildContext context) async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final response = await dio.get('$baseurl/EventApi');
//       print(response.data);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         //  ScaffoldMessenger.of(
//         //     context,
//         //   ).showSnackBar(const SnackBar(content: Text('Login successful')));
//         setState(() {
//           events = response.data;
//         });
//       } else {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('events fetching failed')));
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
//     get_event(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F5F9),

//       appBar: AppBar(
//         title: const Text(
//           "Upcoming Events",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//         ),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         elevation: 4,
//         shadowColor: Colors.black26,
//       ),

//       body: ListView.builder(
//         itemCount: events.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//             child: Card(
//               elevation: 5,
//               shadowColor: Colors.black26,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),

//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // IMAGE
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(16),
//                     ),
//                     child: Image.network(
//                       'https://plus.unsplash.com/premium_photo-1683910767532-3a25b821f7ae?q=80&w=808&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//                       height: 180,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // EVENT TITLE
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Event:',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue.shade700,
//                           ),
//                         ),
//                         Text(events[index]['event']),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   // DESCRIPTION
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Row(
//                       children: [
//                         const Text(
//                           'Description:',
//                           style: TextStyle(fontSize: 15, color: Colors.black87),
//                         ),
//                         Text(events[index]['Description']),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   // STATUS
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Row(
//                       children: [
//                         const Text(
//                           'Status:',
//                           style: TextStyle(fontSize: 15, color: Colors.black87),
//                         ),
//                         Text(events[index]['status']),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   // DATE
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Row(
//                       children: [
//                         const Text(
//                           'Date:',
//                           style: TextStyle(fontSize: 15, color: Colors.black87),
//                         ),
//                         Text(events[index]['date']),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 16),
//                 ],
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
import 'package:venuemanagement/login.dart';
import 'package:venuemanagement/register.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

bool _isLoading = false;
List events = [];
Dio dio = Dio();

class _UpcomingEventsState extends State<UpcomingEvents> {
  Future<void> apply_event(int eventid, BuildContext context) async {
    try {
      final response = await dio.post(
        '$baseurl/book/$lid',
        data: {"EVENT": eventid},
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text(' apply sucees')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text(' apply failed')));
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

  Future<void> get_event(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await dio.get('$baseurl/EventApi');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          events = response.data;
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Events fetching failed')));
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
    get_event(context);
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
              'EVENTS',
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
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.black26,
                            child: ListTile(
                              leading: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.white,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  events[index]['event'] ?? '',
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
                                        'Description:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        events[index]['Description'] ?? '',
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
                                        'Status:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        events[index]['status'] ?? '',
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
                                        'venue:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        events[index]['venu_name'] ?? '',
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
                                        'date:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          events[index]['date'] ?? '',
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Text(
                                        'time:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          events[index]['time'] ?? '',
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: _isLoading
                                        ? null
                                        : () {
                                            apply_event(
                                              events[index]['id'],
                                              context,
                                            );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(80, 40),
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        27,
                                        150,
                                        251,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: _isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          )
                                        : const Text(
                                            'Apply',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
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
