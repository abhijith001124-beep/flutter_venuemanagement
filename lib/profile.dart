import 'package:flutter/material.dart';
import 'package:venuemanagement/editprofile.dart';
import 'package:venuemanagement/login.dart';
import 'package:venuemanagement/register.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

bool _isLoading = false;

List profils = [];

class _ViewProfileState extends State<ViewProfile> {
  Future<void> get_profile(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await dio.get(
        '$baseurl/ProfileApi',
        data: {"userid": lid},
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //  ScaffoldMessenger.of(
        //     context,
        //   ).showSnackBar(const SnackBar(content: Text('Login successful')));
        setState(() {
          profils = response.data;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('profile fetching failed')),
        );
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
    get_profile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),

      appBar: AppBar(
        title: const Text(
          "Profile Management",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black45,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // PROFILE PHOTO
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 60, color: Colors.blue),
              ),
            ),

            const SizedBox(height: 40),

            // CARD SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Card(
                elevation: 5,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.person_2_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Name: ${profils[0]["name"]}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.place, color: Colors.blue),
                      title: Text(
                        'Place: ${profils[0]["place"]}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.blue),
                      title: Text(
                        'Phone no: ${profils[0]["Phone"]}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.blue),
                      title: Text(
                        'Email: ${profils[0]["Email"]}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // EDIT BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(150, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 3,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(
                      profileData: profils[0], // <-- sending profile data
                    ),
                  ),
                );
              },
              child: const Text(
                "Edit",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
