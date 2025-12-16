import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:venuemanagement/login.dart';
import 'package:venuemanagement/register.dart';

class event_Apply extends StatefulWidget {
  const event_Apply({super.key});

  @override
  State<event_Apply> createState() => _event_ApplyState();
}

bool _isLoading = false;
List eventApply = [];
Dio dio = Dio();

class _event_ApplyState extends State<event_Apply> {
  Future<void> get_eventApply(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await dio.get('$baseurl/EventApplyAPI/$lid');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          eventApply = response.data;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('eventApply fetching failed')),
        );
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
    // TODO: implement initState
    super.initState();
    get_eventApply(context);
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
              'Event Applyed',
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
                      itemCount: eventApply.length,
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
                              // title: Padding(
                              //   padding: const EdgeInsets.only(bottom: 8.0),
                              //   child: Text(
                              //     eventApply[index][''] ?? '',
                              //     style: const TextStyle(
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Event Name:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        eventApply[index]['event_name'] ?? '',
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
                                        eventApply[index]['status'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
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
