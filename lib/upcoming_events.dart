import 'package:flutter/material.dart';
import 'package:venuemanagement/register.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

bool _isLoading = false;

List events = [];

class _UpcomingEventsState extends State<UpcomingEvents> {
  Future<void> get_event(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await dio.get('$baseurl/EventApi');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //  ScaffoldMessenger.of(
        //     context,
        //   ).showSnackBar(const SnackBar(content: Text('Login successful')));
        setState(() {
          events = response.data;
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('events fetching failed')));
      }
    } catch (e) {
      print("Login error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error: Credentials error')));
    }

    setState(() {
      _isLoading = false; // stop loading
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_event(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),

      appBar: AppBar(
        title: const Text(
          "Upcoming Events",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black26,
      ),

      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Card(
              elevation: 5,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      'https://plus.unsplash.com/premium_photo-1683910767532-3a25b821f7ae?q=80&w=808&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // EVENT TITLE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          'Event:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        Text(events[index]['event']),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  // DESCRIPTION
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Text(
                          'Description:',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        Text(events[index]['Description']),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  // STATUS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Text(
                          'Status:',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        Text(events[index]['status']),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  // DATE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Text(
                          'Date:',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        Text(events[index]['date']),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
