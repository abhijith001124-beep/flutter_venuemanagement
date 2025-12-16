// import 'package:flutter/material.dart';
// import 'package:venuemanagement/feedback.dart';
// import 'package:venuemanagement/login.dart';
// import 'package:venuemanagement/notification.dart';
// import 'package:venuemanagement/profile.dart';
// import 'package:venuemanagement/upcoming_events.dart';
// import 'package:venuemanagement/view_venue.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(
//         0xFFEAF2FF,
//       ), // soft student-friendly background

//       appBar: AppBar(
//         title: const Text(
//           "Student Home",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         elevation: 4,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 20),

//             // Profile Management Card
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 leading: const Icon(Icons.person, size: 30, color: Colors.blue),
//                 title: const Text(
//                   "Profile Management",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ViewProfile()),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 15),

//             // Upcoming Events Card
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 leading: const Icon(Icons.event, size: 30, color: Colors.blue),
//                 title: const Text(
//                   "Upcoming Events",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => UpcomingEvents()),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 15),

//             // Notification Card
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 leading: const Icon(
//                   Icons.notifications,
//                   size: 30,
//                   color: Colors.blue,
//                 ),
//                 title: const Text(
//                   "Notification",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Notificationpage()),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 15),

//             // View Venues Card
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 leading: const Icon(
//                   Icons.location_on,
//                   size: 30,
//                   color: Colors.blue,
//                 ),
//                 title: const Text(
//                   "View Venues",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ViewVenue()),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 30),

//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 leading: const Icon(
//                   Icons.star_border,
//                   size: 30,
//                   color: Colors.blue,
//                 ),
//                 title: const Text(
//                   "Feedback",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Feedbackpage()),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 30),

//             // Logout Card
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 leading: const Icon(Icons.logout, size: 30, color: Colors.red),
//                 title: const Text(
//                   "Logout",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red,
//                   ),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios),
//                 onTap: () {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => Login()),
//                     (route) => false,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:venuemanagement/event_apply.dart' hide dio;
import 'package:venuemanagement/feedback.dart';
import 'package:venuemanagement/login.dart';
import 'package:venuemanagement/notification.dart';
import 'package:venuemanagement/profile.dart';
import 'package:venuemanagement/register.dart';
import 'package:venuemanagement/upcoming_events.dart' hide dio;
import 'package:venuemanagement/view_venue.dart' hide dio;

// Dio dio = Dio();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  Map<String, dynamic>? latestEvent;

  @override
  void initState() {
    super.initState();
    _fetchLatestEvent();
  }

  Future<void> _fetchLatestEvent() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await dio.get('$baseurl/EventApi'); // replace $baseurl
      if (response.statusCode == 200 || response.statusCode == 201) {
        List events = response.data;
        if (events.isNotEmpty) {
          // Assuming events are sorted by date in API, otherwise sort here
          events.sort((a, b) {
            return DateTime.parse(
              b['date'],
            ).compareTo(DateTime.parse(a['date']));
          });
          latestEvent = events.first;
        } else {
          latestEvent = null;
        }
      } else {
        latestEvent = null;
      }
    } catch (e) {
      print("Error fetching events: $e");
      latestEvent = null;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/venue1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // 🔵 FIXED TOP SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false,
                        );
                      },
                      child: Card(
                        color: Colors.black12,
                        child: Row(
                          children: const [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.logout_outlined,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Log Out",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Feedbackpage(),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.black12,
                        child: Row(
                          children: const [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.star_half,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Feedback",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 🔵 SCROLLABLE MIDDLE SECTION
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 90),
                      const Text(
                        'HOME',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      const Text(
                        'Venue Management App',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 50),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.black45,
                          child: ListTile(
                            leading: const Icon(
                              Icons.event_seat,
                              color: Colors.white,
                            ),
                            title: const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                'UPCOMING EVENT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : (latestEvent == null)
                                ? const Text(
                                    "No upcoming events",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        latestEvent!['event'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      // Text(
                                      //   "Venue: ${latestEvent!['venue'] ?? ''}",
                                      //   style: const TextStyle(
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
                                      // const SizedBox(height: 5),
                                      // Text(
                                      //   "Date: ${latestEvent!['date'] ?? ''}",
                                      //   style: const TextStyle(
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // HORIZONTAL SCROLL BUTTONS
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 16,
                          right: 16,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _homeIconButton(
                                icon: Icons.calendar_month,
                                label: "EVENTS",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpcomingEvents(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 30),
                              _homeIconButton(
                                icon: Icons.business,
                                label: "VENUES",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewVenue(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 30),
                              _homeIconButton(
                                icon: Icons.business,
                                label: "Booking History",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => event_Apply(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // 🔵 FIXED BOTTOM SECTION
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    _homeBottomCard(
                      icon: Icons.person,
                      label: "PROFILE",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewProfile(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    _homeBottomCard(
                      icon: Icons.notifications_active,
                      label: "NOTIFICATION",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Notificationpage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ICON BUTTON
  Widget _homeIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 95,
        width: 95,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BOTTOM CARD
  Widget _homeBottomCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 90,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(icon, color: Colors.black, size: 32),
            ),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
