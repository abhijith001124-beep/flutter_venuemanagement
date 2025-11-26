import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:venuemanagement/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

TextEditingController name = TextEditingController();
TextEditingController place = TextEditingController();
TextEditingController phone_no = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController Select_department = TextEditingController();
final formkey = GlobalKey<FormState>();
final Dio dio = Dio();
final baseurl = 'http://192.168.1.189:5000';
List dpt = [];
String? selectDeoartment;
int? depid;

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
  Future<void> get_dpt(context) async {
    try {
      final response = await dio.get('$baseurl/DptAPI');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          dpt = response.data;
          depid = dpt[0]['id'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Department fetching failed')),
        );
      }
    } catch (e) {
      print("Department fetching error:$e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_dpt(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Student Registration",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black45,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              // CARD container for styling
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Name:",
                          filled: true,
                          fillColor: Color(0xFFF0F4F8),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 14,
                          ),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your place';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Place:",
                          filled: true,
                          fillColor: Color(0xFFF0F4F8),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 14,
                          ),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your phone no';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Phone no:",
                          filled: true,
                          fillColor: Color(0xFFF0F4F8),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 14,
                          ),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email:",
                          filled: true,
                          fillColor: Color(0xFFF0F4F8),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    // PASSWORD
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password:",
                          filled: true,
                          fillColor: Color(0xFFF0F4F8),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    DropdownButtonFormField<String>(
                      initialValue: selectDeoartment,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select your Department ';
                        }
                        return null;
                      },
                      items: dpt.map<DropdownMenuItem<String>>((dept) {
                        return DropdownMenuItem<String>(
                          value: dept['Department'], // ✅ display name
                          child: Text(dept['Department']),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectDeoartment = value;

                          // Find the department object with matching name
                          final selected = dpt.firstWhere(
                            (dept) => dept['Department'] == value,
                            orElse: () => null,
                          );

                          depid = selected != null ? selected['id'] : null;
                          print(
                            'Selected Department: $selectDeoartment, ID: $depid',
                          );
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        fillColor: const Color.fromARGB(255, 250, 251, 251),
                        filled: true,
                        label: Text('Department'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // REGISTER BUTTON
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          if (selectDeoartment != null) {
                            post_reg(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('select your department')),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // LOGIN ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 16),
                  ),
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
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
