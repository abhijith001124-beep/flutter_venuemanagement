//

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:venuemanagement/login.dart'; // Replace with your actual login page import

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

// ---------- CONTROLLERS ----------
TextEditingController name = TextEditingController();
TextEditingController place = TextEditingController();
TextEditingController phone_no = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
final formkey = GlobalKey<FormState>();

// ---------- API CONFIG ----------
final Dio dio = Dio();
final baseurl = 'http://192.168.1.130:5000'; // replace with your API URL

List dpt = [];
String? selectDeoartment;
int? depid;
String? selectedSemester;
List<String> semesters = ['1', '2', '3', '4', '5', '6'];

// ---------- POST REGISTRATION ----------
Future<void> post_reg(context) async {
  try {
    final response = await dio.post(
      '$baseurl/UserRegAPI',
      data: {
        'Username': email.text,
        'Password': password.text,
        'name': name.text,
        'place': place.text,
        'Phone': phone_no.text,
        'Email': email.text,
        'DEPARTMENT_ID': depid,
        'sem': selectedSemester,
      },
    );
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration successful')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration failed')));
    }
  } catch (e) {
    print("Registration error:$e");
  }
}

class _RegisterState extends State<Register> {
  // ---------- FETCH DEPARTMENTS ----------
  Future<void> get_dpt() async {
    try {
      final response = await dio.get('$baseurl/DptAPI');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          dpt = response.data;
          depid = dpt.isNotEmpty ? dpt[0]['id'] : null;
        });
      }
    } catch (e) {
      print("Department fetching error:$e");
    }
  }

  @override
  void initState() {
    super.initState();
    get_dpt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(240, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'CREATE YOUR ACCOUNT',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Venue Management App',
                    style: TextStyle(color: Color.fromARGB(167, 0, 0, 0)),
                  ),
                  const SizedBox(height: 30),

                  // NAME
                  TextFormField(
                    controller: name,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter your name'
                        : null,
                    decoration: inputStyle("Name"),
                  ),
                  const SizedBox(height: 30),

                  // EMAIL
                  TextFormField(
                    controller: email,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter your Email'
                        : null,
                    decoration: inputStyle("Email"),
                  ),
                  const SizedBox(height: 30),

                  // PHONE
                  TextFormField(
                    controller: phone_no,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter your Phone Number'
                        : null,
                    decoration: inputStyle("Phone"),
                  ),
                  const SizedBox(height: 30),

                  // DEPARTMENT DROPDOWN
                  DropdownButtonFormField<String>(
                    initialValue: selectDeoartment,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Select your Department'
                        : null,
                    items: dpt.map<DropdownMenuItem<String>>((dept) {
                      return DropdownMenuItem<String>(
                        value: dept['Department'],
                        child: Text(dept['Department']),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectDeoartment = value;
                        final selectedDept = dpt.firstWhere(
                          (dept) => dept['Department'] == value,
                          orElse: () => null,
                        );
                        depid = selectedDept != null
                            ? selectedDept['id']
                            : null;
                      });
                    },
                    decoration: dropdownStyle("Department"),
                  ),
                  const SizedBox(height: 30),

                  // SEMESTER DROPDOWN
                  DropdownButtonFormField<String>(
                    value: selectedSemester,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Select Semester'
                        : null,
                    items: semesters.map((sem) {
                      return DropdownMenuItem<String>(
                        value: sem,
                        child: Text("Semester $sem"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSemester = value;
                      });
                    },
                    decoration: dropdownStyle("Semester"),
                  ),

                  const SizedBox(height: 30),

                  // PLACE
                  TextFormField(
                    controller: place,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter your Place'
                        : null,
                    decoration: inputStyle("Place"),
                  ),
                  const SizedBox(height: 30),

                  // PASSWORD
                  TextFormField(
                    controller: password,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter your Password'
                        : null,
                    obscureText: true,
                    decoration: inputStyle("Password"),
                  ),
                  const SizedBox(height: 40),

                  // REGISTER BUTTON
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        if (selectDeoartment != null) {
                          post_reg(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Select your department'),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 60),
                      backgroundColor: const Color.fromARGB(255, 128, 191, 243),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // LOGIN LINK
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- REUSABLE INPUT STYLES ----------
InputDecoration inputStyle(String label) {
  return InputDecoration(
    label: Text(label),
    fillColor: const Color.fromARGB(255, 250, 251, 251),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Colors.blue, width: 3),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    ),
  );
}

InputDecoration dropdownStyle(String label) {
  return InputDecoration(
    label: Text(label),
    fillColor: const Color.fromARGB(255, 250, 251, 251),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Colors.blue, width: 3),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    ),
  );
}
