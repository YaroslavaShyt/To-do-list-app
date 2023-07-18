import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskapp/constants/colors.dart';
import 'package:taskapp/constants/font_styling.dart';
import '../tabs/tabs_screen.dart';
import 'register_screen.dart';
import 'package:flutter/material.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                    bottom: -90,
                    right: -50,
                    child: Image.asset(height: 400, 'assets/images/blobs/blob_pink.png')),
                Positioned(
                  top: -25,
                  left: -40,
                  child: Image.asset(
                      height: 200,
                      'assets/images/blobs/blob_green.png'),
                ),
                Positioned(
                  top: 300,
                    left: 0,
                    right: 0,
                    child: Image.asset(height: 300, 'assets/images/blobs/blob_orange.png')),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 70,),
                        const Text('Login', style: FontStyling.nunitoBold),
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.black)
                              ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.black)
                                ),
                                labelText: 'Insert email'
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration:
                            InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.black)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.black)
                                ),
                                labelText: 'Insert password'
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Password should be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: AppColors.lightGreen,
                            onPressed: () {
                              final isValid = _formKey.currentState!.validate();
                              _auth.signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text
                              ).then((value) {
                                GetStorage().write('token', value.user!.uid);
                                GetStorage().write('email', value.user!.email);
                                Navigator.pushReplacementNamed(context, TabsScreen.id);
                              }).onError((error, stackTrace){
                                var snackBar = SnackBar(
                                  duration: const Duration(milliseconds: 5000),
                                    content: Text(
                                        'An Error occurred: $error',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  backgroundColor: AppColors.pink,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              });
                            },
                            child: const Text('Login', style: FontStyling.nunitoRegularSmall,),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(RegisterScreen.id);
                            },
                            child: const Text('Don\'t have an Account?')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(ForgotPasswordScreen.id);
                            },
                            child: const Text('Forget Password')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
