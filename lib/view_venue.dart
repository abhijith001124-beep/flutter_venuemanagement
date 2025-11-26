import 'package:flutter/material.dart';
import 'package:venuemanagement/register.dart';

class ViewVenue extends StatefulWidget {
  const ViewVenue({super.key});

  @override
  State<ViewVenue> createState() => _ViewVenueState();
}

bool _isLoading = false;

List venues = [];

class _ViewVenueState extends State<ViewVenue> {
  Future<void> get_venue(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await dio.get('$baseurl/VenueApi');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //  ScaffoldMessenger.of(
        //     context,
        //   ).showSnackBar(const SnackBar(content: Text('Login successful')));
        setState(() {
          venues = response.data;
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('venue fetching failed')));
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
    get_venue(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),

      appBar: AppBar(
        title: const Text(
          "Venue",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black26,
      ),

      body: ListView.builder(
        itemCount: venues.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

            child: Card(
              elevation: 5,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16.0),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Venue :${venues[index]["venue"]}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Capacity:${venues[index]["capacity"]}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),

                     Text(
                      'Facilities:${venues[index]["fecilities"]}',
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
