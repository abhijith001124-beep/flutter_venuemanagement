// import 'package:flutter/material.dart';
// import 'package:venuemanagement/home.dart';
// import 'package:venuemanagement/register.dart';
// import 'package:dio/dio.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// int? lid;

// class _LoginState extends State<Login> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final _formkey = GlobalKey<FormState>();

//   bool _isLoading = false; // 👈 Loading indicator state
//   bool _passwordVisible = false; // 👈 Password visibility state

//   Future<void> post_log(BuildContext context) async {
//     setState(() {
//       _isLoading = true; // start loading
//     });

//     try {
//       final response = await dio.post(
//         '$baseurl/LoginAPI',
//         data: {
//           'Username': usernameController.text,
//           'Password': passwordController.text,
//         },
//       );

//       print(response.data);
//       lid = response.data["login_id"];

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage()),
//         );

//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Login successful')));
//       } else {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Login failed')));
//       }
//     } catch (e) {
//       print("Login error: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Error: Credentials error')));
//     }

//     setState(() {
//       _isLoading = false; // stop loading
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE8F0FE),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         title: const Text(
//           "Login",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(22.0),
//             child: Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 14,
//                     spreadRadius: 2,
//                     offset: Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Form(
//                 key: _formkey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       "Welcome Back!",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                     const SizedBox(height: 25),

//                     /// USERNAME FIELD
//                     TextFormField(
//                       controller: usernameController,
//                       validator: (value) =>
//                           value!.isEmpty ? 'Enter username' : null,
//                       decoration: InputDecoration(
//                         labelText: "Username",
//                         prefixIcon: const Icon(Icons.person),
//                         filled: true,
//                         fillColor: const Color(0xFFF5F7FA),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: const BorderSide(
//                             color: Colors.blue,
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 18),

//                     /// PASSWORD FIELD WITH VISIBILITY TOGGLE
//                     TextFormField(
//                       controller: passwordController,
//                       validator: (value) =>
//                           value!.isEmpty ? 'Enter your password' : null,
//                       obscureText: !_passwordVisible,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         prefixIcon: const Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _passwordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _passwordVisible = !_passwordVisible;
//                             });
//                           },
//                         ),
//                         filled: true,
//                         fillColor: const Color(0xFFF5F7FA),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: const BorderSide(
//                             color: Colors.blue,
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 30),

//                     /// LOGIN BUTTON WITH LOADING INDICATOR
//                     SizedBox(
//                       height: 50,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           elevation: 3,
//                         ),
//                         onPressed: _isLoading
//                             ? null
//                             : () {
//                                 if (_formkey.currentState!.validate()) {
//                                   post_log(context);
//                                 }
//                               },
//                         child: _isLoading
//                             ? const CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               )
//                             : const Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   fontSize: 19,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Don't have an account?",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Register(),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             "Register",
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:venuemanagement/home.dart';
import 'package:venuemanagement/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

int? lid;
// Dio dio = Dio();
// String baseurl = "YOUR_BASE_URL"; // <-- Put your URL

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _passwordVisible = false;

  Future<void> post_log(BuildContext context) async {
    setState(() => _isLoading = true);

    try {
      final response = await dio.post(
        '$baseurl/LoginAPI',
        data: {
          'Username': usernameController.text,
          'Password': passwordController.text,
        },
      );

      print(response.data);
      lid = response.data["login_id"];

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successful')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login failed')));
      }
    } catch (e) {
      print("Login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Credentials incorrect')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/venue1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 150),

                    /// TITLE
                    const Text(
                      'LOG IN TO \n YOUR ACCOUNT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    const Text(
                      'Venue Management App',
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 40),

                    /// USERNAME FIELD
                    TextFormField(
                      controller: usernameController,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your username' : null,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        label: const Text(
                          'Username',
                          style: TextStyle(color: Colors.white),
                        ),
                        fillColor: Colors.black54,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// PASSWORD FIELD
                    TextFormField(
                      controller: passwordController,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your password' : null,
                      obscureText: !_passwordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        label: const Text(
                          'Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        fillColor: Colors.black54,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// LOGIN BUTTON WITH LOADING INDICATOR
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formkey.currentState!.validate()) {
                                post_log(context);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 60),
                        backgroundColor: const Color.fromARGB(
                          255,
                          27,
                          150,
                          251,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            )
                          : const Text(
                              'SIGN IN',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),

                    const SizedBox(height: 140),

                    /// REGISTER LINK
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.lightBlueAccent),
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
      ),
    );
  }
}
