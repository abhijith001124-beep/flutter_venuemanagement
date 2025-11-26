import 'package:flutter/material.dart';
import 'package:venuemanagement/register.dart';

class Notificationpage extends StatefulWidget {
  const Notificationpage({super.key});

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

bool _isLoading = false;

List notifications = [];

class _NotificationpageState extends State<Notificationpage> {
  Future<void> get_notifi(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await dio.get('$baseurl/NotifiApi');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //  ScaffoldMessenger.of(
        //     context,
        //   ).showSnackBar(const SnackBar(content: Text('Login successful')));
        setState(() {
          notifications = response.data;
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
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_notifi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),

      appBar: AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black45,
      ),

      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

            child: Card(
              elevation: 4,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: ListTile(
                title: const Text(
                  'Notification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                subtitle: Text(
                  notifications[index]['Notification'],
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                trailing: Text(notifications[index]['Date']),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.notifications, color: Colors.blue),
                ),
              ),
            ),
          );
        },
        itemCount: 4,
      ),
    );
  }
}
