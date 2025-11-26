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

import 'package:flutter/material.dart';

TextEditingController name = TextEditingController();
TextEditingController place = TextEditingController();
TextEditingController phone_no = TextEditingController();
TextEditingController email = TextEditingController();

class EditProfile extends StatefulWidget {
  final Map profileData;

  const EditProfile({super.key, required this.profileData});

  @override
  State<EditProfile> createState() => _editprofileState();
}

class _editprofileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();

    // Fill text fields with passed data
    name.text = widget.profileData["name"] ?? "";
    place.text = widget.profileData["place"] ?? "";
    phone_no.text = widget.profileData["Phone"].toString() ?? "";
    email.text = widget.profileData["Email"] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
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

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // NAME
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: "Name",
                        filled: true,
                        fillColor: const Color(0xFFF0F4F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  // PLACE
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: place,
                      decoration: InputDecoration(
                        hintText: "Place",
                        filled: true,
                        fillColor: const Color(0xFFF0F4F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  // PHONE
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phone_no,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        filled: true,
                        fillColor: const Color(0xFFF0F4F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  // EMAIL
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: const Color(0xFFF0F4F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
