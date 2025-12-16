// import 'package:flutter/material.dart';
// import 'package:venuemanagement/login.dart';
// import 'package:venuemanagement/register.dart';

// class Feedbackpage extends StatefulWidget {
//   const Feedbackpage({super.key});

//   @override
//   State<Feedbackpage> createState() => _FeedbackpageState();
// }

// bool _isLoading = false;

// TextEditingController feedback = TextEditingController();
// TextEditingController dateController = TextEditingController();

// class _FeedbackpageState extends State<Feedbackpage> {
//   double rating = 0; // ⭐ added variable

//   Future<void> post_feedback(
//     String Feedback,
//     double rating,
//     String date,
//     BuildContext context,
//   ) async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final response = await dio.post(
//         '$baseurl/FeedbackApi',
//         data: {
//           'user_id': lid,
//           "feedback": Feedback,
//           "Rating": rating,
//           "date": date,
//         },
//       );
//       print(response.data);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         feedback.clear();
//         dateController.clear();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Feedback sending failed')),
//         );
//       }
//     } catch (e) {
//       print("Feedback error: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Error: Credentials error')));
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F5F9),

//       appBar: AppBar(
//         title: const Text(
//           "Feedback",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//         elevation: 4,
//         shadowColor: Colors.black45,
//       ),

//       body: Column(
//         children: [
//           const SizedBox(height: 20),

//           // ⭐⭐⭐⭐⭐ STAR RATING (ADDED)
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(5, (index) {
//                 return IconButton(
//                   onPressed: () {
//                     setState(() {
//                       rating = index + 1;
//                     });
//                   },
//                   icon: Icon(
//                     Icons.star,
//                     size: 32,
//                     color: (index < rating) ? Colors.orange : Colors.grey,
//                   ),
//                 );
//               }),
//             ),
//           ),

//           // 📅 DATE PICKER FIELD (ADDED)
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextFormField(
//               controller: dateController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 hintText: "Select Date",
//                 filled: true,
//                 fillColor: Colors.white,
//                 prefixIcon: const Icon(Icons.calendar_today),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               onTap: () async {
//                 DateTime? picked = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2020),
//                   lastDate: DateTime(2100),
//                 );
//                 if (picked != null) {
//                   // dateController.text =
//                   //     "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
//                   dateController.text =
//                       "${picked.day}-${picked.month}-${picked.year}";
//                 }
//               },
//             ),
//           ),

//           // EXISTING FEEDBACK TEXT FIELD (UNCHANGED)
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextFormField(
//               controller: feedback,
//               maxLines: 5,
//               decoration: InputDecoration(
//                 hintText: "Write your feedback...",
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 14,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide(color: Colors.blue.shade200),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: const BorderSide(color: Colors.blue, width: 2),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // EXISTING BUTTON (UNCHANGED)
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(200, 50),
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               elevation: 3,
//             ),
//             onPressed: () {
//               post_feedback(
//                 feedback.text,
//                 rating,
//                 dateController.text,
//                 context,
//               );
//             },
//             child: const Text(
//               "Send",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:venuemanagement/login.dart';
import 'package:venuemanagement/register.dart';

class Feedbackpage extends StatefulWidget {
  const Feedbackpage({super.key});

  @override
  State<Feedbackpage> createState() => _FeedbackpageState();
}

bool _isLoading = false;

TextEditingController feedback = TextEditingController();
TextEditingController dateController = TextEditingController();

class _FeedbackpageState extends State<Feedbackpage> {
  double rating = 3; // default rating

  Future<void> post_feedback(
    String Feedback,
    double rating,
    String date,
    BuildContext context,
  ) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await dio.post(
        '$baseurl/FeedbackApi',
        data: {
          'user_id': lid,
          "feedback": Feedback,
          "Rating": rating,
          "date": date,
        },
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        feedback.clear();
        dateController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback Submitted Successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback sending failed')),
        );
      }
    } catch (e) {
      print("Feedback error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error: Credentials error')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
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
                  'FEEDBACK',
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
                const SizedBox(height: 30),

                // ⭐ Rating
                Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(131, 26, 33, 36),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              rating = index + 1;
                            });
                          },
                          icon: Icon(
                            Icons.star,
                            size: 40,
                            color: (index < rating)
                                ? Colors.yellow
                                : Colors.white,
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 📅 Date Picker
                Container(
                  height: 70,
                  width: 350,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(131, 26, 33, 36),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: dateController,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Select Date",
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(131, 26, 33, 36),
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        dateController.text =
                            "${picked.day}-${picked.month}-${picked.year}";
                      }
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // 📝 Feedback Field
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(131, 26, 33, 36),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: feedback,
                      maxLines: 6,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Write your feedback...",
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: const Color.fromARGB(131, 26, 33, 36),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    post_feedback(
                      feedback.text,
                      rating,
                      dateController.text,
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(220, 50),
                    backgroundColor: const Color.fromARGB(255, 27, 150, 251),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'SUBMIT FEEDBACK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Thanks For Helping Us Improve!',
                  style: TextStyle(color: Color.fromARGB(218, 255, 255, 255)),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
