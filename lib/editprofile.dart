// import 'package:flutter/material.dart';

// class editprofile extends StatefulWidget {
//   const editprofile({super.key});

//   @override
//   State<editprofile> createState() => _editprofileState();
// }

// TextEditingController name = TextEditingController();
// TextEditingController place = TextEditingController();
// TextEditingController phone_no = TextEditingController();
// TextEditingController email = TextEditingController();

// class _editprofileState extends State<editprofile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Edit Profile",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         elevation: 4,
//         shadowColor: Colors.black45,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 40),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 15),
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 12,
//                     spreadRadius: 2,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),

//               child: Column(
//                 children: [
//                   // NAME
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: name,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter your name';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Name:",
//                         filled: true,
//                         fillColor: Color(0xFFF0F4F8),
//                         contentPadding: EdgeInsets.symmetric(
//                           vertical: 18,
//                           horizontal: 14,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // PLACE
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: place,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter your place';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Place:",
//                         filled: true,
//                         fillColor: Color(0xFFF0F4F8),
//                         contentPadding: EdgeInsets.symmetric(
//                           vertical: 18,
//                           horizontal: 14,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // PHONE
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: phone_no,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter your phone no';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Phone no:",
//                         filled: true,
//                         fillColor: Color(0xFFF0F4F8),
//                         contentPadding: EdgeInsets.symmetric(
//                           vertical: 18,
//                           horizontal: 14,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // EMAIL
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: email,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter your email';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Email:",
//                         filled: true,
//                         fillColor: Color(0xFFF0F4F8),
//                         contentPadding: EdgeInsets.symmetric(
//                           vertical: 18,
//                           horizontal: 14,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:venuemanagement/login.dart';
// import 'package:venuemanagement/register.dart';

// TextEditingController name = TextEditingController();
// TextEditingController place = TextEditingController();
// TextEditingController phone_no = TextEditingController();
// TextEditingController email = TextEditingController();

// class EditProfile extends StatefulWidget {
//   final Map profileData;

//   const EditProfile({super.key, required this.profileData});

//   @override
//   State<EditProfile> createState() => _editprofileState();
// }

// bool _isLoading = false;

// List edit = [];

// class _editprofileState extends State<EditProfile> {
//   Future<void> post_editProfile() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final response = await dio.post(
//         "$baseurl/editprofileApi/$lid",
//         data: {
//           "name": name.text,
//           "place": place.text,
//           "Phone": phone_no.text,
//           "Email": email.text,
//           // "id": lid,
//         },
//       );
//       print(response.data);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Profile edited successful')),
//         );
//         setState(() {
//           edit = response.data;
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('profile fetching failed')),
//         );
//       }
//     } catch (e) {
//       print("Login error: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Error: Credentials error')));
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();

//     // Fill text fields with passed data
//     name.text = widget.profileData["name"] ?? "";
//     place.text = widget.profileData["place"] ?? "";
//     phone_no.text = widget.profileData["Phone"].toString() ?? "";
//     email.text = widget.profileData["Email"] ?? "";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Edit Profile",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         elevation: 4,
//         shadowColor: Colors.black45,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 40),

//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 15),
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 12,
//                     spreadRadius: 2,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // NAME
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: name,
//                       decoration: InputDecoration(
//                         hintText: "Name",
//                         labelText: "Name",
//                         filled: true,
//                         fillColor: const Color(0xFFF0F4F8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // PLACE
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: place,
//                       decoration: InputDecoration(
//                         hintText: "Place",
//                         labelText: "Place",
//                         filled: true,
//                         fillColor: const Color(0xFFF0F4F8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // PHONE
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: phone_no,
//                       decoration: InputDecoration(
//                         hintText: "Phone Number",
//                         labelText: "Phone Number",
//                         filled: true,
//                         fillColor: const Color(0xFFF0F4F8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // EMAIL
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       readOnly: true,
//                       controller: email,
//                       decoration: InputDecoration(
//                         hintText: "Email",
//                         labelText: "Email",
//                         filled: true,
//                         fillColor: const Color(0xFFF0F4F8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                       minimumSize: const Size(150, 48),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       elevation: 3,
//                     ),
//                     onPressed: () {
//                       post_editProfile();
//                     },
//                     child: Text("Edit"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:venuemanagement/login.dart';
import 'package:venuemanagement/register.dart';

TextEditingController name = TextEditingController();
TextEditingController place = TextEditingController();
TextEditingController phone_no = TextEditingController();
TextEditingController email = TextEditingController();

class EditProfile extends StatefulWidget {
  final Map profileData;

  const EditProfile({super.key, required this.profileData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

bool _isLoading = false;

class _EditProfileState extends State<EditProfile> {
  Dio dio = Dio();

  Future<void> post_editProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await dio.post(
        "$baseurl/editprofileApi/$lid",
        data: {
          "name": name.text,
          "place": place.text,
          "Phone": phone_no.text,
          "Email": email.text,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile edited successfully')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Profile editing failed')));
      }
    } catch (e) {
      print("Edit profile error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error editing profile')));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.profileData["name"] ?? "";
    place.text = widget.profileData["place"] ?? "";
    phone_no.text = widget.profileData["Phone"].toString() ?? "";
    email.text = widget.profileData["Email"] ?? "";
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                'EDIT PROFILE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 60),
              Container(
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // NAME
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: "Name",
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // PLACE
                    TextFormField(
                      controller: place,
                      decoration: InputDecoration(
                        hintText: "Place",
                        labelText: "Place",
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // PHONE
                    TextFormField(
                      controller: phone_no,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // EMAIL (readonly)
                    TextFormField(
                      controller: email,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Email",
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                      onPressed: post_editProfile,
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
