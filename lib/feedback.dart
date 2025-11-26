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
  double rating = 0; // ⭐ added variable

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
      backgroundColor: const Color(0xFFF3F5F9),

      appBar: AppBar(
        title: const Text(
          "Feedback",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 4,
        shadowColor: Colors.black45,
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          // ⭐⭐⭐⭐⭐ STAR RATING (ADDED)
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                    size: 32,
                    color: (index < rating) ? Colors.orange : Colors.grey,
                  ),
                );
              }),
            ),
          ),

          // 📅 DATE PICKER FIELD (ADDED)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Select Date",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  // dateController.text =
                  //     "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  dateController.text =
                      "${picked.day}-${picked.month}-${picked.year}";
                }
              },
            ),
          ),

          // EXISTING FEEDBACK TEXT FIELD (UNCHANGED)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: feedback,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write your feedback...",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.blue.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // EXISTING BUTTON (UNCHANGED)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 50),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 3,
            ),
            onPressed: () {
              post_feedback(
                feedback.text,
                rating,
                dateController.text,
                context,
              );
            },
            child: const Text(
              "Send",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
